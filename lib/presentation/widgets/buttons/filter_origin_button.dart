import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_meals_app/logic/bloc/meals/meals_bloc.dart';
import 'package:my_meals_app/logic/models/origin.dart';

class FilterOriginButton extends StatefulWidget {
  const FilterOriginButton({super.key});

  @override
  State<FilterOriginButton> createState() => _FilterOriginButtonState();
}

class _FilterOriginButtonState extends State<FilterOriginButton> {
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
              Text('Origin',
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
                        ? state.displayedOrigins.contains(index)
                        : false,
                    onChanged: (bool? value) {
                      if (value == false &&
                          state is MealsLoaded &&
                          state.displayedOrigins.length == 1) {
                        // Prevent unchecking the last checked checkbox
                        return;
                      }
                      List<int> updatedOrigins =
                          List.from((state as MealsLoaded).displayedOrigins);
                      if (value == true) {
                        updatedOrigins.add(index);
                      } else {
                        updatedOrigins.remove(index);
                      }
                      _mealsBloc.add(RequestToLoadMeals(
                        origins: updatedOrigins,
                      ));
                    },
                    title: Text(Origin.values[index].toString()),
                  );
                },
              ),
            );
          }),
        ));
  }
}
