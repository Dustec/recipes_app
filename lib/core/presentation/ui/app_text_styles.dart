import 'package:flutter/material.dart';

class AppTextStyles {
  static TextStyle brandTitle(Color color) {
    return TextStyle(
      fontFamily: 'Chewy',
      color: color,
      fontSize: 24,
      fontWeight: FontWeight.bold,
    );
  }

  static TextStyle title(Color color) {
    return TextStyle(
      fontFamily: 'Chewy',
      color: color,
      fontSize: 20,
      fontWeight: FontWeight.bold,
    );
  }

  static TextStyle body(Color color) {
    return TextStyle(color: color, fontSize: 16);
  }
}
