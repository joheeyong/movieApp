import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import '../../model/movie.dart';

//최근본상품 저장 DB

final recentItemHistoryDatabaseHelper instance = recentItemHistoryDatabaseHelper._privateConstructor();

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
  backdropPath TEXT,
  id INTEGER PRIMARY KEY,
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

    return await db.delete('recentItemHistoryC', where: "id = ?", whereArgs: [product.id]);
  }

  Future<List<Results>> getProducts() async {
    Database db = await instance.database;

    List<Map<String, Object?>> Products = await db.query('recentItemHistoryC', orderBy: 'id DESC', limit: 100, groupBy: 'id');

    List<Results> itemHistory =
    Products.isNotEmpty ? Products.map((Map<String, Object?> c) => Results.fromJson(c)).toList() : [];

    return itemHistory;
  }
  //
  // Future<void> deleteExpiredItems() async {
  //   Database db = await instance.database;
  //
  //   DateTime currentDateTime = DateTime.now();
  //   DateTime expirationDateTime = currentDateTime.subtract(const Duration(days: 30));
  //   String expirationTimeString = expirationDateTime.toIso8601String();
  //
  //   await db.delete(
  //     'recentItemHistoryC',
  //     where: 'date <= ?',
  //     whereArgs: [expirationTimeString],
  //   );
  // }
}
