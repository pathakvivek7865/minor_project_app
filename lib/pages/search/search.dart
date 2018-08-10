import 'package:flutter/material.dart';
// import 'package:touristguide/pages/home/search/model.dart';
import 'package:http/http.dart' as http;
// import 'dart:io';
import 'dart:convert';
import 'package:rxdart/rxdart.dart';
import 'package:touristguide/pages/home/model/place.dart';
// import 'package:touristguide/pages/home/place_detail.dart';

class SearchBar extends StatefulWidget {
  @override
  _SearchBarState createState() => new _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  List<Place> places = List();
  bool hasLoaded = true;

  final PublishSubject subject = PublishSubject<String>();

  @override
  void dispose() {
    subject.close();
    super.dispose();
  }

  void searchPlaces(query) {
    resetPlaces();
    if (query.isEmpty) {
      setState(() {
        hasLoaded = true;
      });
    }
    setState(() => hasLoaded = false);
    http
        .get('http://192.168.100.4:8090/places/')
        .then((res) => (res.body))
        .then(json.decode)
        .then((map) => map["places"])
        .then((places) => places.forEach(addPlace))
        .catchError(onError)
        .then((e) {
      setState(() {
        hasLoaded = true;
      });
    });
  }

  void onError(dynamic d){
    setState(() {
          hasLoaded = true;
        });
  }

  void addPlace(item) {
    setState(() {
      places.add(Place.fromJson(item));
    });
    print('${places.map((m) => m.name)}');
  }

  void resetPlaces() {
    setState(() => places.clear());
  }

  // List<Place> _places = new List<Place>();
  // final _biggerFont = const TextStyle(fontSize: 11.0);

  @override
  void initState() {
    super.initState();
    subject.stream.debounce(Duration(milliseconds: 400)).listen(searchPlaces);
  }

/*   _getPlaceList() async {
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
          places = placeResponse.places;
        });
      }
    } catch (exception) {
      print(exception);
      //  print("vivek");

    }
  } */
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      // padding: EdgeInsets.all(1.0),
      child: Column(
        children: <Widget>[
          TextField(
            onChanged: (String string) => (subject.add(string)),
          ),
          hasLoaded ? Container() : CircularProgressIndicator(),
          Expanded(
              child: ListView.builder(
            // padding: EdgeInsets.all(1.0),
            itemCount: places.length,
            itemBuilder: (BuildContext context, int index) {
              return new PlaceView(places[index]);
            },
          ))
        ],
      ),
    ));
  }
}

class PlaceView extends StatefulWidget{
  PlaceView(this.place);
  final Place place;

  @override
  PlaceViewState createState() => PlaceViewState();
}

class PlaceViewState extends State<PlaceView>{
  Place placeState;

  @override
  void initState(){
    super.initState();
    placeState = widget.place;
  }

  @override
  Widget build(BuildContext context){
    return Card(
      child: Container(
        height: 100.0,
        // padding: EdgeInsets.all(1.0),
        child: Row(
          children: <Widget>[
            placeState != null
            ? Hero(child: Stack(
              children: <Widget>[
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    placeState.name,
                    maxLines: 10,
                  ),
                ),/* 
                Align(
                  alignment: Alignment.topLeft,
                  child: IconButton(
                    icon: placeState.favored
                    ? Icon(Icons.star)
                    :Icon(Icons.star_border),
                    color:  Colors.redAccent,
                    onPressed: () {},
                  )
                ) */
              ],
            ),
            tag: placeState.name,
            )
            : Container(),
          ],
        ),
      ),
    );
  }

  }


