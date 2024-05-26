import 'package:flutter/material.dart';
import 'package:my_meals_app/presentation/widgets/datebox.dart';
import 'package:my_meals_app/presentation/widgets/name_search_bar.dart';
import 'package:my_meals_app/presentation/widgets/radio_group.dart';
import 'package:my_meals_app/presentation/widgets/buttons/rating_buttons.dart';
import 'package:my_meals_app/logic/models/meal_time.dart';
import 'package:my_meals_app/logic/models/origin.dart';

class MealEdit extends StatelessWidget {
  const MealEdit({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Meal'),
        centerTitle: true,
      ),
      body: Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            NameSearchBar(),
            const SizedBox(height: 16),
            DateBox(
              onDateChanged: (date) {},
            ),
            const SizedBox(height: 16),
            RatingButtons(
              onRatingChanged: (rating) {},
            ),
            const SizedBox(height: 16),
            RadioGroup<MealTime>(
              values: MealTime.values,
              selectedValue: MealTime.breakfast,
              onChanged: (value) {},
            ),
            const SizedBox(height: 16),
            RadioGroup<Origin>(
              values: Origin.values,
              selectedValue: Origin.homecooked,
              onChanged: (value) {},
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(onPressed: () {}, child: const Text('Discard')),
                ElevatedButton(
                  onPressed: () {},
                  child: const Text('Save'),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
