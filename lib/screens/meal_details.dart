import 'package:flutter/material.dart';
import 'package:my_meals_app/models/meal.dart';
import 'package:my_meals_app/components/rating.dart';

class MealDetails extends StatelessWidget {
  final Meal meal;
  const MealDetails({super.key, required this.meal});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(meal.name),
      ),
      body: Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Text(meal.description ?? ''),
            Text('Meal Time: ${meal.mealTime.name}'),
            Rating(rating: meal.rating),
            Text('Method: ${meal.method.name}'),
            Text('Date: ${meal.date}'),
          ],
        ),
      ),
    );
  }
}
