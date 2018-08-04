import 'dart:async';

import 'package:flutter/material.dart';
//import 'package:flutter/services.dart';

import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

class Test extends StatefulWidget {
  // Test({Key key, this.title}) : super(key: key);
  //final String title;

  @override
  _TestState createState() => new _TestState();
}

class _TestState extends State<Test> {
  var _tst;
  var _username;
  var _password;
  var _loginStatus = null;

  @override
  void initState() {
    super.initState();
  }

  Future<Null> _fetchData() async {
    setState(() {
      _tst = null;
    });

    String username = _username;
    String password = _password;
    String basicAuth =
        'Basic ' + base64Encode(utf8.encode('$username:$password'));
    //print(basicAuth);

    final url = "http://10.0.2.2:8090/tourists/1";
    try {
      final response = await http.get(url, headers: {
        HttpHeaders.AUTHORIZATION: basicAuth,
        HttpHeaders.CONTENT_TYPE: 'application/json'
      });

      if (response.statusCode == 200) {
        final responseJson = json.decode(response.body);
        //final user = responseJson['id'];

        setState(() {
          this._tst = responseJson;
          if (_loginStatus != null) {
            this._loginStatus = "Successifully Logged In";
          }
        });
        //print(_tst);
        print(responseJson);
      } else {
        print(response.body);
        setState(() {
          if (_loginStatus != null) {
            this._loginStatus =
                'Error getting response:\nHttp status ${response.body}';
          }
        });
      }

      //print(map["List"]);

    } catch (exception) {
      setState(() {
        this._loginStatus = "Failed parsing response because of: $exception";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // final key = new GlobalKey<ScaffoldState>();

    return new Scaffold(
        // key: key,
        appBar: new AppBar(
          title: new Text("Login Test"),
        ),
        body: new Center(
            child: new ListView(
          children: <Widget>[
            new Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                new Container(
                  child: new TextField(
                    decoration: new InputDecoration(hintText: "Email"),
                    onChanged: (String string) {
                      _username = string;
                    },
                  ),
                  margin: const EdgeInsets.all(40.0),
                ),
                new Container(
                  child: new TextField(
                    decoration: new InputDecoration(hintText: "password"),
                    onChanged: (String string) {
                      _password = string;
                    },
                  ),
                  margin: const EdgeInsets.all(40.0),
                ),
                new RaisedButton(
                  child: new Text("LOGIN"),
                  onPressed: _fetchData,
                ),
                new Container(
                  padding: const EdgeInsets.all(20.0),
                  child: new Column(
                    children: <Widget>[
                      new Text(_tst != null ? _tst['id'].toString() : ""),
                      new Text(_tst != null ? _tst['name'] : ""),
                      new Text(_tst != null ? _tst['status'].toString() : ""),
                      new Text(
                        _loginStatus != null ? _loginStatus : "Offline",
                        style: new TextStyle(
                            fontSize: 20.0, color: Colors.blueAccent),
                      ),
                      // new Text( _tst['address'].length()  <0 ? "" : _tst['address'][0]['country'].toString()),
                    ],
                  ),
                ),
              ],
            ),
          ],
        )));
  }
}
