import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_meals_app/logic/bloc/settings/settings_bloc.dart';

class ThemeToggleButton extends StatefulWidget {
  const ThemeToggleButton({super.key});

  @override
  State<ThemeToggleButton> createState() => _ThemeToggleButtonState();
}

class _ThemeToggleButtonState extends State<ThemeToggleButton> {
  final List<String> themes = ['light', 'dark'];
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
              isSelected: themes.map((theme) => theme == state.theme).toList(),
              onPressed: (int index) {
                _settingsBloc
                    .add(RequestToUpdateSettings(theme: themes[index]));
              },
              constraints: const BoxConstraints(
                minHeight: 32.0,
                maxHeight: 32.0,
                minWidth: 90.0,
                maxWidth: 90.0,
              ),
              children: themes.map((theme) => Text(theme)).toList(),
            ),
          _ => const Text('could not read current theme'),
        };
      },
    );
  }
}
