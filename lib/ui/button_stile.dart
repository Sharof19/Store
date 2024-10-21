import 'package:first_one/ui/colors.dart';
import 'package:flutter/material.dart';

class ButtonStyles {
  static ButtonStyle orangeButtonStyle = ElevatedButton.styleFrom(
    primary: ButtonColor.buttonColor,
    minimumSize: Size(double.infinity, 50),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(15),
    ),
  );
}
