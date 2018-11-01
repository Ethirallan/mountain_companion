import 'dart:async';
import 'dart:io' as io;
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:mountain_companion/models/travel.dart';

class TravelDBHelper {
  final String tableName = "TravelTable";
  
  static Database dbInstance;
  
  Future<Database> get db async {
    if (dbInstance == null) {
      dbInstance = await initDB();
    }
    return dbInstance;
  }
  
  initDB() async {
    io.Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "traveltable.db");
    var db = await openDatabase(path, version: 1, onCreate: _onCreate);
    return db;
  }
  
  void _onCreate(Database db, int version) async {
    await db.execute('CREATE TABLE $tableName(id INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT, date TEXT, time TEXT,'
            'location TEXT, height TEXT, notes TEXT, photo1 TEXT, photo2 TEXT, photo3 TEXT, photo4 TEXT, photo5 TEXT, photo6 TEXT);');
  }

  Future<List<Travel>> getTravels() async {
    var dbConnection = await db;
    List<Map> list = await dbConnection.rawQuery('SELECT * FROM $tableName');
    List<Travel> travels = new List();
    for (int i = 0; i < list.length; i++) {
      Travel travel = new Travel();
      travel.id = list[i]['id'];
      travel.title = list[i]['title'];
      travel.date = list[i]['date'];
      travel.time = list[i]['time'];
      travel.location = list[i]['location'];
      travel.height = list[i]['height'];
      travel.notes = list[i]['notes'];
      travel.photo1 = list[i]['photo1'];
      travel.photo2 = list[i]['photo2'];
      travel.photo3 = list[i]['photo3'];
      travel.photo4 = list[i]['photo4'];
      travel.photo5 = list[i]['photo5'];
      travel.photo6 = list[i]['photo6'];
      travels.add(travel);
    }
    return travels;
  }

  void addNewTravel(Travel travel) async {
    var dbConnection = await db;
    String query = 'INSERT INTO $tableName(title, date, location, time, height, notes, photo1, photo2, photo3, photo4, photo5, photo6) '
            'VALUES(\'${travel.title}\', \'${travel.date}\', \'${travel.location}\', \'${travel.time}\', \'${travel.height}\', \'${travel.notes}\', '
            '\'${travel.photo1}\', \'${travel.photo2}\', \'${travel.photo3}\', \'${travel.photo4}\', \'${travel.photo5}\', \'${travel.photo6}\')';
    await dbConnection.transaction((tran) async {
      return await tran.rawInsert(query);
    });
  }

  void updateTravel(Travel travel) async {
    var dbConnection = await db;
    String query = 'UPDATE $tableName SET title=\'${travel.title}\', date=\'${travel.date}\', time=\'${travel.time}\','
        'location=\'${travel.location}\', height=\'${travel.height}\', notes=\'${travel.notes}\', photo1=\'${travel.photo1}\', photo2=\'${travel.photo2}\','
        'photo3=\'${travel.photo3}\', photo4=\'${travel.photo4}\', photo5=\'${travel.photo5}\', photo6=\'${travel.photo6}\' WHERE id=${travel.id}';
    await dbConnection.transaction((tran) async {
      return await tran.rawQuery(query);
    });
  }

  void deleteTravel(Travel travel) async {
    var dbConnection = await db;
    String query = 'DELETE FROM $tableName WHERE id=${travel.id}';
    await dbConnection.transaction((tran) async {
      return await tran.rawQuery(query);
    });
  }
}
