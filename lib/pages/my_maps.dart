import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
 class MyMap extends StatefulWidget {
  MyMapState createState() => MyMapState();
}

class MyMapState extends State<MyMap> {
  final GoogleMapOverlayController controller =
      GoogleMapOverlayController.fromSize(width: 375.0, height: 525.0);
  Widget mapWidget;

  @override
  void initState() {
    
    super.initState();
    mapWidget = GoogleMapOverlay(controller: controller);
  }

  @override
    void dispose() {
      controller.dispose();
      super.dispose();
    }


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: new Scaffold(
        body: MapsDemo(mapWidget, controller.mapController),
      ),
      navigatorObservers: <NavigatorObserver>[controller.overlayController],
    );
  }
} 

class MapsDemo extends StatelessWidget {
  
  MapsDemo(this.mapWidget, this.controller);

  final Widget mapWidget;
  final GoogleMapController controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(15.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Center(child: mapWidget),
          RaisedButton(
            child: const Text('View'),
            onPressed: () {
              controller.animateCamera(CameraUpdate.newCameraPosition(
                const CameraPosition(
                  bearing: 270.0,
                  target: LatLng(27.7106, 85.3486),
                  tilt: 30.0,
                  zoom: 18.0,
                ),
              ));
            },
          ),
        ],
      ),
    );
  }
}