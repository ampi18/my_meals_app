import 'package:flutter/material.dart';
import 'package:my_meals_app/screens/meals_list.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MealsList(),
    );
  }
}
