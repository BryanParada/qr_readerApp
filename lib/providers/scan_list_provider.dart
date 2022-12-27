

import 'package:flutter/cupertino.dart';
import 'package:qr_reader/providers/db_provider.dart';

class ScanListProvider extends ChangeNotifier{

  List<ScanModel> scans = [];
  String selectedType = 'http';

  Future<ScanModel> newScan( String value ) async {

    //insercion de base datos
    final newScan = new ScanModel(value: value);
    final id = await DBProvider.db.newScan(newScan);
    // asignar el ID de la b ase de datos al modelo
    newScan.id = id;

    if ( this.selectedType == newScan.type){
      this.scans.add(newScan);
       //notifique a cualquier persona/widget de un cambio que necesita redibujarse
      notifyListeners();
    } 

    return newScan;
   
  }

  loadScans() async{
    final scans = await DBProvider.db.getAllScan();
    this.scans = [...scans];
    notifyListeners();
  }

  loadScansByType( String type) async {
    final scans = await DBProvider.db.getScansByType( type);
    this.scans = [...scans];
    this.selectedType = type;
    notifyListeners();
  }

  deleteAll() async {
    await DBProvider.db.deleteAllScans();
    this.scans = [];
    notifyListeners();
  }

  deleteScanById( int id) async{
    await DBProvider.db.deleteScan(id);
    //loadScansByType(this.selectedType);
    //notifyListeners(); //no es ncesario llamarlo a causa de metodo anterior
  }





}