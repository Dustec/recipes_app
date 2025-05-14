import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:recipes_app/core/domain/extensions/disposable_mixin.dart';
import 'package:recipes_app/features/recipes/domain/models/meal.dart';
import 'package:recipes_app/features/recipes/domain/repositories/recipes_repository.dart';

part 'home_cubit.freezed.dart';
part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> with DisposableMixin {
  HomeCubit({required RecipesRepository recipesRepository})
    : _recipesRepository = recipesRepository,
      super(const HomeState()) {
    getMealsByLetter('b');
  }

  final RecipesRepository _recipesRepository;

  @override
  Future<void> close() {
    disposeAll();
    return super.close();
  }

  void getMealsByLetter(String letter) {
    emit(state.copyWith(isLoading: true));
    _recipesRepository
        .getMealsByLetter(letter)
        .listen(
          (meals) {
            emit(state.copyWith(meals: meals));
          },
          onError: (error) {
            print('onError $error');
          },
          onDone: () {
            emit(state.copyWith(isLoading: false));
          },
        )
        .dispose(this);
  }
}
