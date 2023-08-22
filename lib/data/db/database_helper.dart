import 'package:flutter_restaurant/data/model/detail_restaurant.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static DatabaseHelper? _instance;
  static Database? _database;

  DatabaseHelper._internal() {
    _instance = this;
  }

  factory DatabaseHelper() => _instance ?? DatabaseHelper._internal();

  static const String _tblFavoriteRestaurant = 'tbl_favorite_restaurants';

  Future<Database> _initializeDB() async {
    var path = await getDatabasesPath();
    var db =
        openDatabase('$path/puth_food_resto.db', onCreate: (db, version) async {
      await db.execute('''CREATE TABLE $_tblFavoriteRestaurant (
          id TEXT PRIMARY KEY,
          name TEXT,
          description TEXT,
          city TEXT,
          address TEXT,
          pictureId TEXT
        )
        ''');
    }, version: 1);

    return db;
  }

  Future<Database?> get database async {
    _database ??= await _initializeDB();
    return _database;
  }

  Future<void> insertFavoriteRestaurant(Restaurant restaurant) async {
    final db = await database;
    await db!.insert(_tblFavoriteRestaurant, restaurant.toDB());
  }

  Future<List<Restaurant>> getFavoriteRestaurants() async {
    final db = await database;
    List<Map<String, dynamic>> results =
        await db!.query(_tblFavoriteRestaurant);

    return results.map((res) => Restaurant.fromDB(res)).toList();
  }

  Future<Map> getFavoriteRestaurantById(String restaurantId) async {
    final db = await database;
    List<Map<String, dynamic>> results = await db!.query(_tblFavoriteRestaurant,
        where: 'id = ?', whereArgs: [restaurantId]);

    if (results.isNotEmpty) {
      return results.first;
    } else {
      return {};
    }
  }

  Future<void> removeFavoriteRestaurantById(String restaurantId) async {
    final db = await database;

    await db!.delete(_tblFavoriteRestaurant,
        where: 'id = ?', whereArgs: [restaurantId]);
  }
}
