import 'package:flutter/material.dart';

enum Origin {
  homecooked(icon: Icons.home, color: Colors.blue),
  delivery(icon: Icons.delivery_dining, color: Colors.orange),
  restaurant(icon: Icons.restaurant, color: Colors.green),
  other(icon: Icons.more_horiz, color: Colors.grey);

  const Origin({required this.icon, required this.color});

  final IconData icon;
  final Color color;

  @override
  String toString() {
    switch (this) {
      case Origin.homecooked:
        return 'Homecooked';
      case Origin.delivery:
        return 'Delivery';
      case Origin.restaurant:
        return 'Restaurant';
      case Origin.other:
        return 'Other';
      default:
        return '';
    }
  }
}
