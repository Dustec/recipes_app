import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:recipes_app/core/presentation/ui/app_colors.dart';
import 'package:recipes_app/features/recipes/domain/models/meal.dart';

class RecipeDetailsPage extends StatelessWidget {
  const RecipeDetailsPage({super.key, required this.meal});

  final Meal meal;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundCream,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 300,
            pinned: true,
            backgroundColor: AppColors.primaryOrange,
            flexibleSpace: FlexibleSpaceBar(
              background: Hero(
                tag: 'recipe-image-${meal.id}',
                child: CachedNetworkImage(
                  imageUrl: meal.thumbnailUrl ?? '',
                  fit: BoxFit.cover,
                  placeholder:
                      (context, url) => Container(
                        color: AppColors.primaryOrange.withOpacity(0.1),
                        child: const Center(child: CircularProgressIndicator()),
                      ),
                  errorWidget:
                      (context, url, error) => Container(
                        color: AppColors.primaryOrange.withOpacity(0.1),
                        child: const Icon(Icons.error, size: 50),
                      ),
                ),
              ),
            ),
            leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: AppColors.white),
              onPressed: () => Navigator.pop(context),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    meal.name,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textBrown,
                    ),
                  ),
                  const SizedBox(height: 16),
                  if (meal.category != null || meal.area != null) ...[
                    Row(
                      children: [
                        if (meal.category != null) ...[
                          const Icon(
                            Icons.category,
                            size: 20,
                            color: AppColors.primaryOrange,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            meal.category!,
                            style: const TextStyle(
                              fontSize: 16,
                              color: AppColors.primaryOrange,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                        if (meal.category != null && meal.area != null)
                          const SizedBox(width: 24),
                        if (meal.area != null) ...[
                          const Icon(
                            Icons.public,
                            size: 20,
                            color: AppColors.primaryOrange,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            meal.area!,
                            style: const TextStyle(
                              fontSize: 16,
                              color: AppColors.primaryOrange,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ],
                    ),
                    const SizedBox(height: 24),
                  ],
                  if (meal.tags.isNotEmpty) ...[
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children:
                          meal.tags.map((tag) {
                            return Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 6,
                              ),
                              decoration: BoxDecoration(
                                color: AppColors.primaryOrange.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(
                                  color: AppColors.primaryOrange.withOpacity(
                                    0.3,
                                  ),
                                ),
                              ),
                              child: Text(
                                tag,
                                style: const TextStyle(
                                  color: AppColors.primaryOrange,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            );
                          }).toList(),
                    ),
                    const SizedBox(height: 24),
                  ],
                  const Text(
                    'Ingredientes',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textBrown,
                    ),
                  ),
                  const SizedBox(height: 16),
                  ...List.generate(meal.ingredients.length, (index) {
                    final ingredient = meal.ingredients[index];
                    final measure = meal.measures[index];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: Row(
                        children: [
                          Container(
                            width: 8,
                            height: 8,
                            decoration: const BoxDecoration(
                              color: AppColors.primaryOrange,
                              shape: BoxShape.circle,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              '$measure $ingredient',
                              style: const TextStyle(
                                fontSize: 16,
                                color: AppColors.textBrown,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
                  const SizedBox(height: 24),
                  const Text(
                    'Instrucciones',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textBrown,
                    ),
                  ),
                  const SizedBox(height: 16),
                  if (meal.instructions != null)
                    Text(
                      meal.instructions!,
                      style: const TextStyle(
                        fontSize: 16,
                        color: AppColors.textBrown,
                        height: 1.5,
                      ),
                    ),
                  if (meal.youtubeUrl != null)
                    SafeArea(
                      child: ElevatedButton.icon(
                        onPressed: () {
                          // TODO: Open YouTube video
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primaryOrange,
                          foregroundColor: AppColors.white,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 24,
                            vertical: 12,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        icon: const Icon(Icons.play_circle_outline),
                        label: const Text('Ver en YouTube'),
                      ),
                    )
                  else
                    SafeArea(child: const SizedBox(height: 24)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
