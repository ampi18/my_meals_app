import 'package:flutter/material.dart';
import 'package:my_meals_app/models/meal.dart';
import 'package:intl/intl.dart';
import 'package:my_meals_app/components/rating.dart';

class MealListTile extends StatelessWidget {
  final Meal meal;
  final Function(Meal) onTap;
  const MealListTile({super.key, required this.meal, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(meal),
      child: Container(
          height: 70,
          padding: const EdgeInsets.all(8),
          margin: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.blue),
            borderRadius: BorderRadius.circular(8),
            boxShadow: const [
              BoxShadow(
                color: Colors.grey,
                blurRadius: 2,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: Center(
            child: Row(
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundImage:
                      AssetImage('assets/images/${meal.mealTime.name}.jpeg'),
                ),
                Expanded(
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(meal.name),
                        Text(meal.method.name),
                      ],
                    ),
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Rating(rating: meal.rating),
                    Text(DateFormat('dd.MM.yyyy').format(meal.date)),
                  ],
                )
              ],
            ),
          )),
    );
  }
}
