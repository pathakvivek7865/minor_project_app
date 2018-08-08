import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:convert';

import 'package:touristguide/pages/home/model/place.dart';
import 'package:touristguide/pages/home/place_detail.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new PlaceCardView(),
    );
  }
}

class PlaceCardView extends StatefulWidget {
  @override
  createState() => new PeopleCardViewState();
}

class PeopleCardViewState extends State<PlaceCardView> {
  List<Place> _place = new List<Place>();
  final _biggerFont = const TextStyle(fontSize: 18.0);

  @override
  void initState() {
    super.initState();
    _getPlaceList();
  }

  _getPlaceList() async {
    final url = 'http://192.168.100.4:8090/places/';
    final httpClient = new HttpClient();

    try {
      final HttpClientRequest request = await httpClient.getUrl(Uri.parse(url));
      final HttpClientResponse response = await request.close();
      if (response.statusCode == HttpStatus.OK) {
        final String json = await response.transform(utf8.decoder).join();
        PlaceResponse placeResponse =
            new PlaceResponse.fromJson(jsonDecode(json));

        setState(() {
          _place = placeResponse.places;
        });
      }
    } catch (exception) {
      print(exception);
      //  print("vivek");

    }
  }

  Widget _buildPlaceList() {
    return new ListView.builder(
      // padding: const EdgeInsets.all(5.0),
      itemCount: _place.length != null ? _place.length : 0,
      itemBuilder: (context, index) {
        return new FlatButton(
          padding: const EdgeInsets.all(0.0),
          child: _buildCart(_place[index]),
          onPressed: () {
            Navigator.push(
                context,
                new MaterialPageRoute(
                    builder: (context) => new PlaceDetail(_place[index])));
          },
        );
      },
    );
  }


  /*Widget _buildCard(Place place) {
    return new ListTile(
      title: new Text(place.name, style: _biggerFont),
      subtitle: new Text(place.address),
    );
  }*/

  Widget _buildCart(Place place) {
    return new Card(
      child: new Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ListTile(
            leading: const Icon(Icons.home),
            title: Text(
              place.name,
              style: _biggerFont,
            ),
            subtitle: Text(place.address),
          ),

          //new Divider(),
          new Container(
            padding: const EdgeInsets.all(0.0),
            child: new Image.network(place.preferedActivities),
          ),
          new ButtonTheme.bar(
            // make buttons use the appropriate styles for cards
            child: new ButtonBar(
              
              children: <Widget>[
                FlatButton(
                  child: Text("More"),
                  onPressed: (){}
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _buildPlaceList();
  }
}
