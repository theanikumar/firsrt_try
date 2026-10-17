import 'package:flutter/material.dart';
import 'bottom_btn_inner_container.dart';

class BottomBtmOuterContainer extends StatelessWidget {
  final VoidCallback onButtonPressed;

  const BottomBtmOuterContainer({super.key, required this.onButtonPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.only(top: 4),
      child: BottomBtnInnerContainer(onPressed: onButtonPressed),
    );
  }
}
