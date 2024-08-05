// ignore_for_file: non_constant_identifier_names, camel_case_types, depend_on_referenced_packages

import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import '../../model/movie.dart';

final recentItemHistoryDatabaseHelper instance =
    recentItemHistoryDatabaseHelper._privateConstructor();

class recentItemHistoryDatabaseHelper {
  recentItemHistoryDatabaseHelper._privateConstructor();

  Database? _database;

  Future<Database> get database async => _database ??= await initDatabase();

  Future<Database> initDatabase() async {
    String path = join(await getDatabasesPath(), 'recentItemHistoryC.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
    CREATE TABLE recentItemHistoryC (
    idd INTEGER PRIMARY KEY,
  id INTEGER,
  backdropPath TEXT,
  lastAirData TEXT,
  name TEXT,
  type TEXT,
  title TEXT,
  originalTitle TEXT,
  overview TEXT,
  tagline TEXT,
  posterPath TEXT,
  mediaType TEXT,
  adult BOOLEAN,
  originalLanguage TEXT,
  popularity REAL,
  releaseDate TEXT,
  video BOOLEAN,
  voteAverage REAL,
  voteCount INTEGER,
  runtime INTEGER,
  numberOfSeasons INTEGER,
  episodes INTEGER,
  seasons INTEGER,
  details BOOLEAN,
  firstAirDate TEXT
)
    ''');
  }

  Future<int> add(Results product) async {
    Database db = await instance.database;

    return await db.insert('recentItemHistoryC', product.toMap());
  }

  Future<int> delete(Results product) async {
    Database db = await instance.database;

    return await db
        .delete('recentItemHistoryC', where: "id = ?", whereArgs: [product.id]);
  }

  Future<List<Results>> getProducts() async {
    Database db = await instance.database;

    List<Map<String, Object?>> Products = await db.query('recentItemHistoryC', limit: 100, groupBy: 'id', orderBy: 'idd DESC');

    List<Results> itemHistory =
    Products.isNotEmpty
        ? Products.map((Map<String, Object?> c) => Results.fromJson(c)).toList()
        : [];

    return itemHistory;
  }
}
