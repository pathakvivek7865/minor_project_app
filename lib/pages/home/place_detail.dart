import 'package:flutter/material.dart';

import 'package:touristguide/pages/home/model/place.dart';

class PlaceDetail extends StatelessWidget{
  final Place _place;

  PlaceDetail(this._place);


  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      theme: new ThemeData(
        primarySwatch: Colors.blue,
        accentColor: const Color(0xFFF850DD),
      ),
      home: new Scaffold(
        appBar: new AppBar(
          title: new Text("place Details"),
        ),
        body: new Text(_place.name),
      ),
    );
  }
}

