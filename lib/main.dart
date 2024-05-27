import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_meals_app/logic/bloc/meals/meals_bloc.dart';
import 'package:my_meals_app/logic/bloc/settings/settings_bloc.dart';
import 'package:my_meals_app/presentation/screens/meals_list_screen.dart';

void main() {
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => MealsBloc(),
        ),
        BlocProvider(
          create: (context) => SettingsBloc()..add(RequestToLoadSettings()),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsBloc, SettingsState>(
      builder: (context, state) {
        return MaterialApp(
          title: 'My Meals',
          home: const MealsListScreen(),
          theme: ThemeData(
            useMaterial3: true,
            colorScheme: ColorScheme.fromSeed(
              seedColor: Colors.purple,
              brightness: state is SettingsLoaded && state.theme == 'Dark'
                  ? Brightness.dark
                  : Brightness.light,
            ),
          ),
        );
      },
    );
  }
}
