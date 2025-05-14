import 'package:recipes_app/core/domain/extensions/app_extensions.dart';
import 'package:recipes_app/core/domain/facades/http_facade.dart';
import 'package:recipes_app/features/recipes/data/dtos/meal_dto.dart';
import 'package:recipes_app/features/recipes/data/mappers/meal_from_dto_mapper.dart';
import 'package:recipes_app/features/recipes/domain/models/meal.dart';
import 'package:recipes_app/features/recipes/domain/repositories/recipes_repository.dart';

class RecipesDataRepository implements RecipesRepository {
  const RecipesDataRepository({
    required this.http,
    required this.mealFromDtoMapper,
  });

  final HttpFacade http;
  final MealFromDtoMapper mealFromDtoMapper;

  @override
  Stream<List<Meal>> getMealsByLetter(String letter) {
    return http
        .get('https://www.themealdb.com/api/json/v1/1/search.php?f=$letter')
        .handle<List<Meal>>(
          mapper:
              (dynamic rawJson) =>
                  (safeCast<List<dynamic>>(rawJson['meals']) ?? [])
                      .map(
                        (dynamic jsonDto) =>
                            mealFromDtoMapper.map(MealDto.fromJson(jsonDto)),
                      )
                      .toList(),
        );
  }

  @override
  Stream<List<Meal>> searchMealsByName(String name) {
    return http
        .get('https://www.themealdb.com/api/json/v1/1/search.php?s=$name')
        .handle<List<Meal>>(
          mapper:
              (dynamic rawJson) =>
                  (safeCast<List<dynamic>>(rawJson['meals']) ?? [])
                      .map(
                        (dynamic jsonDto) =>
                            mealFromDtoMapper.map(MealDto.fromJson(jsonDto)),
                      )
                      .toList(),
        );
  }
}
