import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:recipes_app/core/presentation/ui/app_colors.dart';
import 'package:recipes_app/features/recipes/domain/models/meal.dart';
import 'package:recipes_app/features/recipes/presentation/pages/recipe_details_page.dart';

class RecipeTile extends StatelessWidget {
  const RecipeTile({
    super.key,
    required this.meal,
    required this.onToggleFavorite,
  });

  final Meal meal;
  final VoidCallback onToggleFavorite;

  static const _imageHeight = 140.0;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => RecipeDetailsPage(meal: meal),
            ),
          );
        },
        borderRadius: BorderRadius.circular(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(16),
                  ),
                  child: Hero(
                    tag: 'recipe-image-${meal.id}',
                    child: CachedNetworkImage(
                      imageUrl: meal.thumbnailUrl ?? '',
                      height: _imageHeight,
                      width: double.infinity,
                      fit: BoxFit.fitWidth,
                      alignment: Alignment.center,
                      placeholder:
                          (context, url) => Container(
                            height: _imageHeight,
                            color: AppColors.primaryOrange.withValues(
                              alpha: 0.1,
                            ),
                            child: const Center(
                              child: CircularProgressIndicator(),
                            ),
                          ),
                      errorWidget:
                          (context, url, error) => Container(
                            height: _imageHeight,
                            color: AppColors.primaryOrange.withValues(
                              alpha: 0.1,
                            ),
                            child: const Icon(Icons.error),
                          ),
                    ),
                  ),
                ),
                Positioned(
                  top: 8,
                  right: 8,
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: onToggleFavorite,
                      borderRadius: BorderRadius.circular(20),
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.9),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          meal.isFavorite
                              ? Icons.favorite
                              : Icons.favorite_border,
                          color:
                              meal.isFavorite
                                  ? AppColors.primaryOrange
                                  : Colors.grey,
                          size: 20,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    meal.name,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textBrown,
                    ),
                  ),
                  const SizedBox(height: 8),
                  if (meal.category != null || meal.area != null) ...[
                    Row(
                      children: [
                        if (meal.category != null) ...[
                          const Icon(
                            Icons.category,
                            size: 16,
                            color: AppColors.primaryOrange,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            meal.category!,
                            style: const TextStyle(
                              color: AppColors.primaryOrange,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                        if (meal.category != null && meal.area != null)
                          const SizedBox(width: 16),
                        if (meal.area != null) ...[
                          const Icon(
                            Icons.public,
                            size: 16,
                            color: AppColors.primaryOrange,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            meal.area!,
                            style: const TextStyle(
                              color: AppColors.primaryOrange,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ],
                    ),
                    const SizedBox(height: 8),
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
                                color: AppColors.primaryOrange.withValues(
                                  alpha: 0.1,
                                ),
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(
                                  color: AppColors.primaryOrange.withValues(
                                    alpha: 0.3,
                                  ),
                                ),
                              ),
                              child: Text(
                                tag,
                                style: const TextStyle(
                                  color: AppColors.primaryOrange,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            );
                          }).toList(),
                    ),
                    const SizedBox(height: 8),
                  ],
                  if (meal.dateModified != null) ...[
                    Row(
                      children: [
                        const Icon(
                          Icons.calendar_today,
                          size: 14,
                          color: AppColors.textBrown,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          'Última actualización: ${DateFormat('dd/MM/yyyy').format(meal.dateModified!)}',
                          style: const TextStyle(
                            color: AppColors.textBrown,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
