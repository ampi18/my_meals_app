import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_meals_app/logic/bloc/meals/meals_bloc.dart';

class ListSearchBar extends StatefulWidget {
  const ListSearchBar({super.key});

  @override
  State<ListSearchBar> createState() => _ListSearchBarState();
}

class _ListSearchBarState extends State<ListSearchBar> {
  final TextEditingController _textEditingController = TextEditingController();
  late MealsBloc _mealsBloc;

  @override
  void initState() {
    super.initState();
    _mealsBloc = BlocProvider.of<MealsBloc>(context);
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        TextField(
          controller: _textEditingController,
          onChanged: (String searchText) {
            _mealsBloc.add(RequestToLoadMeals(
              searchText: searchText,
            ));
          },
          decoration: InputDecoration(
            labelText: 'Search by name',
            prefixIcon: const Icon(Icons.search),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
      ],
    );
  }
}
