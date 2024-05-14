import 'package:my_meals_app/models/meal_time.dart';
import 'package:my_meals_app/models/origin.dart';

class Meal {
  String name;
  String? description;
  MealTime mealTime;
  int rating;
  Origin method;
  DateTime date;

  Meal({
    required this.name,
    this.description,
    required this.mealTime,
    required this.rating,
    required this.method,
    required this.date,
  });
}
