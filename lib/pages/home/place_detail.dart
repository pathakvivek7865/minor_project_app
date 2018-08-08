import 'package:flutter/material.dart';

import 'package:touristguide/pages/home/model/place_model.dart';
//import 'package:touristguide/pages/home/map.dart';

class PlaceDetail extends StatelessWidget {
  final PlaceModel _place;

  PlaceDetail(this._place);

  @override
  Widget build(BuildContext context) {
    return new PlaceDetailBody(_place);
  }
}

class PlaceDetailBody extends StatefulWidget {
  final PlaceModel _place;
  PlaceDetailBody(this._place);

  @override
  _PlaceDetailBodyState createState() => new _PlaceDetailBodyState(_place);
}

class _PlaceDetailBodyState extends State<PlaceDetailBody> {
  PlaceModel _place;
  _PlaceDetailBodyState(this._place);

  ScrollController _scrollViewController;

  @override
  void initState() {
    super.initState();
    _scrollViewController = ScrollController(initialScrollOffset: 0.0);
  }

  @override
  void dispose() {
    super.dispose();
    _scrollViewController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final alucard = Hero(
      tag: 'hero',
      child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Image.network(_place.preferedActivities)),
    );

    final welcome = Padding(
      padding: EdgeInsets.all(8.0),
      child: Text(
        _place.name /* ${widget.uname} */,
        style: TextStyle(fontSize: 28.0, color: Colors.white),
      ),
    );

    final lorem = Padding(
      padding: EdgeInsets.all(8.0),
      child: Text(
        _place.description,
        style: TextStyle(fontSize: 16.0, color: Colors.white),
      ),
    );

    final midbtn = Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: Material(
        borderRadius: BorderRadius.circular(30.0),
        shadowColor: Colors.lightBlueAccent.shade100,
        elevation: 5.0,
        child: MaterialButton(
          minWidth: 200.0,
          height: 42.0,
        onPressed: (){}/*() {
          var route = new MaterialPageRoute(
              builder: (BuildContext context) =>
                  new PlaceMap(),
            );
            Navigator.of(context).push(route);
        }*/,
          color: Colors.lightBlueAccent,
          child: Text('Map', style: TextStyle(color: Colors.white)),
        ),
      ),
    );

    final body = Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.all(28.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [
          Colors.blue,
          Colors.lightBlueAccent,
        ]),
      ),
      child: Column(
        children: <Widget>[
          alucard,
          welcome,
          midbtn,
          lorem,
        ],
      ),
    );

    return Scaffold(
      body: body,
    );
  }
}
