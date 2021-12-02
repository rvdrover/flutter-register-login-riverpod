
import 'package:flutter/material.dart';

@immutable
class CustomElevatedButton extends StatelessWidget {
  const CustomElevatedButton({
    Key? key,
    required this.text,
    this.buttonColor,
    this.textColor,
    this.height = 50.0,
    this.borderRadius = 4.0,
    this.onPressed,
    this.icon,
    this.image,
    this.iconColor,
    this.fontSize=16,
    this.imagePath,
  }) : super(key: key);
  final Color? buttonColor;
  final Color? textColor;
  final double height;
  final double borderRadius;
  final VoidCallback? onPressed;
  final Widget? image;
  final IconData? icon;
  final Color? iconColor;
  final double? fontSize;
  final String text;
  final String? imagePath;

  Widget? _getIconOrImage() {
    if (imagePath != null) {
      return Image.asset(
        imagePath!,
        height: imageOrIconSize(),
      );
    } else if (icon != null) {
      return Icon(
        icon,
        size:imageOrIconSize(),
        color: iconColor,
      );
    }
    return null;
  }

  bool check() {
    if (imagePath != null || icon != null) {
      return false;
    }
    return true;
  }

  double imageOrIconSize() {
    return height - 15;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: ElevatedButton(
        child: check()
            ? Text(
                text,
                style: TextStyle(
                  color: textColor,
                  fontSize: fontSize,
                ),
              )
            : Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                    ),
                    child: _getIconOrImage(),
                  ),
                  Text(
                    text,
                    style: TextStyle(
                      color: textColor,
                      fontSize: fontSize,
                    ),
                  ),
                ],
              ),
        style: ElevatedButton.styleFrom(
          primary: buttonColor,
          textStyle: TextStyle(
            color: textColor,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(borderRadius),
            ),
          ),
        ),
        onPressed: onPressed,
      ),
    );
  }
}
