import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_meals_app/logic/bloc/meals/meals_bloc.dart';

class FilterRatingButton extends StatefulWidget {
  const FilterRatingButton({super.key});

  @override
  State<FilterRatingButton> createState() => _FilterRatingButtonState();
}

class _FilterRatingButtonState extends State<FilterRatingButton> {
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
            Text('Rating',
                style: TextStyle(color: Theme.of(context).colorScheme.primary)),
          ],
        ),
        itemBuilder: (context) =>
            List<PopupMenuEntry<int>>.generate(5, (index) {
          return PopupMenuItem<int>(
            value: index + 1,
            child: BlocBuilder(
              bloc: _mealsBloc,
              builder: (context, state) {
                return CheckboxListTile(
                  value: state is MealsLoaded
                      ? state.displayedRatings.contains(index + 1)
                      : false,
                  onChanged: (bool? value) {
                    if (value == false &&
                        state is MealsLoaded &&
                        state.displayedRatings.length == 1) {
                      // Prevent unchecking the last checked checkbox
                      return;
                    }
                    List<int> updatedRatings =
                        List.from((state as MealsLoaded).displayedRatings);
                    if (value == true) {
                      updatedRatings.add(index + 1);
                    } else {
                      updatedRatings.remove(index + 1);
                    }
                    _mealsBloc.add(RequestToLoadMeals(
                      ratings: updatedRatings,
                    ));
                  },
                  title: Row(
                    children: List<Widget>.generate(
                      index + 1,
                      (starIndex) => const Icon(Icons.star),
                    ),
                  ),
                );
              },
            ),
          );
        }),
      ),
    );
  }
}
