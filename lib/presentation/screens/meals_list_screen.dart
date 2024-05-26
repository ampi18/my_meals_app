import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_meals_app/logic/bloc/meals_bloc.dart';
import 'package:my_meals_app/presentation/widgets/buttons/filter_mealtime_button.dart';
import 'package:my_meals_app/presentation/widgets/buttons/filter_origin_button.dart';
import 'package:my_meals_app/presentation/widgets/buttons/filter_rating_button.dart';
import 'package:my_meals_app/presentation/widgets/meal_list_tile.dart';
import 'package:my_meals_app/presentation/widgets/buttons/toggle_arrow_button.dart';
import 'package:my_meals_app/presentation/screens/meal_details_screen.dart';
import 'package:my_meals_app/presentation/screens/meal_edit_screen.dart';
import 'package:my_meals_app/presentation/widgets/show_meals_list.dart';

class MealsListScreen extends StatelessWidget {
  const MealsListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Meals'),
        centerTitle: true,
      ),
      body: const ShowMealsList(),
    );
  }
}
