import 'package:flutter/material.dart';

class BottomMiddleInnerContainer extends StatelessWidget {
  final List<Widget> children;

  const BottomMiddleInnerContainer({super.key, required this.children});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          for (int i = 0; i < children.length; i++) ...[
            children[i],
            if (i < children.length - 1) const SizedBox(height: 24),
          ],
        ],
      ),
    );
  }
}
