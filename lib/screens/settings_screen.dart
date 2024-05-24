import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:my_meals_app/components/buttons/date_format_toggle_button.dart';
import 'package:my_meals_app/components/buttons/theme_toggle_button.dart';
import 'package:url_launcher/url_launcher.dart';

class Settings extends StatelessWidget {
  const Settings({super.key});

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
                const Text('Version:'),
                const Text('Developer:'),
                const Text('Contact:'),
              ],
            ),
            const SizedBox(width: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const ThemeToggleButton(),
                const DateFormatToggleButton(),
                const Text('1.0.0'),
                const Text('Amelie Popp'),
                GestureDetector(
                  onTap: () async {
                    final Uri emailLaunchUri = Uri(
                        scheme: 'mailto',
                        path: 'amelie.popp@study.thws.de',
                        queryParameters: {'subject': 'Feedback'});

                    await launchUrl(emailLaunchUri);
                  },
                  child: const Text(
                    'amelie.popp@study.thws.de',
                    style: TextStyle(
                      color: Colors.blue,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );

    //     Column(
    //       crossAxisAlignment: CrossAxisAlignment.start,
    //       children: [
    //         Row(
    //           children: [
    //         const Row(
    //           mainAxisAlignment: MainAxisAlignment.start,
    //           children: [
    //             Text('Theme: '),
    //             SizedBox(width: 8),
    //             ThemeToggleButton(),
    //           ],
    //         ),
    //         const SizedBox(height: 16),
    //         const Row(
    //           mainAxisAlignment: MainAxisAlignment.start,
    //           children: [
    //             Text('Date Format: '),
    //             SizedBox(width: 8),
    //             DateFormatToggleButton(),
    //           ],
    //         ),
    //         const SizedBox(height: 16),
    //         const Text('Version: 1.0.0'),
    //         const SizedBox(height: 16),
    //         const Text('Developer: Amelie Popp'),
    //         const SizedBox(height: 16),
    //         Row(
    //           children: [
    //             const Text('Contact: '),
    //             GestureDetector(
    //               onTap: () async {
    //                 final Uri emailLaunchUri = Uri(
    //                     scheme: 'mailto',
    //                     path: 'amelie.popp@study.thws.de',
    //                     queryParameters: {'subject': 'Feedback'});

    //                 await launchUrl(emailLaunchUri);
    //               },
    //               child: const Text(
    //                 'amelie.popp@study.thws.de',
    //                 style: TextStyle(
    //                   color: Colors.blue,
    //                   decoration: TextDecoration.underline,
    //                 ),
    //               ),
    //             ),
    //           ],
    //         ),
    //       ],
    //     ),
    //   ),
    // );
  }
}
