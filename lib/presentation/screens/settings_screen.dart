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
        child: ListView(
          children: const [
            ListTile(
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Theme'),
                  SizedBox(height: 8),
                  ThemeToggleButton(),
                ],
              ),
              contentPadding: EdgeInsets.zero,
            ),
            Divider(),
            ListTile(
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Date Format'),
                  SizedBox(height: 8),
                  DateFormatToggleButton(),
                ],
              ),
              contentPadding: EdgeInsets.zero,
            ),
          ],
        ),
      ),
    );
  }
}
