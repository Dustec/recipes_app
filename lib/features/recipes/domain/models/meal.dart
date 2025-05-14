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
    this.isFavorite = false,
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
  final bool isFavorite;
}

extension MealX on Meal {
  Meal copyWith({bool? isFavorite}) {
    return Meal(
      id: id,
      name: name,
      alternateName: alternateName,
      category: category,
      area: area,
      instructions: instructions,
      thumbnailUrl: thumbnailUrl,
      youtubeUrl: youtubeUrl,
      tags: tags,
      ingredients: ingredients,
      measures: measures,
      source: source,
      imageSourceUrl: imageSourceUrl,
      creativeCommonsConfirmed: creativeCommonsConfirmed,
      dateModified: dateModified,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }
}
