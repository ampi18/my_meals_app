import 'package:my_meals_app/models/meal_time.dart';
import 'package:my_meals_app/models/origin.dart';

class Meal {
  String name;
  String? description;
  MealTime mealTime;
  int rating;
  Origin origin;
  DateTime date;

  Meal({
    required this.name,
    this.description,
    required this.mealTime,
    required this.rating,
    required this.origin,
    required this.date,
  });
}
