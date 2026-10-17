import 'package:flutter/material.dart';
import '../widgets/outer_container.dart';
import '../widgets/main_container.dart';
import '../widgets/upper_container.dart';
import '../widgets/parayan_sankalp_setup.dart';
import '../widgets/pledge_cycle.dart';
import '../widgets/time_selection.dart';
import '../widgets/aarti_reminder.dart';
import '../widgets/sacred_sankalp_button.dart';
import '../../../routes/app_routes.dart';
//import '../../first_onboard/wedigts/sai_vani_tag.dart';

class BottomScreen extends StatefulWidget {
  const BottomScreen({super.key});

  @override
  State<BottomScreen> createState() => _BottomScreenState();
}

class _BottomScreenState extends State<BottomScreen> {
  bool showPledgeCycle = true; // Default: show (7-Day Saptah is selected)

  void _onDurationChanged(bool show7DaySaptah) {
    setState(() {
      showPledgeCycle = show7DaySaptah;
    });
  }

  void _onSankalpButtonPressed() {
    // Navigate to home screen and remove all previous routes (no back to onboarding)
    AppRoutes.replaceWithHome(context);
  }

  @override
  Widget build(BuildContext context) {
    return OuterContainer(
      child: MainContainer(
        children: [
          // Upper container with all the form elements
          UpperContainer(
            children: [
              // Parayan Sankalp Setup
              const ParayanSankalpSetup(),

              // Duration Selector
              DurationSelectorWithCallback(
                onSelectionChanged: _onDurationChanged,
              ),

              // Pledge Cycle (conditional - only show when 7-Day Saptah is selected)
              if (showPledgeCycle) const PledgeCycle(),

              // Time Selection
              const TimeSelection(),

              // Aarti Reminder
              const AartiReminder(),
            ],
          ),

          // Sacred Sankalp Button
          SacredSankalpButton(
            onPressed: _onSankalpButtonPressed,
          ),

          // Sai Vani Tag
          //onst SaiVaniTag(),
        ],
      ),
    );
  }
}

// Wrapper widget for DurationSelector to expose selection callback
class DurationSelectorWithCallback extends StatefulWidget {
  final Function(bool) onSelectionChanged;

  const DurationSelectorWithCallback({
    super.key,
    required this.onSelectionChanged,
  });

  @override
  State<DurationSelectorWithCallback> createState() =>
      _DurationSelectorWithCallbackState();
}

class _DurationSelectorWithCallbackState
    extends State<DurationSelectorWithCallback> {
  int selectedIndex = 0; // 0 for 7-Day Saptah, 1 for 1 Adhyay Daily

  void _onButtonPressed(int index) {
    setState(() {
      selectedIndex = index;
    });
    // Notify parent: show pledge cycle only when 7-Day Saptah (index 0) is selected
    widget.onSelectionChanged(index == 0);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: const Color(0xFFF2EDE6),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          // Button 1: 7-Day Saptah
          Expanded(
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              curve: Curves.easeInOut,
              child: _DurationButton(
                heading: '7-Day Saptah',
                subheading: 'Monday Start',
                isActive: selectedIndex == 0,
                onPressed: () => _onButtonPressed(0),
              ),
            ),
          ),
          const SizedBox(width: 8),
          // Button 2: 1 Adhyay Daily
          Expanded(
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              curve: Curves.easeInOut,
              child: _DurationButton(
                heading: '1 Adhyay Daily',
                subheading: 'Flexible Pace',
                isActive: selectedIndex == 1,
                onPressed: () => _onButtonPressed(1),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _DurationButton extends StatelessWidget {
  final String heading;
  final String subheading;
  final bool isActive;
  final VoidCallback onPressed;

  const _DurationButton({
    required this.heading,
    required this.subheading,
    required this.isActive,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeInOut,
        padding: const EdgeInsets.symmetric(horizontal: 27.5, vertical: 10),
        decoration: BoxDecoration(
          color: isActive ? const Color(0xFFFFFFFF) : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
          boxShadow: isActive
              ? [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    offset: const Offset(0, 1),
                    blurRadius: 2,
                    spreadRadius: 0,
                  ),
                ]
              : null,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Heading
            Text(
              heading,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 14,
                height: 1.43,
                letterSpacing: 0.28,
                color: isActive
                    ? const Color(0xFF9A4100)
                    : const Color(0xFF574238),
                decoration: TextDecoration.none,
              ),
            ),
            // Subheading
            Text(
              subheading,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 10,
                height: 1.4,
                letterSpacing: 0.5,
                color: isActive
                    ? const Color(0xFF765700)
                    : const Color(0xFF574238),
                decoration: TextDecoration.none,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
