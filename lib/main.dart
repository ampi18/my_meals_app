import 'package:flutter/material.dart';
import 'package:my_meals_app/presentation/screens/meals_list_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_meals_app/logic/bloc/meals_bloc.dart';

void main() {
  runApp(BlocProvider(
    create: (context) => MealsBloc(),
    child: const MaterialApp(
      title: 'My Meals',
      home: MealsListScreen(),
    ),
  ));
}
