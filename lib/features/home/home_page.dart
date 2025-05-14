import 'package:flutter/material.dart';
import 'package:recipes_app/core/presentation/ui/app_colors.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundCream,
      body: Center(child: Text('Home Page')),
    );
  }
}
