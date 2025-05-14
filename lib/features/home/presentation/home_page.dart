import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipes_app/core/presentation/resources/app_images.dart';
import 'package:recipes_app/core/presentation/ui/app_colors.dart';
import 'package:recipes_app/core/presentation/ui/app_text_styles.dart';
import 'package:recipes_app/features/home/presentation/cubit/home_cubit.dart';
import 'package:recipes_app/features/home/presentation/widgets/search_modal.dart';
import 'package:recipes_app/features/recipes/presentation/widgets/recipe_tile.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<HomeCubit>();

    return Scaffold(
      backgroundColor: AppColors.backgroundCream,
      floatingActionButton: FloatingActionButton.extended(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
        onPressed: () async {
          final String? searchQuery = await showDialog<String>(
            context: context,
            builder: (context) => const SearchModal(),
          );
          if (searchQuery != null) {
            cubit.search(searchQuery);
          }
        },
        backgroundColor: AppColors.primaryOrange,
        icon: const Icon(Icons.search, color: AppColors.white),
        label: Text('Buscar', style: AppTextStyles.body(AppColors.white)),
      ),
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

          if (state.searchQuery != null) {
            return Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(16),
                  color: AppColors.primaryOrange.withValues(alpha: 0.1),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          'Resultados para: ${state.searchQuery}',
                          style: AppTextStyles.body(AppColors.primaryOrange),
                        ),
                      ),
                      TextButton.icon(
                        onPressed: cubit.resetSearch,
                        icon: const Icon(Icons.clear),
                        label: const Text('Limpiar'),
                        style: TextButton.styleFrom(
                          foregroundColor: AppColors.primaryOrange,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child:
                      state.meals.isEmpty
                          ? Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(
                                  Icons.search_off,
                                  size: 64,
                                  color: AppColors.primaryOrange,
                                ),
                                const SizedBox(height: 16),
                                Text(
                                  'No se encontraron resultados',
                                  style: AppTextStyles.title(
                                    AppColors.primaryOrange,
                                  ),
                                ),
                              ],
                            ),
                          )
                          : ListView.builder(
                            physics: const ClampingScrollPhysics(),
                            padding: const EdgeInsets.only(bottom: 100),
                            itemCount: state.meals.length,
                            itemBuilder: (context, index) {
                              final meal = state.meals[index];
                              return RecipeTile(meal: meal);
                            },
                          ),
                ),
              ],
            );
          }

          return NotificationListener<ScrollNotification>(
            onNotification: (ScrollNotification scrollInfo) {
              if (scrollInfo is ScrollEndNotification) {
                if (scrollInfo.metrics.pixels >=
                    scrollInfo.metrics.maxScrollExtent * 0.8) {
                  cubit.loadMore();
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
