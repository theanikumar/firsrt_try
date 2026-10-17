import 'package:flutter/material.dart';

class PlayerMainContainer extends StatelessWidget {
  final List<Widget> children;

  const PlayerMainContainer({super.key, required this.children});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: children,
      ),
    );
  }
}
