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
    return Scaffold(
      body: NestedScrollView(
        controller: _scrollViewController,
        headerSliverBuilder: (BuildContext context, bool boxIsScrolled) {
          return <Widget>[
            SliverAppBar(
             // title: Text(_place.name),
              pinned: false,
              floating: true,
              forceElevated: boxIsScrolled, 
              expandedHeight: 300.0,

              

              flexibleSpace:  FlexibleSpaceBar(
              title:  Text(_place.name),
              centerTitle: true,
              background: Image.network(_place.preferedActivities),
              
              ), 
            ),
            
          ];
        },
        body: new Container(
          child: Column(
            children:<Widget>[
              //  Container(
              //    padding: const EdgeInsets.fromLTRB(0.0, 1.0, 0.0, 0.0),
              //    child: new Image.network(_place.preferedActivities)
              // ),
               new Text(_place.description),
          ],),
        ),
      ),
    );

    
  }
}
