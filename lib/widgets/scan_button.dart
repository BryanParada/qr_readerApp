import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:provider/provider.dart';
import 'package:qr_reader/providers/scan_list_provider.dart';
import 'package:qr_reader/utils/utils.dart';

class ScanButton extends StatelessWidget {
  const ScanButton({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      elevation: 0,
      child: Icon(Icons.filter_center_focus),
      onPressed: () async{


        //String barcodeScanRes = await FlutterBarcodeScanner.scanBarcode('#3D8BEF', 'Cancel', false, ScanMode.QR);
        //final barcodeScanRes = 'https://www.google.com/?hl=es';


        final barcodeScanRes = 'geo:-19.4299734299625,134.21583219503626';
        
        if ( barcodeScanRes == '-1'){
          return;
        }

        //print(barcodeScanRes);
        final scanListProvider = Provider.of<ScanListProvider>(context, listen: false);
        final newScan = await scanListProvider.newScan(barcodeScanRes); 

        launchURL(context, newScan);

      },
      );
  }
}