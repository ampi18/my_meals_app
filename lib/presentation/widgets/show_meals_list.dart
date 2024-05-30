import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_meals_app/logic/bloc/meals/meals_bloc.dart';
import 'package:my_meals_app/presentation/widgets/buttons/filter_mealtime_button.dart';
import 'package:my_meals_app/presentation/widgets/buttons/filter_origin_button.dart';
import 'package:my_meals_app/presentation/widgets/buttons/filter_rating_button.dart';
import 'package:my_meals_app/presentation/widgets/meal_list_tile.dart';
import 'package:my_meals_app/presentation/widgets/buttons/sort_by_date_button.dart';
import 'package:my_meals_app/presentation/screens/meal_details_screen.dart';
import 'package:my_meals_app/presentation/widgets/list_search_bar.dart';

class ShowMealsList extends StatefulWidget {
  const ShowMealsList({super.key});

  @override
  State<ShowMealsList> createState() => _ShowMealsListState();
}

class _ShowMealsListState extends State<ShowMealsList> {
  late MealsBloc _mealsBloc;

  @override
  void initState() {
    super.initState();
    _mealsBloc = BlocProvider.of<MealsBloc>(context);
    _mealsBloc.add(RequestToLoadMeals());
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: ListSearchBar(),
        ),
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SortByDateButton(),
              Row(
                children: [
                  FilterRatingButton(),
                  FilterMealtimeButton(),
                  FilterOriginButton(),
                ],
              ),
            ],
          ),
        ),
        BlocBuilder<MealsBloc, MealsState>(
            bloc: _mealsBloc,
            builder: (context, state) {
              return switch (state) {
                LoadingMeals() =>
                  const Center(child: CircularProgressIndicator()),
                MealsLoaded() => state.meals.isNotEmpty
                    ? Expanded(
                        child: ListView.builder(
                          itemCount: state.meals.length,
                          itemBuilder: (context, index) {
                            return MealListTile(
                                meal: state.meals[index],
                                onTap: (meal) {
                                  _mealsBloc.add(RequestToLoadSingleMeal(
                                    id: meal.id,
                                  ));
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const MealDetails(),
                                    ),
                                  );
                                });
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
                                style:
                                    TextStyle(fontSize: 16, color: Colors.red),
                              ),
                            ]),
                      ),
                _ => Container()
              };
            }),
      ],
    );
  }
}
