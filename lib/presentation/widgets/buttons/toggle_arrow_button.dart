import 'package:flutter/material.dart';

class ToggleArrowButton extends StatefulWidget {
  const ToggleArrowButton({super.key, required this.sortAction});
  final Function sortAction;

  @override
  State<ToggleArrowButton> createState() => _ToggleArrowButtonState();
}

class _ToggleArrowButtonState extends State<ToggleArrowButton> {
  bool _isArrowDown = true;

  void _toggleArrow() {
    setState(() {
      _isArrowDown = !_isArrowDown;
      widget.sortAction();
    });
  }

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: _toggleArrow,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(_isArrowDown ? Icons.south : Icons.north),
          const Icon(Icons.date_range),
        ],
      ),
    );
  }
}
