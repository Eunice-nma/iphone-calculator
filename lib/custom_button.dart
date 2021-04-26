import 'package:flutter/material.dart';
import 'constants.dart';

class CustomButton extends StatelessWidget {
  CustomButton({this.onPressed, this.buttonText, this.buttonColor});
  final Function onPressed;
  final String buttonText;
  final Color buttonColor;
  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      constraints: BoxConstraints(
        minHeight: 80.0,
        minWidth: buttonText == '=' ? 175 : 80,
      ),
      fillColor: buttonColor,
      onPressed: onPressed,
      child: Text(
        buttonText,
        textAlign: TextAlign.right,
        //textAlign: buttonText=='0'? TextAlign.left: TextAlign.center,
        style: buttonColor == kLightGrey
            ? kTopButtonTextStyle
            : kNumberButtonTextStyle,
      ),
      shape: buttonText == '='
          ? RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(50.0),
        ),
      )
          : CircleBorder(),
    );
  }

}
