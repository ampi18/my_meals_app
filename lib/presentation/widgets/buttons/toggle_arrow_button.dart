import 'package:flutter/material.dart';

class ToggleArrowButton extends StatefulWidget {
  const ToggleArrowButton(
      {super.key, required this.sortAction, required this.isAscending});
  final Function sortAction;
  final bool isAscending;

  @override
  State<ToggleArrowButton> createState() => _ToggleArrowButtonState();
}

class _ToggleArrowButtonState extends State<ToggleArrowButton> {
  void _toggleArrow() {
    widget.sortAction();
  }

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: _toggleArrow,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(widget.isAscending ? Icons.south : Icons.north),
          const Icon(Icons.date_range),
        ],
      ),
    );
  }
}
