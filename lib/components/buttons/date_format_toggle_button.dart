import 'package:flutter/material.dart';

class DateFormatToggleButton extends StatefulWidget {
  const DateFormatToggleButton({super.key});

  @override
  State<DateFormatToggleButton> createState() => _DateFormatToggleButtonState();
}

class _DateFormatToggleButtonState extends State<DateFormatToggleButton> {
  final List<String> formats = ['dd.mm.yyyy', 'mm/dd/yyyy', 'yyyy-mm-dd'];
  final List<bool> _toggleButtonsSelection = [true, false, false];

  @override
  Widget build(BuildContext context) {
    return ToggleButtons(
      isSelected: _toggleButtonsSelection,
      onPressed: (int index) {
        setState(() {
          for (int buttonIndex = 0;
              buttonIndex < _toggleButtonsSelection.length;
              buttonIndex++) {
            if (buttonIndex == index) {
              _toggleButtonsSelection[buttonIndex] = true;
            } else {
              _toggleButtonsSelection[buttonIndex] = false;
            }
          }
        });
      },
      constraints: const BoxConstraints(
        minHeight: 32.0,
        maxHeight: 32.0,
        minWidth: 90.0,
        maxWidth: 90.0,
      ),
      children: formats
          .map((format) => Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(format),
              ))
          .toList(),
    );
  }
}
