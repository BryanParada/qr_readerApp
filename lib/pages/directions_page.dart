import 'package:flutter/material.dart'; 
import 'package:provider/provider.dart';
import 'package:qr_reader/providers/scan_list_provider.dart';

class DirectionsPage extends StatelessWidget {
  const DirectionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    
    final scanListProvider = Provider.of<ScanListProvider>(context);//no se coloca listen:false, necesitamos que si se redibuje
    final scans = scanListProvider.scans;
    
    return ListView.builder(
      itemCount: scans.length,
      itemBuilder:( _ , i) => Dismissible(
        key: UniqueKey(),
        direction: DismissDirection.endToStart, // swipe solo hacia la derecha 
        background: Container(
          color: Colors.red 
        ),
        onDismissed: (DismissDirection direction){
          Provider.of<ScanListProvider>(context, listen: false).deleteScanById(scans[i].id!);
        },
        secondaryBackground: Container(
        child: Icon(Icons.delete, color: Colors.white),
        alignment: Alignment.centerRight,
        padding: EdgeInsets.only(right: 20),
        color: Colors.red,
       ),
        child: ListTile(
          leading: Icon(Icons.home_outlined, color: Theme.of(context).primaryColor),
          title: Text(scans[i].value),
          subtitle: Text( scans[i].id.toString()),
          trailing: Icon(Icons.keyboard_arrow_right, color: Colors.grey),
          onTap: () => print(scans[i].id),
          
        ),
      ),
      );


  }
}