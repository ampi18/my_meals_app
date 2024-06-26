import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_meals_app/logic/bloc/meals/meals_bloc.dart';
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
        return PopScope(
          onPopInvoked: (didPop) {
            _mealsBloc.add(RequestToLoadMeals());
          },
          child: Scaffold(
            appBar: AppBar(
              title: state is SingleMealLoaded
                  ? Text(state.meal.name)
                  : const Text('Meal Details'),
              centerTitle: true,
            ),
            body: const MealForm(),
            floatingActionButton: state is SingleMealLoaded && state.readOnly
                ? FloatingActionButton(
                    onPressed: () {
                      _mealsBloc.add(RequestToEditMeal(meal: state.meal));
                    },
                    child: const Icon(Icons.edit),
                  )
                : null,
          ),
        );
      },
    );
  }
}
