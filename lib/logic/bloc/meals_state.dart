part of 'meals_bloc.dart';

@immutable
sealed class MealsState {}

final class MealsInitial extends MealsState {}

final class LoadingMeals extends MealsState {}

final class MealsLoaded extends MealsState {
  final List<Meal> meals;

  MealsLoaded(this.meals);
}

final class LoadingSingleMeal extends MealsState {}

final class SingleMealLoaded extends MealsState {
  final Meal meal;
  final bool readOnly;

  SingleMealLoaded(this.meal, {this.readOnly = false});
}

final class UpdatingMeal extends MealsState {}

