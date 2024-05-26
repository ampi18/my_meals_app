import 'package:flutter/material.dart';
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
