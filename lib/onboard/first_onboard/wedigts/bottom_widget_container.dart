import 'package:flutter/material.dart';

class BottomWidgetContainer extends StatelessWidget {
  final Widget child;

  const BottomWidgetContainer({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.only(top: 24),
      child: child,
    );
  }
}
