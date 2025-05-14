part of 'home_cubit.dart';

@freezed
class HomeState with _$HomeState {
  const factory HomeState({
    @Default([]) List<Meal> meals,
    @Default(false) bool isLoading,
    @Default('a') String currentLetter,
    @Default(false) bool hasReachedEnd,
  }) = _HomeState;
}
