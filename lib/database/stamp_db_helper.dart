import 'dart:async';
import 'dart:io' as io;
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:mountain_companion/models/stamp.dart';

class StampDBHelper {
  final String tableName = "Stamp";

  static Database dbInstance;

  Future<Database> get db async {
    if (dbInstance == null) {
      dbInstance = await initDB();
    }
    return dbInstance;
  }

  initDB() async {
    io.Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "stamplist.db");
    var db = await openDatabase(path, version: 1, onCreate: _onCreate);
    return db;
  }

  void _onCreate(Database db, int version) async {
    await db.execute('CREATE TABLE $tableName(id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, img TEXT);');
  }

  Future<List<Stamp>> getStamps() async {
    var dbConnection = await db;
    List<Map> list = await dbConnection.rawQuery('SELECT * FROM $tableName');
    List<Stamp> stamps = new List();
    for (int i = 0; i < list.length; i++) {
      Stamp stamp = new Stamp();
      stamp.id = list[i]['id'];
      stamp.name = list[i]['name'];
      stamp.img = list[i]['img'];
      stamps.add(stamp);
    }
    return stamps;
  }

  void addNewStamp(Stamp stamp) async {
    var dbConnection = await db;
    String query = 'INSERT INTO $tableName(name, img) VALUES(\'${stamp.name}\',\'${stamp.img}\')';
    await dbConnection.transaction((tran) async {
      return await tran.rawInsert(query);
    });
  }

  void updateStamp(Stamp stamp) async {
    var dbConnection = await db;
    String query = 'UPDATE $tableName SET name=\'${stamp.name}\', img=\'${stamp.img}\' WHERE id=${stamp.id}';
    await dbConnection.transaction((tran) async {
      return await tran.rawQuery(query);
    });
  }

  void deleteStamp(Stamp stamp) async {
    var dbConnection = await db;
    String query = 'DELETE FROM $tableName WHERE id=${stamp.id}';
    await dbConnection.transaction((tran) async {
      return await tran.rawQuery(query);
    });
  }
}