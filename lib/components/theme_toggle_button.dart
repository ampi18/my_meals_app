import 'package:flutter/material.dart';

class ThemeToggleButton extends StatefulWidget {
  const ThemeToggleButton({super.key});

  @override
  State<ThemeToggleButton> createState() => _ThemeToggleButtonState();
}

class _ThemeToggleButtonState extends State<ThemeToggleButton> {
  final List<String> themes = ['Light', 'Dark'];
  final List<bool> _toggleButtonsSelection = [true, false];

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
      children: themes.map((theme) => Text(theme)).toList(),
    );
  }
}
