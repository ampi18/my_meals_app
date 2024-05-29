import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_meals_app/logic/bloc/settings/settings_bloc.dart';

class DateFormatToggleButton extends StatefulWidget {
  const DateFormatToggleButton({super.key});

  @override
  State<DateFormatToggleButton> createState() => _DateFormatToggleButtonState();
}

class _DateFormatToggleButtonState extends State<DateFormatToggleButton> {
  final List<String> formats = ['dd.MM.yyyy', 'MM/dd/yyyy', 'yyyy-MM-dd'];

  late SettingsBloc _settingsBloc;

  @override
  void initState() {
    super.initState();
    _settingsBloc = BlocProvider.of<SettingsBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsBloc, SettingsState>(
      bloc: _settingsBloc,
      builder: (context, state) {
        return switch (state) {
          SettingsLoaded() => ToggleButtons(
              isSelected:
                  formats.map((format) => format == state.dateFormat).toList(),
              onPressed: (int index) {
                _settingsBloc
                    .add(RequestToUpdateSettings(dateFormat: formats[index]));
              },
              constraints: const BoxConstraints(
                minHeight: 32.0,
                maxHeight: 32.0,
                minWidth: 100.0,
                maxWidth: 100.0,
              ),
              children: formats
                  .map((format) => Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(format),
                      ))
                  .toList(),
            ),
          _ => const Text('could not read current date format'),
        };
      },
    );
  }
}
