/* import 'package:flutter/material.dart';
import 'dart:async';

import 'package:geolocation/geolocation.dart';

class PlaceMap extends StatefulWidget{
  @override
  _PlaceMapState createState() =>  new _PlaceMapState();
}

class _PlaceMapState extends State<PlaceMap>{

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