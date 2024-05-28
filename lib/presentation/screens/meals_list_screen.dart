import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_meals_app/logic/bloc/meals/meals_bloc.dart';
import 'package:my_meals_app/presentation/screens/info_screen.dart';
import 'package:my_meals_app/presentation/screens/meal_details_screen.dart';
import 'package:my_meals_app/presentation/screens/settings_screen.dart';
import 'package:my_meals_app/presentation/widgets/show_meals_list.dart';

class MealsListScreen extends StatelessWidget {
  const MealsListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MealsBloc, MealsState>(
      builder: (context, state) {
        return Scaffold(
            appBar: AppBar(
              title: const Text('My Meals'),
              centerTitle: true,
            ),
            body: const ShowMealsList(),
            drawer: Drawer(
              child: ListView(
                padding: EdgeInsets.zero,
                children: <Widget>[
                  const DrawerHeader(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(
                            'assets/images/drawer_header_background.jpg'),
                        fit: BoxFit.cover,
                      ),
                      color: Colors.blueGrey,
                    ),
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Text(
                        'My Meals',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                        ),
                      ),
                    ),
                  ),
                  ListTile(
                    title: const Text('Settings'),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const SettingsScreen()));
                    },
                  ),
                  ListTile(
                    title: const Text('Info'),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const InfoScreen()));
                    },
                  ),
                ],
              ),
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                BlocProvider.of<MealsBloc>(context).add(RequestToAddMeal());
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const MealDetails()));
              },
              child: const Icon(Icons.add),
            ));
      },
    );
  }
}
