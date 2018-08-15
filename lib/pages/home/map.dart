import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:google_maps_flutter/src/controller.dart';

class MapsDemo extends StatelessWidget {
  MapsDemo(this.mapWidget, this.controller);

  final Widget mapWidget;
  final GoogleMapController controller;

  @override
  Widget build(BuildContext context) {
    GoogleMapController.init();
    final GoogleMapOverlayController controller =
        GoogleMapOverlayController.fromSize(width: 300.0, height: 200.0);
    final Widget mapWidget = GoogleMapOverlay(controller: controller);
    new Scaffold(
      appBar: AppBar(title: const Text('Google Maps demo')),
      body: MapsDemo(mapWidget, controller.mapController),
    );
    navigatorObservers:
    <NavigatorObserver>[controller.overlayController];
    return Padding(
      padding: EdgeInsets.all(15.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Center(child: mapWidget),
          RaisedButton(
            child: const Text('Go to London'),
            onPressed: () {
              controller.animateCamera(CameraUpdate.newCameraPosition(
                const CameraPosition(
                  bearing: 270.0,
                  target: LatLng(51.5160895, -0.1294527),
                  tilt: 30.0,
                  zoom: 17.0,
                ),
              ));
            },
          ),
        ],
      ),
    );
  }
}

/* import 'package:flutter/material.dart';
import 'dart:async';

import 'package:geolocation/geolocation.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class PlaceMap extends StatefulWidget{
  
  @override
  _PlaceMapState createState() =>  new _PlaceMapState();
}




class _PlaceMapState extends State<PlaceMap>{

   PlaceMap(this.mapWidget, this.controller);

  final Widget mapWidget;
  final GoogleMapController controller;

  

   LocationResult locations ;
  StreamSubscription<LocationResult> streamSubscription;
  bool trackLocation = false;

  @override
  initState() {
    super.initState();
    checkGps();

    trackLocation = false;
    locations = null;

    getLocations();
  }

  checkGps() async {
    final GeolocationResult result = await Geolocation.isLocationOperational();
    if (result.isSuccessful) {
      print("Success");
    } else {
      print("Failed");
    }
  }

  getLocations() {
    if (trackLocation) {
      setState(() => trackLocation = false);
      streamSubscription.cancel();
      streamSubscription = null;
      locations = null;
    } else {
      setState(() => trackLocation = true);

      streamSubscription = Geolocation
          .locationUpdates(
        accuracy: LocationAccuracy.best,
        displacementFilter: 0.0,
        inBackground: false,
      )
          .listen((result) {
        final location = result;
        setState(() {
          locations = location;
        });
      });

      streamSubscription.onDone(() => setState(() {
            trackLocation = false;
          }));
    }
  }



  @override
  Widget build(BuildContext context) {
  //    GoogleMapController.init();
  // final GoogleMapOverlayController controller =
  //     GoogleMapOverlayController.fromSize(width: 300.0, height: 200.0);
  // final Widget mapWidget = GoogleMapOverlay(controller: controller);
  // navigatorObservers: <NavigatorObserver>[controller.overlayController];
    return new Scaffold(
      appBar: new AppBar(
        title: Text("Your Location"),
      ),
      body: new Center(
          child: Container(
        child: ListView(
          children: [
            Image.network(locations == null
                ? ""
                : "https://maps.googleapis.com/maps/api/staticmap?center=${locations.location.latitude},${locations.location.longitude}&zoom=12&size=400x400&key=AIzaSyD1sYXbxLychb3_80-cXn7r-t2XsbgzbF0")
          ],
        ),
      )),
    );
  }

  
}

 */
