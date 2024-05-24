import 'package:flutter/material.dart';
import 'package:my_meals_app/components/buttons/filter_mealtime_button.dart';
import 'package:my_meals_app/components/buttons/filter_origin_button.dart';
import 'package:my_meals_app/components/buttons/filter_rating_button.dart';
import 'package:my_meals_app/components/meal_list_tile.dart';
import 'package:my_meals_app/components/buttons/toggle_arrow_button.dart';
import 'package:my_meals_app/database/database.dart';
import 'package:my_meals_app/models/meal.dart';
import 'package:my_meals_app/screens/meal_details_screen.dart';
import 'package:my_meals_app/screens/meal_edit_screen.dart';

class MealsList extends StatefulWidget {
  const MealsList({super.key});

  @override
  State<MealsList> createState() => _MealsListState();
}

class _MealsListState extends State<MealsList> {
  final DatabaseService _databaseService = DatabaseService();
  List<Meal> meals = [];
  bool isAscending = true;
  List<int> displayedRatings = List<int>.generate(5, (index) => index + 1);
  List<int> displayedMealTimes = List<int>.generate(4, (index) => index);
  List<int> displayedOrigins = List<int>.generate(4, (index) => index);

  @override
  void initState() {
    super.initState();
    _initializeData();
  }

  Future<void> _initializeData() async {
    _populateData().then((_) => _getMeals().then(
          (value) => setState(() => meals = value),
        ));
  }

  Future<void> _populateData() async {
    await _databaseService.populateData();
  }

  Future<List<Meal>> _getMeals() async {
    return await _databaseService.meals(
        ascending: isAscending,
        ratings: displayedRatings,
        mealTimes: displayedMealTimes,
        origins: displayedOrigins);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Meals'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ToggleArrowButton(
                  sortAction: () {
                    setState(() {
                      isAscending = !isAscending;
                      _getMeals()
                          .then((value) => setState(() => meals = value));
                    });
                  },
                ),
                Row(
                  children: [
                    FilterRatingButton(
                      onSelectionChanged: (List<int> selectedRatings) {
                        setState(() {
                          displayedRatings = selectedRatings;
                          _getMeals()
                              .then((value) => setState(() => meals = value));
                        });
                      },
                    ),
                    FilterMealtimeButton(
                      onSelectionChanged: (List<int> selectedMealTimes) {
                        setState(() {
                          displayedMealTimes = selectedMealTimes;
                          _getMeals()
                              .then((value) => setState(() => meals = value));
                        });
                      },
                    ),
                    FilterOriginButton(
                        onSelectionChanged: (List<int> selectedOrigins) {
                      setState(() {
                        displayedOrigins = selectedOrigins;
                        _getMeals()
                            .then((value) => setState(() => meals = value));
                      });
                    }),
                  ],
                ),
              ],
            ),
          ),
          meals.isNotEmpty
              ? Expanded(
                  child: ListView.builder(
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
                )
              : const Padding(
                  padding: EdgeInsets.symmetric(vertical: 32.0),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.warning, color: Colors.red, size: 32),
                        Text(
                          'Your selection did not match any elements.',
                          style: TextStyle(fontSize: 16, color: Colors.red),
                        ),
                      ]),
                )
        ],
      ),
      floatingActionButton: Builder(builder: (context) {
        return FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const MealEdit()),
            );
          },
          backgroundColor: Colors.blueAccent,
          child: const Icon(Icons.add),
        );
      }),
    );
  }
}
