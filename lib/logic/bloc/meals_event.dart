part of 'meals_bloc.dart';

@immutable
sealed class MealsEvent {}

final class RequestToPopulateDatabase extends MealsEvent {}

final class RequestToLoadMeals extends MealsEvent {
  final bool ascending;
  final List<int>? ratings;
  final List<int>? mealTimes;
  final List<int>? origins;

  RequestToLoadMeals(
      {this.ascending = true, this.ratings, this.mealTimes, this.origins});
}

final class RequestToLoadSingleMeal extends MealsEvent {
  final int id;

  RequestToLoadSingleMeal({required this.id});
}
