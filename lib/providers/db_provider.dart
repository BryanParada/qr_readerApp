

import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import 'package:qr_reader/models/scan_model.dart';
export 'package:qr_reader/models/scan_model.dart';

class DBProvider {


  static Database? _database;
  static final DBProvider db = DBProvider._();
  // Constructor privado que se usa para crear la instancia db
  DBProvider._();

  //     resuelve
   /// Método asincrónico que devuelve la base de datos. Si aún no se ha
  /// inicializado la base de datos, se llama a la función asincrónica
  /// initDB() para inicializarla.
  Future<Database> get database async {

    if (_database != null ) return _database!;  

    // Si no hay una base de datos, se llama a initDB() para inicializarla
    // y se asigna a _database
    _database = await initDB();

    return _database!;

  }

/// Inicializa y abre una base de datos en el directorio de documentos de la
/// aplicación. Crea una tabla llamada 'scans' con tres columnas: 'id',
/// 'type' y 'value'.
  Future<Database?> initDB() async{ 
    //path de donde almacenaremos bd
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
     // Obtiene el directorio de documentos de la aplicación
    final path = join( documentsDirectory.path, 'ScansDB.db' );
    print(path);

    // Crea y abre la base de datos en la ruta especificada
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

  Future<int> newScanRaw( ScanModel newScan) async {

    final id = newScan.id;
    final type = newScan.type;
    final value = newScan.value;

    //verificar base de datos
    final db = await database;

    final res = await db.rawInsert('''
    INSERT INTO Scans( id, type, value)
    VALUES( $id, '$type', '$value')

''');

  return res; 
  }

  Future<int> newScan( ScanModel newScan) async{

    final db = await database;
    final res = await db.insert('Scans', newScan.toJson());
    print(res);
    return res;

  }

  Future<ScanModel?> getScanById( int id) async {

    final db  = await database;
    final res = await db.query('Scans', where: 'id = ?', whereArgs: [id]);

    return res.isNotEmpty
          ? ScanModel.fromJson(res.first)
          : null;

  }

   Future<List<ScanModel>?> getAllScan( ) async {

    final db  = await database;
    final res = await db.query('Scans');

    return res.isNotEmpty
          ? res.map( (s) => ScanModel.fromJson(s) ).toList()
          : [];

  }

   Future<List<ScanModel>?> getScansByType( String type ) async {

    final db  = await database;
    final res = await db.rawQuery('''
    SELECT * FROM Scans WHERE type = '$type'
''');

    return res.isNotEmpty
          ? res.map( (s) => ScanModel.fromJson(s) ).toList()
          : [];

  }


}