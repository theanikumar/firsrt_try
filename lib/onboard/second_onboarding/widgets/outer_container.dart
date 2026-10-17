import 'package:flutter/material.dart';

class OuterContainer extends StatelessWidget {
  final Widget child;

  const OuterContainer({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.only(top: 24),
      child: child,
    );
  }
}
