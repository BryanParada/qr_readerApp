import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_reader/pages/directions_page.dart';
import 'package:qr_reader/pages/maps_page.dart';
import 'package:qr_reader/providers/db_provider.dart';
import 'package:qr_reader/providers/scan_list_provider.dart';
import 'package:qr_reader/providers/ui_provider.dart';
import 'package:qr_reader/widgets/custom_navigatorbar.dart';
import 'package:qr_reader/widgets/scan_button.dart';

class HomePage extends StatelessWidget {
   
  const HomePage({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('History'),
        actions: [
          IconButton(
            onPressed: () {
             
              Provider.of<ScanListProvider>(context, listen: false).deleteAll();



            },
            icon: Icon(Icons.delete_forever)
             )
        ]
      ),
      body: _HomePageBody(),

      bottomNavigationBar: CustomNavigationBar(),
      floatingActionButton: ScanButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}


class _HomePageBody extends StatelessWidget { 

  @override
  Widget build(BuildContext context) {

    //obtener el seleceted menu opt
    final uiProvider = Provider.of<UiProvider>(context);

    //cambiar pagina respectiva
    final currentIndex = uiProvider.selectedMenuOpt;

    //TODO: temporal leer la base de datos
    //final tempScan = new ScanModel( value: 'http://google.com');
    //GRABA
    //DBProvider.db.newScan(tempScan); 
    //LEE
    //DBProvider.db.getScanById(1).then((scan) => print(scan!.value));
    //DBProvider.db.getAllScan().then(print);
    //DBProvider.db.deleteAllScans().then(print);

    //Usar el ScanListProvider
    final scanListProvider = Provider.of<ScanListProvider>(context, listen: false); //que no seredibuje

    switch( currentIndex ){

      case 0:
        scanListProvider.loadScansByType('geo');
        return MapsPage();
      
      case 1:
      scanListProvider.loadScansByType('http');
        return DirectionsPage();
        
      default:
        return MapsPage();
    }


  }
}