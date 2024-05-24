import 'package:flutter/material.dart';
import 'package:my_meals_app/models/origin.dart';

class FilterOriginButton extends StatefulWidget {
  const FilterOriginButton({super.key, required this.onSelectionChanged});
  final Function onSelectionChanged;

  @override
  State<FilterOriginButton> createState() => _FilterOriginButtonState();
}

class _FilterOriginButtonState extends State<FilterOriginButton> {
  List<bool> selectedOrigins = List<bool>.filled(4, true);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(8),
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
              Text('Origin', style: TextStyle(color: Color(0xff6750a4))),
            ],
          ),
          itemBuilder: (context) =>
              List<PopupMenuEntry<int>>.generate(4, (index) {
            return PopupMenuItem<int>(
              value: index,
              child: StatefulBuilder(
                builder: (BuildContext context, StateSetter setState) {
                  return CheckboxListTile(
                    value: selectedOrigins[index],
                    onChanged: (bool? value) {
                      if (value == false &&
                          selectedOrigins.where((element) => element).length ==
                              1) {
                        // Prevent unchecking the last checked checkbox
                        return;
                      }
                      setState(() {
                        selectedOrigins[index] = value!;
                        widget.onSelectionChanged(selectedOrigins
                            .asMap()
                            .entries
                            .where((entry) => entry.value)
                            .map((entry) => entry.key)
                            .toList());
                      });
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
