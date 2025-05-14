import 'package:recipes_app/features/recipes/domain/models/meal.dart';
import 'package:recipes_app/features/recipes/domain/sources/favorites_source.dart';

class FavoritesCacheSource implements FavoritesSource {
  final List<Meal> _holdData = [];
  final List<String> _favorites = [];

  @override
  Stream<List<Meal>> toggleFavorite(String mealId) {
    if (isFavorite(mealId)) {
      _favorites.remove(mealId);
    } else {
      _favorites.add(mealId);
    }
    return Stream.value(
      _holdData
          .map((meal) => meal.copyWith(isFavorite: isFavorite(meal.id)))
          .toList(),
    );
  }

  @override
  bool isFavorite(String mealId) {
    return _favorites.contains(mealId);
  }

  @override
  List<Meal> mapFavorites(List<Meal> meals) {
    _holdData.clear();
    _holdData.addAll(meals);
    return meals
        .map((meal) => meal.copyWith(isFavorite: isFavorite(meal.id)))
        .toList();
  }
}
