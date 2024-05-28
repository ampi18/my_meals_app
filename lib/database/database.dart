import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:my_meals_app/logic/models/meal.dart';
import 'package:my_meals_app/logic/models/meal_time.dart';
import 'package:my_meals_app/logic/models/origin.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseService {
  static final DatabaseService _databaseService = DatabaseService._internal();
  factory DatabaseService() => _databaseService;
  DatabaseService._internal();

  static Database? _database;

  Future<Database> get database async {
    _database ??= await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, 'flutter_database.db');

    return await openDatabase(
      path,
      onCreate: _onCreate,
      version: 1,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('DROP TABLE IF EXISTS meal');
    await db.execute(
      'CREATE TABLE meal (id INTEGER PRIMARY KEY, name TEXT, comment TEXT, mealTime INTEGER, rating INTEGER, origin INTEGER, source TEXT, date TEXT)',
    );
  }

  Future<void> populateData() async {
    final String response =
        await rootBundle.loadString('assets/data/initial_meals.json');
    final List<dynamic> data = json.decode(response);

    for (var item in data) {
      insertMeal(
        Meal(
          id: item['id'],
          name: item['name'],
          mealTime:
              MealTime.values.firstWhere((e) => e.name == item['mealTime']),
          rating: item['rating'],
          origin: Origin.values.firstWhere((e) => e.name == item['origin']),
          source: item['source'],
          date: DateTime.parse(item['date']),
          comment: item['comment'],
        ),
      );
    }
  }

  Future<int> insertMeal(Meal meal) async {
    final db = await _databaseService.database;
    return await db.insert(
      'meal',
      meal.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Meal>> meals({
    bool ascending = true,
    List<int>? ratings,
    List<int>? mealTimes,
    List<int>? origins,
    String? searchText,
  }) async {
    final db = await _databaseService.database;

    final String sortOrder = ascending ? 'ASC' : 'DESC';
    ratings ??= List<int>.generate(5, (index) => index + 1);
    mealTimes ??= List<int>.generate(4, (index) => index);
    origins ??= List<int>.generate(4, (index) => index);

    List<String> whereClauses = [
      'rating IN (${List<String>.filled(ratings.length, '?').join(', ')})',
      'mealTime IN (${List<String>.filled(mealTimes.length, '?').join(', ')})',
      'origin IN (${List<String>.filled(origins.length, '?').join(', ')})'
    ];

    List<dynamic> whereArgs = [...ratings, ...mealTimes, ...origins];

    if (searchText != null && searchText.isNotEmpty) {
      whereClauses.add('name LIKE ?');
      whereArgs.add('%$searchText%');
    }

    final String whereClause = whereClauses.join(' AND ');

    final List<Map<String, dynamic>> maps = await db.query(
      'meal',
      orderBy: 'date $sortOrder',
      where: whereClause,
      whereArgs: whereArgs,
    );

    return List.generate(maps.length, (index) => Meal.fromMap(maps[index]));
  }

  Future<Meal> meal(int id) async {
    final db = await _databaseService.database;
    final List<Map<String, dynamic>> maps =
        await db.query('meal', where: 'id = ?', whereArgs: [id]);
    return Meal.fromMap(maps.first);
  }

  Future<void> updateMeal(Meal meal) async {
    final db = await _databaseService.database;
    await db
        .update('meal', meal.toMap(), where: 'id = ?', whereArgs: [meal.id]);
  }

  Future<void> deleteMeal(int id) async {
    final db = await _databaseService.database;
    await db.delete('meal', where: 'id = ?', whereArgs: [id]);
  }
}
