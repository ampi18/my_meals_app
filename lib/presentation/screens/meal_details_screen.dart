import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_meals_app/logic/bloc/meals_bloc.dart';
import 'package:my_meals_app/presentation/widgets/origin_tag.dart';
import 'package:my_meals_app/presentation/widgets/rating.dart';
import 'package:intl/intl.dart';

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
              title: Text('state.meal.name'),
              centerTitle: true,
              leading: IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () {
                  _mealsBloc.add(RequestToLoadMeals());
                  Navigator.pop(context);
                },
              ),
            ),
            body: switch (state) {
              LoadingSingleMeal() =>
                const Center(child: CircularProgressIndicator()),
              SingleMealLoaded() => Container(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Rating(rating: state.meal.rating),
                      const SizedBox(height: 10),
                      Text(state.meal.mealTime.name),
                      const SizedBox(height: 10),
                      OriginTag(origin: state.meal.origin),
                      Text(DateFormat('dd.MM.yyyy').format(state.meal.date)),
                      Text(
                        state.meal.comment ?? '',
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              _ => Container(),
            });
      },
    );
  }
}
