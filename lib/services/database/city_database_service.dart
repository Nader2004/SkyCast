import 'package:path/path.dart';
import 'package:sky_cast/models/city.dart';
import 'package:sqflite/sqflite.dart';

class CityDatabaseService {
  static final CityDatabaseService instance = CityDatabaseService._internal();

  static Database? _database;

  CityDatabaseService._internal();

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }

    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, 'cities.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDatabase,
    );
  }

  Future<void> _createDatabase(Database db, _) async {
    return await db.execute('''
        CREATE TABLE cities (
          name TEXT NOT NULL,
          lon REAL NOT NULL,
          lat REAL NOT NULL,
          country TEXT NOT NULL,
          isMyLocation INTEGER,
          orderIndex INTEGER
        )
      ''');
  }

  Future<City> create(City city) async {
    final db = await instance.database;
    await db.insert('cities', city.toJson());
    return city;
  }

  Future<City?> read(String name) async {
    final db = await instance.database;
    final maps = await db.query(
      'cities',
      columns: ['name', 'lon', 'lat', 'country', 'isMyLocation', 'orderIndex'],
      where: 'name = ?',
      whereArgs: [name],
    );

    if (maps.isNotEmpty) {
      return City.fromJson(maps.first);
    } else {
      return null;
    }
  }

  Future<List<City>> readAll() async {
    final db = await instance.database;
    final result = await db.query('cities', orderBy: 'orderIndex ASC');
    return result.map((json) => City.fromJson(json)).toList();
  }

  Future<int> writeAll(List<City> cities) async {
    await deleteAll();
    final db = await instance.database;
    final batch = db.batch();
    for (var city in cities) {
      batch.insert(
        'cities',
        city.toJson(),
      );
    }
    final results = await batch.commit();
    return results.length;
  }

  Future<void> deleteAll() async {
    final db = await instance.database;
    await db.delete('cities');
  }

  Future<int> update(City city) async {
    final db = await instance.database;
    return db.update(
      'cities',
      city.toJson(),
      where: 'name = ?',
      whereArgs: [city.name],
    );
  }

  Future<int> delete(String name) async {
    final db = await instance.database;
    return await db.delete(
      'cities',
      where: 'name = ?',
      whereArgs: [name],
    );
  }

  Future<void> reorderCities(List<City> cities) async {
    final db = await instance.database;
    final batch = db.batch();
    for (int i = 0; i < cities.length; i++) {
      final city = cities[i].copyWith(orderIndex: i);
      batch.update(
        'cities',
        city.toJson(),
        where: 'name = ?',
        whereArgs: [city.name],
      );
    }
    await batch.commit(noResult: true);
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }
}