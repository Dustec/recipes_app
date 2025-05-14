import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:recipes_app/core/domain/extensions/disposable_mixin.dart';
import 'package:recipes_app/features/recipes/domain/models/meal.dart';
import 'package:recipes_app/features/recipes/domain/repositories/recipes_repository.dart';

part 'home_cubit.freezed.dart';
part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> with DisposableMixin {
  static const int _minItemsForScroll = 4;

  HomeCubit({required RecipesRepository recipesRepository})
    : _recipesRepository = recipesRepository,
      super(const HomeState()) {
    getMealsByLetter('a');
  }

  final RecipesRepository _recipesRepository;

  @override
  Future<void> close() {
    disposeAll();
    return super.close();
  }

  void getMealsByLetter(String letter) {
    if (state.hasReachedEnd) {
      return;
    }

    emit(state.copyWith(isLoading: true));
    _recipesRepository
        .getMealsByLetter(letter)
        .listen(
          (meals) {
            final currentMeals = state.meals;
            final updatedMeals = [...currentMeals, ...meals];
            final nextLetter = String.fromCharCode(letter.codeUnitAt(0) + 1);
            final hasReachedEnd = nextLetter.codeUnitAt(0) > 'z'.codeUnitAt(0);

            emit(
              state.copyWith(
                meals: updatedMeals,
                currentLetter: nextLetter,
                hasReachedEnd: hasReachedEnd,
              ),
            );

            // Si tenemos pocos elementos y no hemos llegado al final, cargar la siguiente letra
            if (updatedMeals.length < _minItemsForScroll && !hasReachedEnd) {
              getMealsByLetter(nextLetter);
            }
          },
          onError: (error) {
            print('onError $error');
            emit(state.copyWith(isLoading: false));
          },
          onDone: () {
            emit(state.copyWith(isLoading: false));
          },
        )
        .dispose(this);
  }

  void loadMore() {
    if (!state.isLoading && !state.hasReachedEnd && state.searchQuery == null) {
      getMealsByLetter(state.currentLetter);
    }
  }

  void search(String name) {
    emit(state.copyWith(isLoading: true, searchQuery: name, meals: []));

    _recipesRepository
        .searchMealsByName(name)
        .listen(
          (meals) {
            emit(state.copyWith(meals: meals, isLoading: false));
          },
          onError: (error) {
            print('onError $error');
            emit(state.copyWith(isLoading: false));
          },
          onDone: () {
            emit(state.copyWith(isLoading: false));
          },
        )
        .dispose(this);
  }

  void resetSearch() {
    emit(
      state.copyWith(
        searchQuery: null,
        meals: [],
        currentLetter: 'a',
        hasReachedEnd: false,
      ),
    );
    getMealsByLetter('a');
  }
}
