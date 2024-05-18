import 'package:flutter/material.dart';
import 'package:my_meals_app/models/meal.dart';
import 'package:my_meals_app/components/meal_list_tile.dart';
import 'package:my_meals_app/models/meal_time.dart';
import 'package:my_meals_app/models/origin.dart';
import 'package:my_meals_app/screens/meal_details.dart';
import 'package:my_meals_app/screens/meal_edit.dart';

List<Meal> mymeals = [
  Meal(
      name: 'Spaghetti',
      mealTime: MealTime.lunch,
      rating: 4,
      origin: Origin.homecooked,
      source: 'https://en.wikipedia.org/wiki/Spaghetti',
      date: DateTime.now(),
      comment:
          'Spaghetti is a long, thin, solid, cylindrical pasta. It is a staple food of traditional Italian cuisine. Like other pasta, spaghetti is made of milled wheat and water and sometimes enriched with vitamins and minerals. Italian spaghetti is typically made from durum wheat semolina. Usually, the pasta is white because refined flour is used, but whole wheat flour may be added.'),
  Meal(
    name: 'Fried Rice',
    source: 'https://en.wikipedia.org/wiki/Spaghetti',
    mealTime: MealTime.dinner,
    rating: 5,
    origin: Origin.delivery,
    date: DateTime.now(),
  ),
  Meal(
    name: 'Pancake',
    source: 'https://en.wikipedia.org/wiki/Spaghetti',
    mealTime: MealTime.breakfast,
    rating: 3,
    origin: Origin.restaurant,
    date: DateTime.now(),
  ),
  Meal(
    name: 'Spaghetti',
    source: 'https://en.wikipedia.org/wiki/Spaghetti',
    mealTime: MealTime.lunch,
    rating: 4,
    origin: Origin.homecooked,
    date: DateTime.now(),
  ),
  Meal(
    name: 'Fried Rice',
    source: 'https://en.wikipedia.org/wiki/Spaghetti',
    mealTime: MealTime.dinner,
    rating: 5,
    origin: Origin.delivery,
    date: DateTime.now(),
  ),
  Meal(
    name: 'Pancake',
    source: 'https://en.wikipedia.org/wiki/Spaghetti',
    mealTime: MealTime.breakfast,
    rating: 3,
    origin: Origin.restaurant,
    date: DateTime.now(),
  ),
  Meal(
    name: 'Spaghetti',
    source: 'https://en.wikipedia.org/wiki/Spaghetti',
    mealTime: MealTime.lunch,
    rating: 4,
    origin: Origin.other,
    date: DateTime.now(),
  ),
  Meal(
    name: 'Fried Rice',
    source: 'https://en.wikipedia.org/wiki/Spaghetti',
    mealTime: MealTime.dinner,
    rating: 5,
    origin: Origin.delivery,
    date: DateTime.now(),
  ),
  Meal(
    name: 'Pancake',
    source: 'https://en.wikipedia.org/wiki/Spaghetti',
    mealTime: MealTime.breakfast,
    rating: 3,
    origin: Origin.restaurant,
    date: DateTime.now(),
  ),
  Meal(
    name: 'Spaghetti',
    source: 'https://en.wikipedia.org/wiki/Spaghetti',
    mealTime: MealTime.lunch,
    rating: 4,
    origin: Origin.homecooked,
    date: DateTime.now(),
  ),
  Meal(
    name: 'Fried Rice',
    source: 'https://en.wikipedia.org/wiki/Spaghetti',
    mealTime: MealTime.dinner,
    rating: 5,
    origin: Origin.delivery,
    date: DateTime.now(),
  ),
  Meal(
    name: 'Pancake',
    source: 'https://en.wikipedia.org/wiki/Spaghetti',
    mealTime: MealTime.breakfast,
    rating: 3,
    origin: Origin.restaurant,
    date: DateTime.now(),
  ),
  Meal(
    name: 'Spaghetti',
    source: 'https://en.wikipedia.org/wiki/Spaghetti',
    mealTime: MealTime.lunch,
    rating: 4,
    origin: Origin.homecooked,
    date: DateTime.now(),
  ),
  Meal(
    name: 'Fried Rice',
    source: 'https://en.wikipedia.org/wiki/Spaghetti',
    mealTime: MealTime.dinner,
    rating: 5,
    origin: Origin.delivery,
    date: DateTime.now(),
  ),
  Meal(
    name: 'Pancake',
    source: 'https://en.wikipedia.org/wiki/Spaghetti',
    mealTime: MealTime.breakfast,
    rating: 3,
    origin: Origin.restaurant,
    date: DateTime.now(),
  ),
  Meal(
    name: 'Spaghetti',
    source: 'https://en.wikipedia.org/wiki/Spaghetti',
    mealTime: MealTime.lunch,
    rating: 4,
    origin: Origin.homecooked,
    date: DateTime.now(),
  ),
  Meal(
    name: 'Fried Rice',
    source: 'https://en.wikipedia.org/wiki/Spaghetti',
    mealTime: MealTime.dinner,
    rating: 5,
    origin: Origin.delivery,
    date: DateTime.now(),
  ),
  Meal(
    name: 'Pancake',
    source: 'https://en.wikipedia.org/wiki/Spaghetti',
    mealTime: MealTime.breakfast,
    rating: 3,
    origin: Origin.restaurant,
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
        appBar: AppBar(
          title: const Text('My Meals'),
          centerTitle: true,
        ),
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
        floatingActionButton: Builder(builder: (context) {
          return FloatingActionButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MealEdit()),
              );
            },
            backgroundColor: Colors.blueAccent,
            child: const Icon(Icons.add),
          );
        }),
      ),
    );
  }
}
