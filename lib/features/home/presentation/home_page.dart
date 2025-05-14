import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipes_app/core/presentation/resources/app_images.dart';
import 'package:recipes_app/core/presentation/ui/app_colors.dart';
import 'package:recipes_app/core/presentation/ui/app_text_styles.dart';
import 'package:recipes_app/features/home/presentation/cubit/home_cubit.dart';
import 'package:recipes_app/features/recipes/presentation/widgets/recipe_tile.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundCream,

      appBar: AppBar(
        backgroundColor: AppColors.primaryOrange,
        title: Row(
          children: [
            Hero(
              tag: 'brand-logo',
              child: Image.asset(
                AppImages.logo,
                width: 50,
                height: 40,
                fit: BoxFit.fitWidth,
              ),
            ),
            const SizedBox(width: 6),
            Text(
              'Recipes App',
              style: AppTextStyles.brandTitle(AppColors.white),
            ),
          ],
        ),
      ),

      body: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          if (state.isLoading && state.meals.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }

          return NotificationListener<ScrollNotification>(
            onNotification: (ScrollNotification scrollInfo) {
              if (scrollInfo is ScrollEndNotification) {
                if (scrollInfo.metrics.pixels >=
                    scrollInfo.metrics.maxScrollExtent * 0.8) {
                  context.read<HomeCubit>().loadMore();
                }
              }
              return true;
            },
            child: ListView.builder(
              physics: const ClampingScrollPhysics(),
              padding: const EdgeInsets.only(bottom: 100),
              itemCount: state.meals.length + (state.isLoading ? 1 : 0),
              itemBuilder: (context, index) {
                if (index == state.meals.length) {
                  return const Center(
                    child: Padding(
                      padding: EdgeInsets.all(16.0),
                      child: CircularProgressIndicator(),
                    ),
                  );
                }
                final meal = state.meals[index];
                return RecipeTile(meal: meal);
              },
            ),
          );
        },
      ),
    );
  }
}
