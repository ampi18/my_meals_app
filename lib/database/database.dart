import 'package:my_meals_app/models/meal.dart';
import 'package:my_meals_app/models/meal_time.dart';
import 'package:my_meals_app/models/origin.dart';
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
        date: DateTime.now(),
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
        date: DateTime.now(),
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
        date: DateTime.now(),
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

  Future<List<Meal>> meals() async {
    final db = await _databaseService.database;
    final List<Map<String, dynamic>> maps = await db.query('meal');
    return List.generate(maps.length, (index) => Meal.fromMap(maps[index]));
  }

  Future<List<Meal>> findByName(String name) async {
    final db = await _databaseService.database;
    final q = "$name%";
    final List<Map<String, dynamic>> maps =
        await db.query('meal', where: 'name like ?', whereArgs: [q]);
    return List.generate(maps.length, (index) => Meal.fromMap(maps[index]));
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
