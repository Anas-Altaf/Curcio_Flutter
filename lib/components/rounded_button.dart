import 'package:curcio/constants.dart';
import 'package:flutter/material.dart';

class RoundButton extends StatelessWidget {
  const RoundButton(
      {super.key,
      required this.symbol,
      required this.onPress,
      this.width = kInputButtonWidth,
      this.height = kInputButtonHeight,
      this.buttonColor = Colors.white,
      this.buttonTextColor = kMainBlueColor,
      this.shapeBorder = const CircleBorder()});
  final String symbol;
  final Function() onPress;
  final double width;
  final double height;
  final Color buttonTextColor;
  final Color buttonColor;
  final ShapeBorder shapeBorder;
  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      onPressed: onPress,
      elevation: 3.0,
      fillColor: buttonColor,
      shape: shapeBorder,
      constraints: BoxConstraints(
        minWidth: width,
        minHeight: height,
      ),
      child: Text(
        symbol,
        style: TextStyle(
          color: buttonTextColor,
          fontSize: 30,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
