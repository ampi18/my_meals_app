import 'package:flutter/material.dart';

class RadioGroup<T> extends StatefulWidget {
  final List<T> values;
  final T selectedValue;
  final Function onChanged;

  const RadioGroup({
    super.key,
    required this.values,
    required this.selectedValue,
    required this.onChanged,
  });

  @override
  State<RadioGroup<T>> createState() => _RadioGroupState<T>();
}

class _RadioGroupState<T> extends State<RadioGroup<T>> {
  late T selectedValue;

  @override
  void initState() {
    super.initState();
    selectedValue = widget.selectedValue;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: widget.values.map((value) {
        return ListTile(
          title: Text(value.toString()),
          leading: Radio<T>(
            value: value,
            groupValue: selectedValue,
            onChanged: (T? value) {
              setState(() {
                selectedValue = value as T;
              });
              widget.onChanged(value);
            },
          ),
        );
      }).toList(),
    );
  }
}
