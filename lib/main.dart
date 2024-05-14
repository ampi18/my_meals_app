import 'package:flutter/material.dart';
import 'package:my_meals_app/models/meal.dart';
import 'package:my_meals_app/components/meal_list_tile.dart';
import 'package:my_meals_app/models/meal_time.dart';
import 'package:my_meals_app/models/origin.dart';
import 'package:my_meals_app/screens/meal_details.dart';

List<Meal> mymeals = [
  Meal(
    name: 'Spaghetti',
    mealTime: MealTime.lunch,
    rating: 4,
    method: Origin.homecooked,
    date: DateTime.now(),
  ),
  Meal(
    name: 'Fried Rice',
    mealTime: MealTime.dinner,
    rating: 5,
    method: Origin.delivery,
    date: DateTime.now(),
  ),
  Meal(
    name: 'Pancake',
    mealTime: MealTime.breakfast,
    rating: 3,
    method: Origin.restaurant,
    date: DateTime.now(),
  ),
  Meal(
    name: 'Spaghetti',
    mealTime: MealTime.lunch,
    rating: 4,
    method: Origin.homecooked,
    date: DateTime.now(),
  ),
  Meal(
    name: 'Fried Rice',
    mealTime: MealTime.dinner,
    rating: 5,
    method: Origin.delivery,
    date: DateTime.now(),
  ),
  Meal(
    name: 'Pancake',
    mealTime: MealTime.breakfast,
    rating: 3,
    method: Origin.restaurant,
    date: DateTime.now(),
  ),
  Meal(
    name: 'Spaghetti',
    mealTime: MealTime.lunch,
    rating: 4,
    method: Origin.homecooked,
    date: DateTime.now(),
  ),
  Meal(
    name: 'Fried Rice',
    mealTime: MealTime.dinner,
    rating: 5,
    method: Origin.delivery,
    date: DateTime.now(),
  ),
  Meal(
    name: 'Pancake',
    mealTime: MealTime.breakfast,
    rating: 3,
    method: Origin.restaurant,
    date: DateTime.now(),
  ),
  Meal(
    name: 'Spaghetti',
    mealTime: MealTime.lunch,
    rating: 4,
    method: Origin.homecooked,
    date: DateTime.now(),
  ),
  Meal(
    name: 'Fried Rice',
    mealTime: MealTime.dinner,
    rating: 5,
    method: Origin.delivery,
    date: DateTime.now(),
  ),
  Meal(
    name: 'Pancake',
    mealTime: MealTime.breakfast,
    rating: 3,
    method: Origin.restaurant,
    date: DateTime.now(),
  ),
  Meal(
    name: 'Spaghetti',
    mealTime: MealTime.lunch,
    rating: 4,
    method: Origin.homecooked,
    date: DateTime.now(),
  ),
  Meal(
    name: 'Fried Rice',
    mealTime: MealTime.dinner,
    rating: 5,
    method: Origin.delivery,
    date: DateTime.now(),
  ),
  Meal(
    name: 'Pancake',
    mealTime: MealTime.breakfast,
    rating: 3,
    method: Origin.restaurant,
    date: DateTime.now(),
  ),
  Meal(
    name: 'Spaghetti',
    mealTime: MealTime.lunch,
    rating: 4,
    method: Origin.homecooked,
    date: DateTime.now(),
  ),
  Meal(
    name: 'Fried Rice',
    mealTime: MealTime.dinner,
    rating: 5,
    method: Origin.delivery,
    date: DateTime.now(),
  ),
  Meal(
    name: 'Pancake',
    mealTime: MealTime.breakfast,
    rating: 3,
    method: Origin.restaurant,
    date: DateTime.now(),
  ),
];

void main() {
  runApp(MainApp(
    meals: mymeals,
  ));
}

class MainApp extends StatelessWidget {
  final List<Meal> meals;

  const MainApp({super.key, required this.meals});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: ListView.builder(
          itemCount: meals.length,
          itemBuilder: (context, index) {
            return MealListTile(
              meal: meals[index],
              onTap: (meal) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MealDetails(meal: meal),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
