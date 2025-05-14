import 'package:recipes_app/features/recipes/domain/models/meal.dart';

abstract class RecipesRepository {
  Stream<List<Meal>> getMealsByLetter(String letter);
  Stream<List<Meal>> searchMealsByName(String name);
}
