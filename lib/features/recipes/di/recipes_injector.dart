import 'package:get_it/get_it.dart';
import 'package:recipes_app/features/recipes/data/mappers/meal_from_dto_mapper.dart';
import 'package:recipes_app/features/recipes/data/repositories/recipes_data_repository.dart';
import 'package:recipes_app/features/recipes/domain/repositories/recipes_repository.dart';

// We keep injection separate from the injector to avoid circular dependencies

final GetIt recipesInjector = GetIt.asNewInstance();

void injectRecipesDependencies() {
  final GetIt coreInjector = GetIt.instance;

  recipesInjector.registerFactory<RecipesRepository>(
    () => RecipesDataRepository(
      http: coreInjector.get(),
      mealFromDtoMapper: const MealFromDtoMapper(),
    ),
  );
}
