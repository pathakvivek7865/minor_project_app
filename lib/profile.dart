import 'package:flutter/material.dart'; 

class Profile extends StatefulWidget{
  @override
  _ProfileState createState() =>  new _ProfileState();
}

class _ProfileState extends State<Profile>{
  @override
  Widget build(BuildContext context) {
      // TODO: implement build
      return new Scaffold(
          appBar: new AppBar(
            title: new Text("Profile"),
          ),
          body: new Center(
            child: new Text("vivek"),
          ),
        );
    }
}