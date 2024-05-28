import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_meals_app/logic/bloc/meals/meals_bloc.dart';
import 'package:my_meals_app/logic/models/meal_time.dart';

class FilterMealtimeButton extends StatefulWidget {
  const FilterMealtimeButton({super.key});

  @override
  State<FilterMealtimeButton> createState() => _FilterMealtimeButtonState();
}

class _FilterMealtimeButtonState extends State<FilterMealtimeButton> {
  late MealsBloc _mealsBloc;

  @override
  void initState() {
    super.initState();
    _mealsBloc = BlocProvider.of<MealsBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(8),
        margin: const EdgeInsets.symmetric(horizontal: 4),
        decoration: BoxDecoration(
          border: Border.all(color: const Color(0xff79747e)),
          borderRadius: BorderRadius.circular(30),
        ),
        child: PopupMenuButton<int>(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.filter_alt,
                color: Theme.of(context).colorScheme.primary,
              ),
              Text('Mealtime',
                  style:
                      TextStyle(color: Theme.of(context).colorScheme.primary)),
            ],
          ),
          itemBuilder: (context) =>
              List<PopupMenuEntry<int>>.generate(4, (index) {
            return PopupMenuItem<int>(
              value: index,
              child: BlocBuilder(
                bloc: _mealsBloc,
                builder: (context, state) {
                  return CheckboxListTile(
                    value: state is MealsLoaded
                        ? state.displayedMealTimes.contains(index)
                        : false,
                    onChanged: (bool? value) {
                      if (value == false &&
                          state is MealsLoaded &&
                          state.displayedMealTimes.length == 1) {
                        // Prevent unchecking the last checked checkbox
                        return;
                      }
                      List<int> updatedMealtimes =
                          List.from((state as MealsLoaded).displayedMealTimes);
                      if (value == true) {
                        updatedMealtimes.add(index);
                      } else {
                        updatedMealtimes.remove(index);
                      }
                      _mealsBloc.add(RequestToLoadMeals(
                        mealTimes: updatedMealtimes,
                      ));
                    },
                    title: Text(MealTime.values[index].toString()),
                  );
                },
              ),
            );
          }),
        ));
  }
}
