import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:recipes_app/core/presentation/ui/app_colors.dart';
import 'package:recipes_app/features/recipes/domain/models/meal.dart';
import 'package:recipes_app/integrations/url_launcher_facade.dart';

class RecipeDetailsPage extends StatefulWidget {
  const RecipeDetailsPage({super.key, required this.meal});

  final Meal meal;

  @override
  State<RecipeDetailsPage> createState() => _RecipeDetailsPageState();
}

class _RecipeDetailsPageState extends State<RecipeDetailsPage> {
  Future<void> _launchYouTubeVideo(String url) async {
    if (!(await UrlLauncherFacade.launchUrl(url))) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('No se pudo abrir el video'),
            backgroundColor: AppColors.primaryOrange,
          ),
        );
      }
    }
  }

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
                tag: 'recipe-image-${widget.meal.id}',
                child: CachedNetworkImage(
                  imageUrl: widget.meal.thumbnailUrl ?? '',
                  fit: BoxFit.cover,
                  placeholder:
                      (context, url) => Container(
                        color: AppColors.primaryOrange.withValues(alpha: 0.1),
                        child: const Center(child: CircularProgressIndicator()),
                      ),
                  errorWidget:
                      (context, url, error) => Container(
                        color: AppColors.primaryOrange.withValues(alpha: 0.1),
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
                    widget.meal.name,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textBrown,
                    ),
                  ),
                  const SizedBox(height: 16),
                  if (widget.meal.category != null ||
                      widget.meal.area != null) ...[
                    Row(
                      children: [
                        if (widget.meal.category != null) ...[
                          const Icon(
                            Icons.category,
                            size: 20,
                            color: AppColors.primaryOrange,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            widget.meal.category!,
                            style: const TextStyle(
                              fontSize: 16,
                              color: AppColors.primaryOrange,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                        if (widget.meal.category != null &&
                            widget.meal.area != null)
                          const SizedBox(width: 24),
                        if (widget.meal.area != null) ...[
                          const Icon(
                            Icons.public,
                            size: 20,
                            color: AppColors.primaryOrange,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            widget.meal.area!,
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
                  if (widget.meal.tags.isNotEmpty) ...[
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children:
                          widget.meal.tags.map((tag) {
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
                  ...List.generate(widget.meal.ingredients.length, (index) {
                    final ingredient = widget.meal.ingredients[index];
                    final measure = widget.meal.measures[index];
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
                  if (widget.meal.instructions != null)
                    Text(
                      widget.meal.instructions!,
                      style: const TextStyle(
                        fontSize: 16,
                        color: AppColors.textBrown,
                        height: 1.5,
                      ),
                    ),
                  const SizedBox(height: 24),
                  if (widget.meal.youtubeUrl != null)
                    SafeArea(
                      child: ElevatedButton.icon(
                        onPressed:
                            () => _launchYouTubeVideo(widget.meal.youtubeUrl!),
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
                    const SafeArea(child: SizedBox(height: 24)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
