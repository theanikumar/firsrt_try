import 'package:flutter/material.dart';

class HomeMainContainer extends StatelessWidget {
  final List<Widget> children;

  const HomeMainContainer({super.key, required this.children});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.only(
        left: 16,
        right: 16,
        top: 0,
        bottom: 16,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          for (int i = 0; i < children.length; i++) ...[
            children[i],
            if (i < children.length - 1) const SizedBox(height: 20),
          ],
        ],
      ),
    );
  }
}
