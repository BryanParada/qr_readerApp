import 'package:flutter/material.dart';
import 'package:qr_reader/providers/db_provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';
 
 
void launchURL(BuildContext context ,ScanModel scan) async {
  final url=scan.value;
 
  if(scan.type=='http'){
    //Abrir Sitio
    final Uri _url = Uri.parse(scan.value);
    if (!await launchUrl(_url )) throw 'Could not launch $url'; //_url,mode: LaunchMode.externalApplication
    print('HTTP!!!!!');
  }else{
   Navigator.pushNamed(context, 'map', arguments: scan);
  }
 
}