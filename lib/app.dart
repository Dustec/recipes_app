import 'package:flutter/material.dart';
import 'package:recipes_app/core/presentation/ui/app_colors.dart';
import 'package:recipes_app/features/splash/splash_page.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Recipes App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primaryOrange),
        useMaterial3: true,
      ),
      home: const SplashPage(),
    );
  }
}
