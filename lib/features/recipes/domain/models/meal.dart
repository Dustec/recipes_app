class Meal {
  const Meal({
    required this.id,
    required this.name,
    this.alternateName,
    this.category,
    this.area,
    this.instructions,
    this.thumbnailUrl,
    this.youtubeUrl,
    required this.tags,
    required this.ingredients,
    required this.measures,
    this.source,
    this.imageSourceUrl,
    this.creativeCommonsConfirmed,
    this.dateModified,
  });

  final String id;
  final String name;
  final String? alternateName;
  final String? category;
  final String? area;
  final String? instructions;
  final String? thumbnailUrl;
  final String? youtubeUrl;
  final List<String> tags;
  final List<String> ingredients;
  final List<String> measures;

  final String? source;
  final String? imageSourceUrl;
  final String? creativeCommonsConfirmed;
  final DateTime? dateModified;
}
