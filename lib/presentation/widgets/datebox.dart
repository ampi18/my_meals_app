import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateBox extends StatefulWidget {
  const DateBox({super.key, required this.onDateChanged});
  final Function(DateTime) onDateChanged;

  @override
  State<DateBox> createState() => _DateBoxState();
}

class _DateBoxState extends State<DateBox> {
  final TextEditingController textEditingController = TextEditingController();
  DateTime _selectedDate = DateTime.now();

  @override
  void initState() {
    textEditingController.text =
        DateFormat('dd.MM.yyyy').format(DateTime.now());
    super.initState();
  }

  @override
  void dispose() {
    textEditingController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (pickedDate != null && pickedDate != _selectedDate) {
      setState(() {
        _selectedDate = pickedDate;
        textEditingController.text =
            DateFormat('dd.MM.yyyy').format(_selectedDate);
      });

      widget.onDateChanged(_selectedDate);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextField(
          controller: textEditingController,
          keyboardType: TextInputType.none,
          decoration: InputDecoration(
            label: const Text('Date'),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          onTap: () => _selectDate(context),
        ),
      ],
    );
  }
}
