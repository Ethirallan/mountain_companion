import 'dart:async';
import 'dart:io' as io;
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:mountain_companion/models/wish.dart';

class WishDBHelper {
  final String tableName = "Wish";

  static Database dbInstance;

  Future<Database> get db async {
    if (dbInstance == null) {
      dbInstance = await initDB();
    }
    return dbInstance;
  }

  initDB() async {
    io.Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "wishlist.db");
    var db = await openDatabase(path, version: 1, onCreate: _onCreate);
    return db;
  }

  void _onCreate(Database db, int version) async {
    await db.execute('CREATE TABLE $tableName(id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT);');
  }

  Future<List<Wish>> getWishes() async {
    var dbConnection = await db;
    List<Map> list = await dbConnection.rawQuery('SELECT * FROM $tableName');
    List<Wish> wishes = new List();
    for (int i = 0; i < list.length; i++) {
      Wish wish = new Wish();
      wish.id = list[i]['id'];
      wish.name = list[i]['name'];
      wishes.add(wish);
    }
    return wishes;
  }

  void addNewWish(Wish wish) async {
    var dbConnection = await db;
    String query = 'INSERT INTO $tableName(name) VALUES(\'${wish.name}\')';
    await dbConnection.transaction((tran) async {
      return await tran.rawInsert(query);
    });
  }

  void updateWish(Wish wish) async {
    var dbConnection = await db;
    String query = 'UPDATE $tableName SET name=\'${wish.name}\' WHERE id=${wish.id}';
    await dbConnection.transaction((tran) async {
      return await tran.rawQuery(query);
    });
  }

  void deleteWish(Wish wish) async {
    var dbConnection = await db;
    String query = 'DELETE FROM $tableName WHERE id=${wish.id}';
    await dbConnection.transaction((tran) async {
      return await tran.rawQuery(query);
    });
  }
}