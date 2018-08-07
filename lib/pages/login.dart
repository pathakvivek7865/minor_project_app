import 'dart:async';

import 'package:flutter/material.dart';
//import 'package:flutter/services.dart';

import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  // Test({Key key, this.title}) : super(key: key);
  //final String title;

  @override
  _LoginState createState() => new _LoginState();
}

class _LoginState extends State<Login> {
  var _tst;
  var _username;
  var _password;
  var _loginStatus;

  Future<Null> _fetchData() async {
    setState(() {
      _tst = null;
    });

    String username = _username;
    String password = _password;
    String basicAuth =
        'Basic ' + base64Encode(utf8.encode('$username:$password'));
    //print(basicAuth);

    final url = 'http://192.168.1.73:8090/login/';
    //final url = "http://10.2.0.0:8090/login";
    try {
      final response = await http.get(url, headers: {
        HttpHeaders.AUTHORIZATION: basicAuth,
        HttpHeaders.CONTENT_TYPE: 'application/json'
      });

      if (response.statusCode == 200) {
        final responseJson = json.decode(response.body);
        //final user = responseJson['id'];
        _saveUsername(_username);

        setState(() {
          this._tst = responseJson;

          this._loginStatus = "Successfully Logged In";
        });
        //print(_tst);
        print(responseJson);
      } else {
        print(response.body);
        setState(() {
          this._loginStatus =
              'Error getting response:\nHttp status ${response.body}';
        });
      }
    } catch (exception) {
      setState(() {
        this._loginStatus = "Failed parsing response because of: $exception";
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _getUsername();
  }

  Future<bool> _saveUsername(String uname) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.setString('username', uname);
    return true;
  }

  Future<String> _getUsername() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String uname = prefs.getString("username");
    return uname;
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
                      new Text(_tst != null ? _tst.toString() : ""),
                      new Text(
                        _loginStatus != null ? _loginStatus : "Offline",
                        style: new TextStyle(
                            fontSize: 20.0, color: Colors.blueAccent),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        )));
  }
}
