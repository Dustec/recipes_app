import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipes_app/core/presentation/resources/app_images.dart';
import 'package:recipes_app/core/presentation/ui/app_colors.dart';
import 'package:recipes_app/core/presentation/ui/app_text_styles.dart';
import 'package:recipes_app/features/home/presentation/cubit/home_cubit.dart';

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
          if (state.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          return ListView.builder(
            itemCount: state.meals.length,
            itemBuilder: (context, index) {
              return ListTile(title: Text(state.meals[index].name));
            },
          );
        },
      ),
    );
  }
}
