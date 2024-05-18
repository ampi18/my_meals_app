import 'package:flutter/material.dart';
import 'package:my_meals_app/components/datebox.dart';
import 'package:my_meals_app/components/name_search_bar.dart';
import 'package:my_meals_app/components/radio_group.dart';
import 'package:my_meals_app/components/rating_buttons.dart';
import 'package:my_meals_app/models/meal_time.dart';
import 'package:my_meals_app/models/origin.dart';

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
            const DateBox(),
            const SizedBox(height: 16),
            const RatingButtons(),
            const SizedBox(height: 16),
            RadioGroup<MealTime>(
              values: MealTime.values,
              selectedValue: MealTime.breakfast,
              onChanged: (value) {
                print('Selected value: $value');
              },
            ),
            const SizedBox(height: 16),
            RadioGroup<Origin>(
              values: Origin.values,
              selectedValue: Origin.homecooked,
              onChanged: (value) {
                print('Selected value: $value');
              },
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                    onPressed: () {
                      print('Discard button pressed');
                    },
                    child: const Text('Discard')),
                ElevatedButton(
                  onPressed: () {
                    print('Save button pressed');
                  },
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
