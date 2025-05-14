part of 'home_cubit.dart';

@freezed
class HomeState with _$HomeState {
  const factory HomeState({
    @Default([]) List<Meal> meals,
    @Default('a') String currentLetter,
    @Default(false) bool isLoading,
    @Default(false) bool hasReachedEnd,
    String? searchQuery,
  }) = _HomeState;
}
