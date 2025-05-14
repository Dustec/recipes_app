import 'package:flutter/material.dart';
import 'package:recipes_app/core/presentation/ui/app_colors.dart';
import 'package:recipes_app/di/injector.dart';
import 'package:recipes_app/features/recipes/domain/repositories/recipes_repository.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final RecipesRepository recipesRepository = injector.get();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundCream,
      body: Center(child: Text('Home Page')),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          recipesRepository
              .getMealsByLetter('b')
              .listen(
                (meals) {
                  print('onData');
                },
                onError: (error) {
                  print('onError $error');
                },
              );
        },
      ),
    );
  }
}
