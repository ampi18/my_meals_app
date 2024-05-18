import 'package:my_meals_app/models/meal_time.dart';
import 'package:my_meals_app/models/origin.dart';

class Meal {
  String name;
  String? comment;
  MealTime mealTime;
  int rating;
  Origin origin;
  String source;
  DateTime date;

  Meal({
    required this.name,
    this.comment,
    required this.mealTime,
    required this.rating,
    required this.origin,
    required this.source,
    required this.date,
  });
}
