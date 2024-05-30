import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_meals_app/logic/bloc/settings/settings_bloc.dart';
import 'package:my_meals_app/logic/models/meal.dart';
import 'package:intl/intl.dart';
import 'package:my_meals_app/presentation/widgets/rating.dart';

class MealListTile extends StatelessWidget {
  final Meal meal;
  final Function(Meal) onTap;
  const MealListTile({super.key, required this.meal, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(meal),
      child: Container(
          height: 70,
          padding: const EdgeInsets.all(8),
          margin: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            border: Border.all(color: Colors.blue),
            borderRadius: BorderRadius.circular(8),
            boxShadow: const [
              BoxShadow(
                color: Colors.grey,
                blurRadius: 2,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: Center(
            child: Row(
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundColor: meal.origin.color,
                  child: Icon(meal.origin.icon),
                ),
                const SizedBox(width: 10),
                Container(
                  width: 150,
                  alignment: Alignment.centerLeft,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        meal.name,
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(meal.mealTime.name),
                    ],
                  ),
                ),
                const Spacer(),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Rating(rating: meal.rating),
                    BlocBuilder<SettingsBloc, SettingsState>(
                      builder: (context, state) {
                        if (state is SettingsLoaded) {
                          return Text(
                              DateFormat(state.dateFormat).format(meal.date));
                        } else {
                          return Text(
                              DateFormat('dd.MM.yyyy').format(meal.date));
                        }
                      },
                    ),
                  ],
                )
              ],
            ),
          )),
    );
  }
}
