import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:qr_reader/models/scan_model.dart'; 

class MapPage extends StatefulWidget {
 
  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {

  Completer<GoogleMapController> _controller = Completer<GoogleMapController>();
  MapType mapType = MapType.normal;

  @override
  Widget build(BuildContext context) {

    final ScanModel scan = ModalRoute.of(context)!.settings.arguments as ScanModel;

      final CameraPosition initialPoint = CameraPosition(
      target: scan.getLatLng(),
      zoom: 14.4746,
      tilt: 50
    );

    // Marcadores
    Set<Marker> markers = new Set<Marker>();
    markers.add(new Marker(
      markerId: MarkerId('geo-location'),
      position: scan.getLatLng(),
    ));


    return Scaffold(
      appBar: AppBar(
        title: Text('Map'),
        actions: [
          IconButton(
            icon: Icon(Icons.location_disabled),
            onPressed: () async{
              final GoogleMapController controller = await _controller.future;
              controller.animateCamera(CameraUpdate.newCameraPosition(
                CameraPosition(
                  target: scan.getLatLng(),
                  zoom: 14.4746,
                  tilt: 50
                  )
              ));
            },
            
            )
        ],
      ),
      body: GoogleMap(
        mapType: mapType,
        markers: markers,
        initialCameraPosition: initialPoint,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
      floatingActionButton: FloatingActionButton( 
        
        child: Icon( Icons.layers),
        onPressed: (){

          if (mapType == MapType.normal){
            mapType = MapType.satellite;
          } else{
            mapType = MapType.normal;
          }

          setState(() {
            
          });

        
        },
      ), 
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
    );
  }
}