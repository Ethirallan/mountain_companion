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
    await db.execute('CREATE TABLE $tableName(id INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT, date TEXT,finalLocation TEXT, '
        'finalTime TEXT, finalHeight TEXT, notes TEXT,'
        'photo1 TEXT, photo2 TEXT, photo3 TEXT, photo4 TEXT, photo5 TEXT, photo6 TEXT,'
        'location1 TEXT, location2 TEXT, location3 TEXT, location4 TEXT, location5 TEXT, location6 TEXT,'
        'time1 TEXT, time2 TEXT, time3 TEXT, time4 TEXT, time5 TEXT, time6 TEXT,'
        'height1 TEXT, height2 TEXT, height3 TEXT, height4 TEXT, height5 TEXT, height6 TEXT);');
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
      travel.finalLocation = list[i]['location'];
      travel.finalTime = list[i]['time'];
      travel.finalHeight = list[i]['height'];
      travel.notes = list[i]['notes'];
      travel.photo1 = list[i]['photo1'];
      travel.photo2 = list[i]['photo2'];
      travel.photo3 = list[i]['photo3'];
      travel.photo4 = list[i]['photo4'];
      travel.photo5 = list[i]['photo5'];
      travel.photo6 = list[i]['photo6'];
      travel.location1 = list[i]['location1'];
      travel.location2 = list[i]['location2'];
      travel.location3 = list[i]['location3'];
      travel.location4 = list[i]['location4'];
      travel.location5 = list[i]['location5'];
      travel.location6 = list[i]['location6'];
      travel.time1 = list[i]['time1'];
      travel.time2 = list[i]['time2'];
      travel.time3 = list[i]['time3'];
      travel.time4 = list[i]['time4'];
      travel.time5 = list[i]['time5'];
      travel.time6 = list[i]['time6'];
      travel.height1 = list[i]['height1'];
      travel.height2 = list[i]['height2'];
      travel.height3 = list[i]['height3'];
      travel.height4 = list[i]['height4'];
      travel.height5 = list[i]['height5'];
      travel.height6 = list[i]['height6'];
      travels.add(travel);
    }
    return travels;
  }

  void addNewTravel(Travel travel) async {
    var dbConnection = await db;
    String query = 'INSERT INTO $tableName(title, date, finalLocation, finalTime, finalHeight, notes, photo1, photo2, photo3, photo4, photo5, photo6,'
      'location1, location2, location3, location4, location5, location6,'
      'time1, time2, time3, time4, time5, time6,'
      'height1, height2, height3, height4, height5, height6) '
      'VALUES(\'${travel.title}\', \'${travel.date}\', \'${travel.finalLocation}\', \'${travel.finalTime}\', \'${travel.finalHeight}\', \'${travel.notes}\', '
      '\'${travel.photo1}\', \'${travel.photo2}\', \'${travel.photo3}\', \'${travel.photo4}\', \'${travel.photo5}\', \'${travel.photo6}\','
      '\'${travel.location1}\', \'${travel.location2}\', \'${travel.location3}\', \'${travel.location4}\', \'${travel.location5}\', \'${travel.location6}\','
      '\'${travel.time1}\', \'${travel.time2}\', \'${travel.time3}\', \'${travel.time4}\', \'${travel.time5}\', \'${travel.time6}\','
      '\'${travel.height1}\', \'${travel.height2}\', \'${travel.height3}\', \'${travel.height4}\', \'${travel.height5}\', \'${travel.height6}\')';
    await dbConnection.transaction((tran) async {
      return await tran.rawInsert(query);
    });
  }

  void updateTravel(Travel travel) async {
    var dbConnection = await db;
    String query = 'UPDATE $tableName SET title=\'${travel.title}\', date=\'${travel.date}\', finalLocation=\'${travel.finalLocation}\',  finalTime=\'${travel.finalTime}\','
        'finalHeight=\'${travel.finalHeight}\', notes=\'${travel.notes}\', photo1=\'${travel.photo1}\', photo2=\'${travel.photo2}\','
        'photo3=\'${travel.photo3}\', photo4=\'${travel.photo4}\', photo5=\'${travel.photo5}\', photo6=\'${travel.photo6}\','
        'location1=\'${travel.location1}\', location2=\'${travel.location2}\', location3=\'${travel.location3}\', location4=\'${travel.location4}\', location5=\'${travel.location5}\', location6=\'${travel.location6}\','
        'time1=\'${travel.time1}\', time2=\'${travel.time2}\', time3=\'${travel.time3}\', time4=\'${travel.time4}\', time5=\'${travel.time5}\', time6=\'${travel.time6}\','
        'heigth1=\'${travel.height1}\', heigth2=\'${travel.height2}\', heigth3=\'${travel.height3}\', heigth4=\'${travel.height4}\', heigth5=\'${travel.height5}\', heigth6=\'${travel.height6}\''
        'WHERE id=${travel.id}';
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
