import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:convert';

import 'package:touristguide/pages/home/model/place_model.dart';
import 'package:touristguide/pages/home/place_detail.dart';

class Place extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Places"),
      ),
      body: new PlaceList(),
    );
  }
}

class PlaceList extends StatefulWidget {
  @override
  createState() => new PlaceListState();
}

class PlaceListState extends State<PlaceList> {
  List<PlaceModel> _place = new List<PlaceModel>();
  final _biggerFont = const TextStyle(fontSize: 18.0);

  @override
  void initState() {
    super.initState();
    _getPlaceList();
  }

  _getPlaceList() async {
    String username = 'vivek';
    String password = 'vivek';
    String basicAuth =
        'Basic ' + base64Encode(utf8.encode('$username:$password'));

    final url = 'http://192.168.1.73:8090/places/';
    final httpClient = new HttpClient();

    try {
      final HttpClientRequest request = await httpClient.getUrl(Uri.parse(url));
      request.headers.set("Authorization", basicAuth);
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

  Widget _buildCart(PlaceModel place) {
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
                new FlatButton(
                  child: const Text('More>>'),
                  onPressed: () {/* ... */},
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
