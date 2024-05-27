import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_meals_app/logic/bloc/meals_bloc.dart';
import 'package:my_meals_app/logic/models/meal.dart';
import 'package:my_meals_app/logic/models/meal_time.dart';
import 'package:my_meals_app/logic/models/origin.dart';
import 'package:my_meals_app/presentation/widgets/buttons/rating_buttons.dart';
import 'package:my_meals_app/presentation/widgets/datebox.dart';
import 'package:my_meals_app/presentation/widgets/radio_group.dart';

class MealForm extends StatefulWidget {
  const MealForm({super.key});

  @override
  MealFormState createState() {
    return MealFormState();
  }
}

class MealFormState extends State<MealForm> {
  final _formKey = GlobalKey<FormState>();
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
          return switch (state) {
            LoadingSingleMeal() =>
              const Center(child: CircularProgressIndicator()),
            SingleMealLoaded() => SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: <Widget>[
                        TextFormField(
                          readOnly: state.readOnly,
                          initialValue: state.meal.name,
                          onChanged: (value) => state.meal.name = value,
                          decoration: const InputDecoration(
                              labelText: 'Name', filled: true),
                        ),
                        const SizedBox(height: 16),
                        DateBox(
                          readOnly: state.readOnly,
                          onDateChanged: (date) {
                            state.meal.date = date;
                          },
                        ),
                        RatingButtons(
                          readOnly: state.readOnly,
                          initalRating: state.meal.rating,
                          onRatingChanged: (rating) {
                            state.meal.rating = rating;
                          },
                        ),
                        RadioGroup<MealTime>(
                          readOnly: state.readOnly,
                          values: MealTime.values,
                          selectedValue: state.meal.mealTime,
                          onChanged: (newValue) {
                            state.meal.mealTime = newValue;
                          },
                        ),
                        RadioGroup<Origin>(
                          readOnly: state.readOnly,
                          values: Origin.values,
                          selectedValue: state.meal.origin,
                          onChanged: (newValue) {
                            state.meal.origin = newValue;
                          },
                        ),
                        TextFormField(
                          readOnly: state.readOnly,
                          initialValue: state.meal.source,
                          onChanged: (value) => state.meal.source = value,
                          decoration: const InputDecoration(
                              labelText: 'Source', filled: true),
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          readOnly: state.readOnly,
                          onChanged: (value) => state.meal.comment = value,
                          initialValue: state.meal.comment,
                          decoration: const InputDecoration(
                              labelText: 'Comment', filled: true),
                        ),
                        const SizedBox(height: 16),
                        if (!state.readOnly)
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              ElevatedButton(
                                onPressed: () {
                                  _mealsBloc.add(RequestToLoadSingleMeal(id: state.meal.id));
                                },
                                child: const Text('Cancel'),
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  _mealsBloc.add(RequestToUpdateMeal(
                                      meal: Meal(
                                    id: state.meal.id,
                                    name: state.meal.name,
                                    date: state.meal.date,
                                    rating: state.meal.rating,
                                    mealTime: state.meal.mealTime,
                                    origin: state.meal.origin,
                                    source: state.meal.source,
                                    comment: state.meal.comment,
                                  )));
                                },
                                child: const Text('Save'),
                              ),
                            ],
                          )
                      ],
                    ),
                  ),
                ),
              ),
            UpdatingMeal() => const Center(child: CircularProgressIndicator()),
            _ => Container(),
          };
        });
  }
}
