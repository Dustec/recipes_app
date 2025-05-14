import 'package:flutter/material.dart';
import 'package:recipes_app/core/presentation/resources/app_images.dart';
import 'package:recipes_app/core/presentation/ui/app_colors.dart';
import 'package:recipes_app/core/presentation/ui/app_text_styles.dart';
import 'package:recipes_app/features/home/home_page.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        Navigator.pushReplacement(
          context,
          PageRouteBuilder(
            pageBuilder:
                (context, animation, secondaryAnimation) => const HomePage(),
            transitionDuration: const Duration(milliseconds: 400),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) =>
                    FadeTransition(opacity: animation, child: child),
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryOrange,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(AppImages.logo, width: 200),
            Text(
              'Recipes App',
              style: AppTextStyles.brandTitle(AppColors.accentYellow),
            ),
          ],
        ),
      ),
    );
  }
}
