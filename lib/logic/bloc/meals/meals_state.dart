part of 'meals_bloc.dart';

@immutable
sealed class MealsState {}

final class MealsInitial extends MealsState {}

final class LoadingMeals extends MealsState {}

final class MealsLoaded extends MealsState {
  final List<Meal> meals;
  final bool isAscending;
  final List<int> displayedRatings;
  final List<int> displayedMealTimes;
  final List<int> displayedOrigins;
  final String? searchText;

  MealsLoaded(
      {required this.meals,
      required this.isAscending,
      required this.displayedRatings,
      required this.displayedMealTimes,
      required this.displayedOrigins,
      this.searchText});
}

final class LoadingSingleMeal extends MealsState {}

final class SingleMealLoaded extends MealsState {
  final Meal meal;
  final bool readOnly;

  SingleMealLoaded(this.meal, {this.readOnly = false});
}

final class UpdatingMeal extends MealsState {}
