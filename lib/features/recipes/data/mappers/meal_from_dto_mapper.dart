import 'package:recipes_app/core/domain/contracts/mapper.dart';
import 'package:recipes_app/features/recipes/data/dtos/meal_dto.dart';
import 'package:recipes_app/features/recipes/domain/models/meal.dart';

class MealFromDtoMapper implements Mapper<MealDto, Meal> {
  const MealFromDtoMapper();

  @override
  Meal map(MealDto dto) {
    return Meal(
      id: dto.idMeal ?? '',
      name: dto.strMeal ?? '',
      alternateName: dto.strMealAlternate,
      category: dto.strCategory,
      area: dto.strArea,
      instructions: dto.strInstructions,
      thumbnailUrl: dto.strMealThumb,
      youtubeUrl: dto.strYoutube,
      tags: dto.strTags?.split(',') ?? [],
      ingredients:
          [
            dto.strIngredient1,
            dto.strIngredient2,
            dto.strIngredient3,
            dto.strIngredient4,
            dto.strIngredient5,
            dto.strIngredient6,
            dto.strIngredient7,
            dto.strIngredient8,
            dto.strIngredient9,
            dto.strIngredient10,
            dto.strIngredient11,
            dto.strIngredient12,
            dto.strIngredient13,
            dto.strIngredient14,
            dto.strIngredient15,
            dto.strIngredient16,
            dto.strIngredient17,
            dto.strIngredient18,
            dto.strIngredient19,
            dto.strIngredient20,
          ].whereType<String>().where((e) => e.isNotEmpty).toList(),
      measures:
          [
            dto.strMeasure1,
            dto.strMeasure2,
            dto.strMeasure3,
            dto.strMeasure4,
            dto.strMeasure5,
            dto.strMeasure6,
            dto.strMeasure7,
            dto.strMeasure8,
            dto.strMeasure9,
            dto.strMeasure10,
            dto.strMeasure11,
            dto.strMeasure12,
            dto.strMeasure13,
            dto.strMeasure14,
            dto.strMeasure15,
            dto.strMeasure16,
            dto.strMeasure17,
            dto.strMeasure18,
            dto.strMeasure19,
            dto.strMeasure20,
          ].whereType<String>().where((e) => e.isNotEmpty).toList(),
      source: dto.strSource,
      imageSourceUrl: dto.strImageSource,
      creativeCommonsConfirmed: dto.strCreativeCommonsConfirmed,
      dateModified: dto.dateModified,
    );
  }
}
