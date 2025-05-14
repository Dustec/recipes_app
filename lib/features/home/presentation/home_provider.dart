import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipes_app/di/injector.dart';
import 'package:recipes_app/features/home/presentation/cubit/home_cubit.dart';
import 'package:recipes_app/features/home/presentation/home_page.dart';
import 'package:recipes_app/features/recipes/domain/repositories/recipes_repository.dart';

class HomeProvider extends StatelessWidget {
  const HomeProvider({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create:
          (context) =>
              HomeCubit(recipesRepository: injector.get<RecipesRepository>()),
      child: const HomePage(),
    );
  }
}
