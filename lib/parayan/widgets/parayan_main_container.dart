import 'package:flutter/material.dart';

class ParayanMainContainer extends StatelessWidget {
  final List<Widget> children;

  const ParayanMainContainer({
    super.key,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity, // Fill width
      padding: const EdgeInsets.symmetric(horizontal: 16), // Left & right padding 16
      child: Column(
        mainAxisSize: MainAxisSize.min, // Hug height
        children: [
          ...children.expand((child) => [
            child,
            const SizedBox(height: 20), // Gap 20 between children
          ]).toList()
            ..removeLast(), // Remove last gap
        ],
      ),
    );
  }
}
