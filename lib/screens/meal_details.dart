import 'package:flutter/material.dart';
import 'package:my_meals_app/components/origin_tag.dart';
import 'package:my_meals_app/models/meal.dart';
import 'package:my_meals_app/components/rating.dart';
import 'package:intl/intl.dart';

class MealDetails extends StatelessWidget {
  final Meal meal;
  const MealDetails({super.key, required this.meal});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(meal.name),
        centerTitle: true,
      ),
      body: Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Rating(rating: meal.rating),
            const SizedBox(height: 10),
            Text(meal.mealTime.name),
            const SizedBox(height: 10),
            OriginTag(origin: meal.origin),
            Text(DateFormat('dd.MM.yyyy').format(meal.date)),
            Text(
              meal.comment ?? '',
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
