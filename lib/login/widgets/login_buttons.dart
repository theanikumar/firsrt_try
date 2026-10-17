import 'package:flutter/material.dart';

class LoginButtons extends StatelessWidget {
  final VoidCallback? onGoogleLogin;
  final VoidCallback? onFacebookLogin;

  const LoginButtons({
    super.key,
    this.onGoogleLogin,
    this.onFacebookLogin,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          // Google Login Button
          _buildLoginButton(
            icon: Icons.g_mobiledata, // Google icon placeholder
            label: 'Continue with Google',
            backgroundColor: const Color(0xFFFFFFFF),
            textColor: const Color(0xFF1D1C18),
            borderColor: const Color(0xFFE5E5E5),
            onTap: onGoogleLogin,
          ),

          const SizedBox(height: 12),

          // Facebook Login Button
          _buildLoginButton(
            icon: Icons.facebook,
            label: 'Continue with Facebook',
            backgroundColor: const Color(0xFFFFFFFF),
            textColor: const Color(0xFF1D1C18),
            borderColor: const Color(0xFFE5E5E5),
            onTap: onFacebookLogin,
          ),
        ],
      ),
    );
  }

  Widget _buildLoginButton({
    required IconData icon,
    required String label,
    required Color backgroundColor,
    required Color textColor,
    required Color borderColor,
    VoidCallback? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: 48,
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: borderColor,
            width: 1,
          ),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF000000).withOpacity(0.05),
              offset: const Offset(0, 1),
              blurRadius: 2,
              spreadRadius: 0,
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: textColor,
              size: 24,
            ),
            const SizedBox(width: 12),
            Text(
              label,
              style: TextStyle(
                fontWeight: FontWeight.w600, // semibold
                fontSize: 14,
                height: 20 / 14, // line height 20
                letterSpacing: 0,
                color: textColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
