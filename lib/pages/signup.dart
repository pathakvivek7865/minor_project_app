import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:touristguide/pages/login/userprofile.dart';

class Signup extends StatefulWidget {
  @override
  _SignupState createState() => new _SignupState();
}

class _SignupState extends State<Signup> {
  var _email, _password, _name, _lastName;

  Future _login() async {
    var url = "http://192.168.100.4:8090/signup";
    Map<dynamic, dynamic> data = {
      "email": "$_email",
      "password": "$_password",
      "name": "$_name",
      "lastName": "$_lastName"
    };
    try{
      http.Response res = await http.post(url, body: jsonEncode(data), headers: {
      HttpHeaders.CONTENT_TYPE: 'application/json'
    });

    if(res.statusCode == 200){
      var route = new MaterialPageRoute(
                builder: (BuildContext context) => new UserProfile(uname: _email),
              );
              Navigator.of(context).push(route);
    }

    }catch(exception){

    }

    
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        // key: key,
        appBar: new AppBar(
          title: new Text("Signup"),
        ),
        body: new Center(
            child: new ListView(
          children: <Widget>[
            new Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                new Container(
                  child: new TextField(
                    decoration: new InputDecoration(hintText: "First Name"),
                    onChanged: (String string) {
                      _name = string;
                    },
                  ),
                  margin: const EdgeInsets.all(40.0),
                ),
                new Container(
                  child: new TextField(
                    decoration: new InputDecoration(hintText: "Last Name"),
                    onChanged: (String string) {
                      _lastName = string;
                    },
                  ),
                  margin: const EdgeInsets.all(40.0),
                ),
                new Container(
                  child: new TextField(
                    decoration: new InputDecoration(hintText: "Email"),
                    onChanged: (String string) {
                      _email = string;
                    },
                  ),
                  margin: const EdgeInsets.all(40.0),
                ),
                new Container(
                  child: new TextField(
                    decoration: new InputDecoration(hintText: "Password"),
                    onChanged: (String string) {
                      _password = string;
                    },
                  ),
                  margin: const EdgeInsets.all(40.0),
                ),
                new RaisedButton(
                  child: new Text("Signup"),
                  onPressed: _login,
                ),
              ],
            ),
          ],
        )));
  }
}