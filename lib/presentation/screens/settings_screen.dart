import 'package:flutter/material.dart';
import 'package:my_meals_app/presentation/widgets/buttons/date_format_toggle_button.dart';
import 'package:my_meals_app/presentation/widgets/buttons/theme_toggle_button.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        centerTitle: true,
      ),
      body: Container(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                    height: 48,
                    alignment: Alignment.center,
                    child: const Text('Theme:')),
                Container(
                    height: 48,
                    alignment: Alignment.center,
                    child: const Text('Date Format:')),
              ],
            ),
            const SizedBox(width: 16),
            const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ThemeToggleButton(),
                DateFormatToggleButton(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
