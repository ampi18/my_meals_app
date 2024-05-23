import 'package:my_meals_app/models/meal_time.dart';
import 'package:my_meals_app/models/origin.dart';

class Meal {
  late int id;
  late String name;
  late String? comment;
  late MealTime mealTime;
  late int rating;
  late Origin origin;
  late String source;
  late DateTime date;

  Meal({
    required this.id,
    required this.name,
    this.comment,
    required this.mealTime,
    required this.rating,
    required this.origin,
    required this.source,
    required this.date,
  });

  Meal.fromMap(Map map) {
    id = map['id'];
    name = map['name'];
    comment = map['comment'];
    mealTime = MealTime.values[map['mealTime']];
    rating = map['rating'];
    origin = Origin.values[map['origin']];
    source = map['source'];
    date = DateTime.parse(map['date']);
  }

  Map<String, Object?> toMap() {
    var map = <String, dynamic>{
      'name': name,
      'comment': comment,
      'mealTime': mealTime.index,
      'rating': rating,
      'origin': origin.index,
      'source': source,
      'date': date.toIso8601String(),
    };

    if (id != 0) map['id'] = id;

    return map;
  }
}
