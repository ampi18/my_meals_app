import 'package:flutter/material.dart';
import 'package:my_meals_app/components/meal_list_tile.dart';
import 'package:my_meals_app/components/toggle_arrow_button.dart';
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

  @override
  void initState() {
    super.initState();
    _initializeData();
  }

  Future<void> _initializeData() async {
    _populateData().then((_) => _getAllMealsAscending().then(
          (value) => setState(() => meals = value),
        ));
  }

  Future<void> _populateData() async {
    await _databaseService.populateData();
  }

  Future<List<Meal>> _getAllMealsAscending() async {
    return await _databaseService.mealsAscendingByDate();
  }

  Future<List<Meal>> _getAllMealsDescending() async {
    return await _databaseService.mealsDescendingByDate();
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
          ToggleArrowButton(
            sortAction: () {
              setState(() {
                isAscending = !isAscending;
                if (isAscending) {
                  _getAllMealsAscending()
                      .then((value) => setState(() => meals = value));
                } else {
                  _getAllMealsDescending()
                      .then((value) => setState(() => meals = value));
                }
              });
            },
          ),
          Expanded(
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
          ),
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
