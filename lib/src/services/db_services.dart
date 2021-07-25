import 'dart:io';
import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:places/src/models/citynames.dart';

class DatabaseService {
  late Database _db;

  initDatabase() async {
    _db = await openDatabase('assets/citydb.db');
    var databasePath = await getDatabasesPath();
    var path = join(databasePath, 'citydb.db');

    //Check if DB exists
    var exists = await databaseExists(path);

    if (!exists) {
      print('Create a new copy from assets');

      //Check if parent directory exists
      try {
        await Directory(dirname(path)).create(recursive: true);

        //Copy from assets
        ByteData data = await rootBundle.load("assets/files/citydb.db");
        List<int> bytes =
            data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);

        //Write and flush the bytes
        await File(path).writeAsBytes(bytes, flush: true);
      } catch (e) {
        print(e);
      }
    }

    //Open the database
    _db = await openDatabase(path, readOnly: true);
  }

  Future getNames() async {
    await initDatabase();
    List<Map> list = await _db.rawQuery('SELECT * FROM cityname');
    print(list.length);
  }

  dispose() {
    _db.close();
  }
}
