import 'package:flutter/material.dart';
import 'package:my_meals_app/models/meal_time.dart';

class MealTimesRow extends StatelessWidget {
  final MealTime mealTime;
  const MealTimesRow({Key? key, required this.mealTime}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildCircleAvatar('assets/images/breakfast.jpeg', MealTime.breakfast),
        _buildCircleAvatar('assets/images/lunch.jpeg', MealTime.lunch),
        _buildCircleAvatar('assets/images/dinner.jpeg', MealTime.dinner),
        _buildCircleAvatar('assets/images/snack.jpeg', MealTime.snack),
      ],
    );
  }

  Widget _buildCircleAvatar(String imagePath, MealTime correspondingMealTime) {
    final bool isCurrentMealTime = mealTime == correspondingMealTime;
    return ClipOval(
      child: ColorFiltered(
        colorFilter: isCurrentMealTime
            ? const ColorFilter.mode(Colors.transparent, BlendMode.color)
            : const ColorFilter.mode(Colors.grey, BlendMode.saturation),
        child: CircleAvatar(
          radius: 30,
          backgroundImage: AssetImage(imagePath),
        ),
      ),
    );
  }
}
