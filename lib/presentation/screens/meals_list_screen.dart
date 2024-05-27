import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_meals_app/logic/bloc/meals_bloc.dart';
import 'package:my_meals_app/presentation/screens/meal_details_screen.dart';
import 'package:my_meals_app/presentation/widgets/show_meals_list.dart';

class MealsListScreen extends StatelessWidget {
  const MealsListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MealsBloc, MealsState>(
      builder: (context, state) {
        return Scaffold(
            appBar: AppBar(
              title: const Text('My Meals'),
              centerTitle: true,
            ),
            body: const ShowMealsList(),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                BlocProvider.of<MealsBloc>(context).add(RequestToAddMeal());
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const MealDetails()));
              },
              child: const Icon(Icons.add),
            ));
      },
    );
  }
}
