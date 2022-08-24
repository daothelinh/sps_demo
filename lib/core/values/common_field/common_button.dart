import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
//import 'package:insurance_app/core/config/theme.dart';

enum ButtonType {
  primary,
  primaryNotice,
  primaryDestruction,
  disabled,
  secondary,
  secondaryDestruction,
  plain,
  icon
}

class CommonButton extends StatelessWidget {
  const CommonButton({
    Key? key,
    this.child,
    this.buttonType = ButtonType.primary,
    this.text,
    required this.onPressed,
    this.textStyle,
    this.height = 48,
    this.width = double.infinity,
    this.padding = EdgeInsets.zero,
    this.backgroudColor,
  }) : super(key: key);
  final Widget? child;
  final String? text;
  final ButtonType buttonType;
  final Function()? onPressed;
  final TextStyle? textStyle;
  final double width;
  final double height;
  final EdgeInsetsGeometry padding;
  final Color? backgroudColor;

  @override
  Widget build(BuildContext context) {
    Color? _backgroundColor;
    Color? textColor;
    switch (buttonType) {
      case ButtonType.primary:
        _backgroundColor:
        Colors.white;
        textColor:
        Colors.grey;
        break;
      case ButtonType.primaryNotice:
        _backgroundColor:
        Colors.green[500];
        textColor:
        Colors.grey;
        break;
      case ButtonType.primaryDestruction:
        _backgroundColor:
        Colors.red[500];
        textColor:
        Colors.grey;
        break;
      case ButtonType.disabled:
        _backgroundColor = Colors.transparent;
        textColor:
        Colors.grey;
        break;
      case ButtonType.secondary:
        _backgroundColor:
        Colors.black;
        textColor:
        Colors.grey;
        break;
      case ButtonType.secondaryDestruction:
        _backgroundColor:
        Colors.red[200];
        textColor:
        Colors.red[500];
        break;
      case ButtonType.plain:
        _backgroundColor:
        Colors.grey;
        textColor:
        Colors.black;
        break;
      case ButtonType.icon:
        _backgroundColor:
        Colors.grey;
        textColor:
        Colors.red;
        break;
      default:
    }
    return Container(
      height: 50,
      width: 350,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: CupertinoButton(
        //color: backgroudColor ?? _backgroundColor,
        color: Color.fromARGB(255, 123, 54, 137),
        padding: padding,
        minSize: 0,
        child: child ??
            Text(
              text ?? '',
              //style: t16B.apply(color: textColor),
            ),
        onPressed: buttonType == ButtonType.disabled ? null : onPressed,
      ),
    );
  }
}
