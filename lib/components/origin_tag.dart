import 'package:flutter/material.dart';
import 'package:my_meals_app/models/origin.dart';

class OriginTag extends StatelessWidget {
  final Origin origin;
  const OriginTag({super.key, required this.origin});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (origin == Origin.homecooked)
          const Icon(Icons.home, color: Colors.black), //Icons.skillet
        if (origin == Origin.delivery)
          const Icon(Icons.delivery_dining, color: Colors.black),
        if (origin == Origin.restaurant)
          const Icon(Icons.restaurant, color: Colors.black),
        const SizedBox(width: 5),
        Text(origin.name.toUpperCase()),
      ],
    );
  }
}
