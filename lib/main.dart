import 'package:flutter/material.dart';
import 'package:recipes_app/app.dart';
import 'package:recipes_app/di/injector.dart';

void main() {
  registerDependencies();
  runApp(const App());
}
