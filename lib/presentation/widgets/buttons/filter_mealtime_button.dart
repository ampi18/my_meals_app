import 'package:flutter/material.dart';
import 'package:my_meals_app/logic/models/meal_time.dart';

class FilterMealtimeButton extends StatefulWidget {
  const FilterMealtimeButton({super.key, required this.onSelectionChanged});
  final Function onSelectionChanged;

  @override
  State<FilterMealtimeButton> createState() => _FilterMealtimeButtonState();
}

class _FilterMealtimeButtonState extends State<FilterMealtimeButton> {
  List<bool> selectedMealtimes = List<bool>.filled(4, true);

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
          child: const Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.filter_alt,
                color: Color(0xff6750a4),
              ),
              Text('Mealtime', style: TextStyle(color: Color(0xff6750a4))),
            ],
          ),
          itemBuilder: (context) =>
              List<PopupMenuEntry<int>>.generate(4, (index) {
            return PopupMenuItem<int>(
              value: index,
              child: StatefulBuilder(
                builder: (BuildContext context, StateSetter setState) {
                  return CheckboxListTile(
                    value: selectedMealtimes[index],
                    onChanged: (bool? value) {
                      if (value == false &&
                          selectedMealtimes
                                  .where((element) => element)
                                  .length ==
                              1) {
                        // Prevent unchecking the last checked checkbox
                        return;
                      }
                      setState(() {
                        selectedMealtimes[index] = value!;
                        widget.onSelectionChanged(selectedMealtimes
                            .asMap()
                            .entries
                            .where((entry) => entry.value)
                            .map((entry) => entry.key)
                            .toList());
                      });
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
