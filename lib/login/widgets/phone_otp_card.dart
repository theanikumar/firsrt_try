import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../core/auth/auth_provider.dart';
import '../../core/network/api_exception.dart';
import '../../routes/app_routes.dart';

/// Phone + OTP sign-in card. This is the only credential flow in v1.
class PhoneOtpCard extends StatefulWidget {
  const PhoneOtpCard({super.key});

  @override
  State<PhoneOtpCard> createState() => _PhoneOtpCardState();
}

class _PhoneOtpCardState extends State<PhoneOtpCard> {
  final _phoneController = TextEditingController();
  final _codeController = TextEditingController();
  final _codeFocus = FocusNode();

  bool _codeSent = false;
  bool _sending = false;
  bool _verifying = false;
  String? _devCode;
  String? _error;

  String get _phone => _phoneController.text.replaceAll(RegExp(r'\D'), '');

  @override
  void dispose() {
    _phoneController.dispose();
    _codeController.dispose();
    _codeFocus.dispose();
    super.dispose();
  }

  Future<void> _sendCode() async {
    if (_phone.length != 10) {
      setState(() => _error = 'Enter a 10 digit mobile number.');
      return;
    }
    setState(() {
      _sending = true;
      _error = null;
    });
    try {
      final code = await context.read<AuthProvider>().requestOtp(_phone);
      if (!mounted) return;
      setState(() {
        _codeSent = true;
        _devCode = code;
      });
      _codeFocus.requestFocus();
    } on ApiException catch (error) {
      if (!mounted) return;
      setState(() => _error = error.message);
    } finally {
      if (mounted) setState(() => _sending = false);
    }
  }

  Future<void> _verify() async {
    final code = _codeController.text.trim();
    if (code.length != 6) {
      setState(() => _error = 'Enter the 6 digit code.');
      return;
    }
    setState(() {
      _verifying = true;
      _error = null;
    });
    try {
      final auth = context.read<AuthProvider>();
      await auth.verifyOtp(_phone, code);
      if (!mounted) return;
      Navigator.of(context).pushReplacementNamed(
        auth.needsOnboarding ? AppRoutes.onboardingFirst : AppRoutes.home,
      );
    } on ApiException catch (error) {
      if (!mounted) return;
      setState(() => _error = error.message);
    } finally {
      if (mounted) setState(() => _verifying = false);
    }
  }

  void _changeNumber() {
    setState(() {
      _codeSent = false;
      _codeController.clear();
      _devCode = null;
      _error = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            offset: const Offset(0, 2),
            blurRadius: 8,
            spreadRadius: 0,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 36,
                height: 36,
                decoration: const BoxDecoration(
                  color: Color(0xFFFFDDB8),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.phone_android,
                  color: Color(0xFF9A4100),
                  size: 20,
                ),
              ),
              const SizedBox(width: 10),
              const Expanded(
                child: Text(
                  'Continue with your mobile number',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                    color: Color(0xFF1D1C18),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            _codeSent
                ? 'Enter the 6 digit code sent to +91 ${_phoneController.text}.'
                : 'We will send a one-time code. No password needed.',
            style: const TextStyle(
              fontSize: 12,
              height: 1.5,
              color: Color(0xFF574238),
            ),
          ),
          const SizedBox(height: 16),
          if (!_codeSent) ...[
            TextField(
              controller: _phoneController,
              keyboardType: TextInputType.phone,
              autofillHints: const [AutofillHints.telephoneNumber],
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                LengthLimitingTextInputFormatter(10),
              ],
              textInputAction: TextInputAction.done,
              onSubmitted: (_) => _sendCode(),
              decoration: _inputDecoration(
                hint: '98765 43210',
                prefix: '+91 ',
              ),
            ),
            const SizedBox(height: 14),
            _primaryButton(
              label: 'Send OTP',
              busy: _sending,
              onPressed: _sendCode,
            ),
          ] else ...[
            TextField(
              controller: _codeController,
              focusNode: _codeFocus,
              keyboardType: TextInputType.number,
              autofillHints: const [AutofillHints.oneTimeCode],
              textAlign: TextAlign.center,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                LengthLimitingTextInputFormatter(6),
              ],
              style: const TextStyle(
                fontSize: 24,
                letterSpacing: 10,
                fontWeight: FontWeight.w600,
                color: Color(0xFF1D1C18),
              ),
              onSubmitted: (_) => _verify(),
              decoration: _inputDecoration(hint: '______'),
            ),
            const SizedBox(height: 14),
            _primaryButton(
              label: 'Verify & Continue',
              busy: _verifying,
              onPressed: _verify,
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: _sending ? null : _changeNumber,
                  child: const Text('Change number'),
                ),
                TextButton(
                  onPressed: _sending ? null : _sendCode,
                  child: const Text('Resend code'),
                ),
              ],
            ),
            if (_devCode != null)
              Container(
                width: double.infinity,
                margin: const EdgeInsets.only(top: 4),
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  color: const Color(0xFFF8F3EC),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: const Color(0xFFDDC1B3)),
                ),
                child: Text(
                  'Development code: $_devCode',
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF9A4100),
                  ),
                ),
              ),
          ],
          if (_error != null) ...[
            const SizedBox(height: 12),
            Text(
              _error!,
              style: const TextStyle(
                fontSize: 12,
                color: Color(0xFFB3261E),
              ),
            ),
          ],
          const SizedBox(height: 12),
          const Text(
            'By continuing you agree to our Terms of Seva and Privacy Sanctity.',
            style: TextStyle(
              fontSize: 10,
              height: 1.5,
              color: Color(0xFF8A7267),
            ),
          ),
        ],
      ),
    );
  }

  InputDecoration _inputDecoration({required String hint, String? prefix}) {
    return InputDecoration(
      hintText: hint,
      prefixText: prefix,
      prefixStyle: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: Color(0xFF1D1C18),
      ),
      filled: true,
      fillColor: const Color(0xFFF8F3EC),
      counterText: '',
      contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Color(0xFFDDC1B3)),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Color(0xFFDDC1B3)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Color(0xFF9A4100), width: 1.4),
      ),
    );
  }

  Widget _primaryButton({
    required String label,
    required bool busy,
    required VoidCallback onPressed,
  }) {
    return SizedBox(
      width: double.infinity,
      height: 48,
      child: ElevatedButton(
        onPressed: busy ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF9A4100),
          foregroundColor: Colors.white,
          disabledBackgroundColor: const Color(0xFF9A4100).withValues(alpha: 0.6),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(9999),
          ),
          elevation: 0,
        ),
        child: busy
            ? const SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: Colors.white,
                ),
              )
            : Text(
                label,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 15,
                ),
              ),
      ),
    );
  }
}
