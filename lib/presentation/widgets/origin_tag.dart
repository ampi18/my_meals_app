import 'package:flutter/material.dart';
import 'package:my_meals_app/logic/models/origin.dart';

class OriginTag extends StatelessWidget {
  final Origin origin;
  const OriginTag({super.key, required this.origin});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(origin.icon, color: origin.color),
        Text(origin.name.toUpperCase()),
      ],
    );
  }
}
