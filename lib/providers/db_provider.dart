

import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DBProvider {


  static Database? _database;
  static final DBProvider db = DBProvider._();
  //constructor privado
  DBProvider._();

  //     resuelve
  Future<Database> get database async {

    if (_database != null ) return _database!;  

    _database = await initDB();

    return _database!;

  }

  Future<Database?> initDB() async{ 
    //path de donde almacenaremos bd
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join( documentsDirectory.path, 'ScansDB.db' );
    print(path);

    //crear base de datos
    return await openDatabase(
      path,
      version: 1,
      onOpen: (db) {},
      onCreate: (Database db, int version) async{

        await db.execute('''
          CREATE TABLE scans(
            id INTEGER PRIMARY KEY,
            type TEXT,
            value TEXT
          )
        ''');
      }
      );

  }
}