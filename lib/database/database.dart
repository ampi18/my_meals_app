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
    insertMeal(
      Meal(
        id: 1,
        name: 'Spaghetti',
        mealTime: MealTime.lunch,
        rating: 4,
        origin: Origin.homecooked,
        source: 'cookidoo/spaghetti',
        date: DateTime.now(),
        comment: 'Add more salt next time',
      ),
    );
    insertMeal(
      Meal(
        id: 2,
        name: 'Fried Rice',
        mealTime: MealTime.dinner,
        rating: 5,
        origin: Origin.delivery,
        source: 'lieferando/myfavchineserestaurant',
        date: DateTime.parse('2023-03-01'),
        comment: 'Was totally delicious',
      ),
    );
    insertMeal(
      Meal(
        id: 3,
        name: 'Pancakes',
        mealTime: MealTime.breakfast,
        rating: 3,
        origin: Origin.restaurant,
        source: 'Some breakfast place in Würzburg',
        date: DateTime.parse('2022-11-13'),
        comment: 'Seemed dry, but okay with Nutella',
      ),
    );
    insertMeal(
      Meal(
        id: 4,
        name: 'Cheese Cake',
        mealTime: MealTime.snack,
        rating: 5,
        origin: Origin.other,
        source: 'at my grandmothers place',
        date: DateTime.parse('2019-06-12'),
        comment: 'best you can get',
      ),
    );
  }

  Future<void> insertMeal(Meal meal) async {
    final db = await _databaseService.database;
    await db.insert(
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
    String searchText = '',
  }) async {
    final db = await _databaseService.database;

    final String sortOrder = ascending ? 'ASC' : 'DESC';
    ratings ??= List<int>.generate(5, (index) => index + 1);
    mealTimes ??= List<int>.generate(4, (index) => index);
    origins ??= List<int>.generate(4, (index) => index);

    // final List<Map<String, dynamic>> maps = await db.query(
    //   'meal',
    //   orderBy: 'date $sortOrder',
    //   where:
    //       'rating IN (${List<String>.filled(ratings.length, '?').join(', ')}) '
    //       'AND mealTime IN (${List<String>.filled(mealTimes.length, '?').join(', ')}) '
    //       'AND origin IN (${List<String>.filled(origins.length, '?').join(', ')}) ',
    //   whereArgs: [...ratings, ...mealTimes, ...origins],
    // );

    List<String> whereClauses = [
      'rating IN (${List<String>.filled(ratings.length, '?').join(', ')})',
      'mealTime IN (${List<String>.filled(mealTimes.length, '?').join(', ')})',
      'origin IN (${List<String>.filled(origins.length, '?').join(', ')})'
    ];

    List<dynamic> whereArgs = [...ratings, ...mealTimes, ...origins];

    if (searchText.isNotEmpty) {
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
