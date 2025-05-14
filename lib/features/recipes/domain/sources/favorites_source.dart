import 'package:recipes_app/features/recipes/domain/models/meal.dart';

abstract class FavoritesSource {
  Stream<List<Meal>> toggleFavorite(String mealId, List<Meal> meals);
  bool isFavorite(String mealId);
  List<Meal> mapFavorites(List<Meal> meals);
}
