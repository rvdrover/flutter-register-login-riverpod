import 'package:flutter/material.dart';

import 'custom_elevated_button.dart';

class FormSubmitButton extends CustomElevatedButton {
  const FormSubmitButton({
    Key? key,
    required String text,
    VoidCallback? onPressed,
    double? fontSize =16,
    Color? textColor,
    Color? buttonColor,
    String? imagePath,
    IconData? icon,
    double height=50,
  }) : super(
          key: key,
          text: text,
          height: height,
          buttonColor: Colors.indigo,
          textColor: Colors.black87,
          onPressed: onPressed,
          fontSize: fontSize,
          imagePath: imagePath,
          icon: icon,

        );
}