enum MealTime {
  breakfast,
  lunch,
  dinner,
  snack;

  @override
  String toString() {
    switch (this) {
      case MealTime.breakfast:
        return 'Breakfast';
      case MealTime.lunch:
        return 'Lunch';
      case MealTime.dinner:
        return 'Dinner';
      case MealTime.snack:
        return 'Snack';
      default:
        return '';
    }
  }
}
