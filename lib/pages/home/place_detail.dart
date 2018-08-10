import 'package:flutter/material.dart';

import 'package:touristguide/pages/home/model/place.dart';
import 'package:touristguide/component/getImage.dart';
import 'dart:async';

import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

//import 'package:touristguide/pages/home/map.dart';

class PlaceDetail extends StatelessWidget {
  final Place _place;

  PlaceDetail(this._place);

  @override
  Widget build(BuildContext context) {
    return new PlaceDetailBody(_place);
  }
}

class PlaceDetailBody extends StatefulWidget {
  final Place _place;
  PlaceDetailBody(this._place);

  @override
  _PlaceDetailBodyState createState() => new _PlaceDetailBodyState(_place);
}

class _PlaceDetailBodyState extends State<PlaceDetailBody> {
  Place _place;
  int _rating;
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

  Future rate(int rating) async {
    var url = "http://localhost:8090/rating";
    Map<String, dynamic> data = {
      "userId": 3,
      "placeId": _place,
      "rating": rating
    };  
    try {
      http.Response res = await http.post(url,
          body: jsonEncode(data),
          headers: {HttpHeaders.CONTENT_TYPE: 'application/json'});
          print(jsonEncode(data));

      if (res.statusCode == 200) {
        print("rated successfully");
      }
    } catch (exception) {}
  }

  @override
  Widget build(BuildContext context) {
    final alucard = Hero(
      tag: 'hero',
      child: Padding(
          padding: EdgeInsets.all(16.0),
          child: getImage(_place.featuredImage)),
    );

    final welcome = Padding(
      padding: EdgeInsets.all(8.0),
      child: Text(
        _place.name /* ${widget.uname} */,
        style: TextStyle(fontSize: 28.0, color: Colors.white),
      ),
    );

    final lorem = Expanded(
          child: Padding(
        padding: EdgeInsets.all(8.0),
        child: Text(
          _place.description,
          style: TextStyle(fontSize: 16.0, color: Colors.white),
        ),
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
         new Row(
           children: <Widget>[
             new Padding(padding: EdgeInsets.fromLTRB(60.0, 0.0, 0.0, 0.0)),
             new IconButton(icon: Icon(Icons.star), onPressed: (){setState(() {
                            _rating = 1;
                            rate(_rating);
                          });
                          
                          
                          }),
             new IconButton(icon: Icon(Icons.star), onPressed: (){setState(() {
                            _rating = 2;
                          });
                          rate(_rating);
                          }),
             new IconButton(icon: Icon(Icons.star), onPressed: (){setState(() {
                            _rating = 3;
                          });
                          rate(_rating);}),
             new IconButton(icon: Icon(Icons.star), onPressed: (){setState(() {
                            _rating = 4;
                          });
                          rate(_rating);}),
             new IconButton(icon: Icon(Icons.star), onPressed: (){setState(() {
                            _rating = 5;
                          });
                          rate(_rating);})
           ],
           
         ),
         new Text(_rating != null ? _rating.toString() : ""),
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
