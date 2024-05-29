import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class InfoScreen extends StatelessWidget {
  const InfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Info'),
          centerTitle: true,
        ),
        body: Container(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Version:'),
                  Text('Developer:'),
                  Text('Contact:'),
                ],
              ),
              const SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
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
        ));
  }
}
