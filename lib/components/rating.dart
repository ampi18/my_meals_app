import 'package:flutter/material.dart';

class Rating extends StatelessWidget {
  final int rating;
  const Rating({super.key, required this.rating});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        for (var i = 0; i < rating; i++)
          const Icon(Icons.star, color: Colors.amber),
        for (var i = 0; i < 5 - rating; i++)
          const Icon(Icons.star, color: Colors.grey),
      ],
    );
  }
}
