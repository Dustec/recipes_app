import 'package:flutter/material.dart';

class AppTextStyles extends TextStyle {
  const AppTextStyles._({
    required super.fontFamily,
    required super.fontSize,
    required super.fontWeight,
    required super.color,
    required super.decoration,
  });

  static AppTextStyles brandTitle(Color color) => AppTextStyles._(
    fontFamily: 'Chewy',
    fontSize: 24,
    fontWeight: FontWeight.w700,
    color: color,
    decoration: TextDecoration.none,
  );
}
