import 'package:flutter/material.dart';

// Define a generic RadioGroup widget
class RadioGroup<T> extends StatefulWidget {
  final List<T> values;
  final T? selectedValue;
  final ValueChanged<T?> onChanged;

  const RadioGroup({
    Key? key,
    required this.values,
    required this.selectedValue,
    required this.onChanged,
  }) : super(key: key);

  @override
  State<RadioGroup<T>> createState() => _RadioGroupState<T>();
}

class _RadioGroupState<T> extends State<RadioGroup<T>> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: widget.values.map((value) {
        return ListTile(
          title: Text(value.toString()),
          leading: Radio<T>(
            value: value,
            groupValue: widget.selectedValue,
            onChanged: widget.onChanged,
          ),
        );
      }).toList(),
    );
  }
}
