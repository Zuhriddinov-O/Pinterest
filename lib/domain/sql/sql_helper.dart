import "package:flutter/cupertino.dart";
import "package:pinterest/domain/sql/sql_saved_model.dart";
import "package:sqflite/sqflite.dart" as sql;
import 'package:sqflite/sqlite_api.dart';

class SqlHelper {
  static Future<void> createImage(sql.Database dataBase) async {
    dataBase.execute("""
      CREATE TABLE rules(
      id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
      image TEXT NOT NULL,
      wid TEXT NOT NULL,
      heights TEXT NOT NULL,
      likes INTEGER NOT NULL,
      saved Text NOT NULL,
      followed TEXT NOT NULL,
      )
      """);
  }

  static Future<sql.Database> db() async {
    return sql.openDatabase(
      "rules.db",
      onCreate: (sql.Database database, int version) {
        return createImage(database);
      },
    );
  }

  static Future<void> saveImages(SavedModels images) async {
    final data = await SqlHelper.db();
    await data.insert("rules", images.toJson(), conflictAlgorithm: ConflictAlgorithm.ignore);
  }

  static Future<List<SavedModels>> getAllModels() async {
    try {
      final data = await SqlHelper.db();
      final maps = await data.query("rules");
      return maps.map((e) => SavedModels.fromJson(e)).toList();
    } catch (e) {
      debugPrint(e.toString());
      return [];
    }
  }

  static Future<void> deleteModels(int? id) async {
    final data = await SqlHelper.db();
    await data.delete("rules", where: "id=?", whereArgs: ["$id"]);
  }

  static Future<void> updateModels(int? id, SavedModels photos) async {
    final data = await SqlHelper.db();
    await data.update("rules", photos.toJson(),
        where: "id=?", whereArgs: ["$id"], conflictAlgorithm: ConflictAlgorithm.ignore);
  }

  static Future<void> clear() async {
    final data = await SqlHelper.db();
    await data.query("DELETE FROM rules");
  }

  static Future<SavedModels?> getById(int? id) async {
    try {
      final data = await SqlHelper.db();
      final list = await data.query("rules", where: "$id", whereArgs: ["$id"]);
      final photo = list[0];
      return SavedModels.fromJson(photo);
    } catch (e) {
      return null;
    }
  }
}
