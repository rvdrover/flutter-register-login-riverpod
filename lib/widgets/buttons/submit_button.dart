import 'package:flutter/material.dart';
import 'package:riverpod_flutter_register_login_firebase/widgets/buttons/custom_elevated_button.dart';

class SubmitButton extends CustomElevatedButton {
  const SubmitButton({
    Key? key,
    required String text,
    Color? buttonColor,
    VoidCallback? onPressed,
    Color? textColor,
    double? fontSize =16,
    String? imagePath,
    IconData? icon,
    Color? iconColor,
    double height=50,
  }) : super(
          key: key,
          text: text,
          fontSize: fontSize,
          buttonColor: buttonColor,
          textColor: textColor,
          onPressed: onPressed,
          imagePath: imagePath,
          icon: icon,
          height: height,
          iconColor: iconColor,
        );
}
