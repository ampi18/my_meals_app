import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_meals_app/logic/bloc/meals/meals_bloc.dart';

class ToggleArrowButton extends StatefulWidget {
  const ToggleArrowButton({super.key});

  @override
  State<ToggleArrowButton> createState() => _ToggleArrowButtonState();
}

class _ToggleArrowButtonState extends State<ToggleArrowButton> {
  late MealsBloc _mealsBloc;

  @override
  void initState() {
    super.initState();
    _mealsBloc = BlocProvider.of<MealsBloc>(context);
  }

  void _toggleArrow() {
    _mealsBloc.add(RequestToLoadMeals(
      ascending: !_mealsBloc.isAscending,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MealsBloc, MealsState>(
      bloc: _mealsBloc,
      builder: (context, state) {
        return OutlinedButton(
          onPressed: _toggleArrow,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(state is MealsLoaded && state.isAscending
                  ? Icons.south
                  : Icons.north),
              const Icon(Icons.date_range),
            ],
          ),
        );
      },
    );
  }
}
