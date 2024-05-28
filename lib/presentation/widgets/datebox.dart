import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:my_meals_app/logic/bloc/settings/settings_bloc.dart';

class DateBox extends StatefulWidget {
  const DateBox(
      {super.key,
      required this.onDateChanged,
      this.readOnly = true,
      required this.inititalDate});
  final Function(DateTime) onDateChanged;
  final bool readOnly;
  final DateTime inititalDate;

  @override
  State<DateBox> createState() => _DateBoxState();
}

class _DateBoxState extends State<DateBox> {
  final TextEditingController textEditingController = TextEditingController();
  late DateTime _selectedDate;
  late SettingsBloc _settingsBloc;

  @override
  void initState() {
    _selectedDate = widget.inititalDate;
    _settingsBloc = BlocProvider.of<SettingsBloc>(context);
    textEditingController.text = DateFormat(
            _settingsBloc.state is SettingsLoaded
                ? (_settingsBloc.state as SettingsLoaded).dateFormat
                : 'dd.MM.yyyy')
        .format(_selectedDate);
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
        textEditingController.text = DateFormat(
                _settingsBloc.state is SettingsLoaded
                    ? (_settingsBloc.state as SettingsLoaded).dateFormat
                    : 'dd.MM.yyyy')
            .format(_selectedDate);
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
          readOnly: widget.readOnly,
          controller: textEditingController,
          keyboardType: TextInputType.none,
          decoration: InputDecoration(
            label: const Text('last meal date'),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          onTap: () {
            if (!widget.readOnly) {
              _selectDate(context);
            }
          },
        ),
      ],
    );
  }
}
