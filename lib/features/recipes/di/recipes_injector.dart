import 'package:get_it/get_it.dart';
import 'package:recipes_app/features/recipes/data/mappers/meal_from_dto_mapper.dart';
import 'package:recipes_app/features/recipes/data/repositories/recipes_data_repository.dart';
import 'package:recipes_app/features/recipes/domain/repositories/recipes_repository.dart';

// We keep injection logic separated through layers to avoid circular dependencies

void injectRecipesDependencies() {
  final GetIt coreInjector = GetIt.instance;

  coreInjector.registerFactory<RecipesRepository>(
    () => RecipesDataRepository(
      http: coreInjector.get(),
      mealFromDtoMapper: const MealFromDtoMapper(),
    ),
  );
}
