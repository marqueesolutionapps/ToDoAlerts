import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todoalerts/Utility/UtilityLibrary.dart';

class DatabaseHelper {
  static final _databaseName = "To_Do_Alerts.db";
  static final _databaseVersion = 1;
  static final notificationTable = dbNotificationTable;
  static final notificationColumnID = "id";
  static final notificationColumnTimeStamp = "timestamp";
  static final notificationColumnBody = "body";
  static final notificationColumnTitle = "title";
  static final notificationColumnStatus = "status";

  static Database? _database;
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  _initDatabase() async {
    Directory documentdirectory = await getApplicationDocumentsDirectory();
    String path = join(documentdirectory.path, _databaseName);
    return await openDatabase(path, version: _databaseVersion, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute(
        "CREATE TABLE $notificationTable ($notificationColumnID INTEGER PRIMARY KEY AUTOINCREMENT,$notificationColumnTimeStamp TEXT NULL,$notificationColumnBody TEXT NULL,$notificationColumnTitle TEXT NULL,$notificationColumnStatus INTEGER NULL)");
  }

  // custom function CRUD operation
  // ignore: missing_return
  Future<int> insertRecord(String tableName, Map<String, dynamic> row) async {
    Database db = await instance.database;
    return await db.insert(notificationTable, row);
  }

  // ignore: missing_return
  Future<List<Map<String, dynamic>>> queryAll() async {
    Database db = await instance.database;
    return await db.query(
      notificationTable,
    );
  }

  // ignore: missing_return
  Future<List<Map<String, dynamic>>> querySpecific(String id) async {
    Database db = await instance.database;
    var res = await db
        .query(notificationTable, where: "recordId = ?", whereArgs: [id]);
    return res;
  }

  Future<int> updateStatus(int id, Map<String, dynamic> row) async {
    Database db = await instance.database;
    var res = await db.update(notificationTable, row,
        where: '$notificationColumnID = ?', whereArgs: [id]);
    return res;
  }

  Future deleteRecord(int id) async {
    Database db = await instance.database;
    var res = await db.delete(notificationTable, where: "id = $id");
    return res;
  }

  Future deleteAllRecord() async {
    Database db = await instance.database;
    var res = await db.rawDelete("delete from " + notificationTable);
    return res;
  }
}