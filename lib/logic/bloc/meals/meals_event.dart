part of 'meals_bloc.dart';

@immutable
sealed class MealsEvent {}

final class RequestToLoadMeals extends MealsEvent {
  final bool ascending;
  final List<int>? ratings;
  final List<int>? mealTimes;
  final List<int>? origins;
  final String searchText;

  RequestToLoadMeals(
      {this.ascending = true,
      this.ratings,
      this.mealTimes,
      this.origins,
      this.searchText = ''});
}

final class RequestToLoadSingleMeal extends MealsEvent {
  final int id;

  RequestToLoadSingleMeal({required this.id});
}

final class RequestToEditMeal extends MealsEvent {
  final Meal meal;

  RequestToEditMeal({required this.meal});
}

final class RequestToUpdateMeal extends MealsEvent {
  final Meal meal;

  RequestToUpdateMeal({required this.meal});
}

final class RequestToAddMeal extends MealsEvent {}
