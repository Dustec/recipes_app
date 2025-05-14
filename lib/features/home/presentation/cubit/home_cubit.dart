import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:recipes_app/features/recipes/domain/models/meal.dart';
import 'package:recipes_app/features/recipes/domain/repositories/recipes_repository.dart';

part 'home_cubit.freezed.dart';
part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit({required RecipesRepository recipesRepository})
    : _recipesRepository = recipesRepository,
      super(const HomeState());

  final RecipesRepository _recipesRepository;

  void getMealsByLetter(String letter) {
    emit(state.copyWith(isLoading: true));
    _recipesRepository
        .getMealsByLetter(letter)
        .listen(
          (meals) {
            emit(state.copyWith(meals: meals, isLoading: false));
          },
          onError: (error) {
            emit(state.copyWith(isLoading: false));
            print('onError $error');
          },
        );
  }
}
