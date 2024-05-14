import "package:sqflite/sql.dart";
import "package:sqflite/sqflite.dart" as sql;

import "sql_saved_model.dart";

class SqlHelper {
  static Future<void> createPhoto(sql.Database database) async {
    database.execute("""
        CREATE TABLE rules(
        id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        color TEXT NOT NULL,
        altDescription TEXT NOT NULL,
        image TEXT NOT NULL,
        userId Text NOT NULL,
        userName TEXT NOT NULL,
        name TEXT NOT NULL,
        firstName TEXT NOT NULL,
        lastName TEXT NOT NULL,
        bio TEXT NOT NULL,
        ) 
        """);
  }

  static Future<sql.Database> base() async {
    return sql.openDatabase(
      "rules.db",
      version: 1,
      onCreate: (sql.Database database, int version) async {
        return createPhoto(database);
      },
    );
  }

  static Future<void> saveSign(Favorites photos) async {
    final data = await SqlHelper.base();
    await data.insert("rules", photos.toJson(), conflictAlgorithm: ConflictAlgorithm.ignore);
  }

  static Future<List<Favorites>> getAllPhotos() async {
    try {
      final data = await SqlHelper.base();
      final maps = await data.query("rules");
      return maps.map((e) => Favorites.fromJSon(e)).toList();
    } catch (e) {
      return [];
    }
  }

  static Future<void> updatePhoto(int? id, Favorites photos) async {
    final data = await SqlHelper.base();
    await data.update("rules", photos.toJson(), where: "id=?", whereArgs: ["$id"]);
  }

  static Future<void> clear() async {
    final data = await SqlHelper.base();
    await data.query("DELETE FROM rules");
  }

  static Future<Favorites?> getById(int? id) async {
    try {
      final data = await SqlHelper.base();
      final list = await data.query("rules", where: "userId = ?", whereArgs: ["$id"]);
    } catch (e) {
      return null;
    }
    return null;
  }
}
