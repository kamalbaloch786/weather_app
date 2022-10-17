import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../Model/City/City_Model.dart';
import '../utility/constant_parameter.dart';

class DatabaseHelper {
  DatabaseHelper._privateConstructor();

  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();
  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initiateDatabase();
    return _database!;
  }

  _initiateDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path, 'weatherss.db');
    return await openDatabase(path,
        version: ld_para_db_version, onCreate: _onCreate);
  }

  Future<void> _onCreate(Database db, int version) {
    return db.execute('''
      CREATE TABLE $ld_para_city_table_name(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        city_name TEXT NOT NULL,
        lat REAL NOT NULL,
        long REAL NOT NULL

      )
      ''');
  }

  Future<int> add_City(City_Model city_model) async {
    Database db = await instance.database;
    return await db.insert(ld_para_city_table_name, city_model.toMap());
  }

  Future<List<City_Model>> getcitys() async {
    Database db = await instance.database;
    final List<Map<String, dynamic>> maps =
        await db.query(ld_para_city_table_name);

    return List.generate(
      maps.length,
      (index) {
        return City_Model(
          id: maps[index][ld_para_id],
          city_name: maps[index][ld_para_city_name],
          lat: maps[index][ld_para_lat],
          long: maps[index][ld_para_long],
        );
      },
    );
  }

  Future<int> delete_city(City_Model city_model) async {
    Database db = await instance.database;
    return await db.delete(
      ld_para_city_table_name,
      where: "id = ?",
      whereArgs: [city_model.id],
    );
  }
}
