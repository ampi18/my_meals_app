import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_meals_app/logic/bloc/meals_bloc.dart';
import 'package:my_meals_app/presentation/widgets/meal_form.dart';

class MealDetails extends StatefulWidget {
  const MealDetails({
    super.key,
  });

  @override
  State<MealDetails> createState() => _MealDetailsState();
}

class _MealDetailsState extends State<MealDetails> {
  late MealsBloc _mealsBloc;

  @override
  void initState() {
    super.initState();
    _mealsBloc = BlocProvider.of<MealsBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MealsBloc, MealsState>(
      bloc: _mealsBloc,
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: state is SingleMealLoaded
                ? Text(state.meal.name)
                : const Text('Meal Details'),
            centerTitle: true,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                _mealsBloc.add(RequestToLoadMeals());
                Navigator.pop(context);
              },
            ),
          ),
          body: const MealForm(),
        );
      },
    );
  }
}
