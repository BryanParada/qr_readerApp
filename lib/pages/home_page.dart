import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_reader/pages/directions_page.dart';
import 'package:qr_reader/pages/maps_page.dart';
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
            onPressed: () {},
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

    switch( currentIndex ){

      case 0:
        return MapsPage();
      
      case 1:
        return DirectionsPage();
        
      default:
        return MapsPage();
    }


  }
}