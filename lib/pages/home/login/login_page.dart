import 'dart:async';

import 'package:flutter/material.dart';
import 'package:touristguide/pages/home/login/home_page.dart';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

class LoginPage extends StatefulWidget {
  static String tag = 'login-page';
  @override
  _LoginPageState createState() => new _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var _unctrl = new TextEditingController();
  var _tst;
  var _username;
  int tid = 1;
  var _password;
  var _loginStatus;
  int count;

  @override
  void initState() {
    super.initState();
  }

  Future<Null> _fetchData(String id) async {
    setState(() {
      _tst = null;
      _loginStatus = null;
    });

    String username = _username;
    String password = _password;
    String basicAuth =
        'Basic ' + base64Encode(utf8.encode('$username:$password'));
    //print(basicAuth);

    final url = "http://192.168.100.4:8090/tourists/$id";
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

      //print(map["List"]);

    } catch (exception) {
      setState(() {
        this._loginStatus = "Failed parsing response because of: $exception";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final logo = Hero(
      tag: 'hero',
      child: CircleAvatar(
        backgroundColor: Colors.transparent,
        radius: 48.0,
        child: Image.asset('assets/logo.png'),
      ),
    );

    final email = new TextField(
      keyboardType: TextInputType.emailAddress,
      autofocus: false,
      decoration: InputDecoration(
        hintText: 'Email',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      ),
      onChanged: (String string) {
        _username = string;
      },
      controller: _unctrl,
    );

    final password = new TextField(
      keyboardType: TextInputType.emailAddress,
      autofocus: false,
      decoration: InputDecoration(
        hintText: 'Password',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      ),
      onChanged: (String string) {
        _password = string;
      },
    );

    final loginButton = Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: Material(
        borderRadius: BorderRadius.circular(30.0),
        shadowColor: Colors.lightBlueAccent.shade100,
        elevation: 5.0,
        child: MaterialButton(
          minWidth: 200.0,
          height: 42.0,
          onPressed: () {
           /*  _fetchData();
            new Container(
              child: new Text(_tst['name']),
            ); */

            /* for (var i = 0; i < _tst.length; i++) {
              _fetchData('i');
              if (_username == _tst['name']) {
                tid = _tst['id'];
                break;
              }        
          } */
          String i = "17";
            while (true) {
              _fetchData(i);
              if ($username == _tst['name']) {
                tid = _tst['id'];
                break;
              } else {
                tid = tid + 1;
                i = tid.toString();
              }
            }
            var route = new MaterialPageRoute(
              builder: (BuildContext context) =>
                  new UserProfile(uname: _unctrl.text),
            );
            Navigator.of(context).push(route);
          },
          color: Colors.lightBlueAccent,
          child: Text('Log In', style: TextStyle(color: Colors.white)),
        ),
      ),
    );

    final forgotLabel = FlatButton(
      child: Text(
        'Forgot password?',
        style: TextStyle(color: Colors.black54),
      ),
      onPressed: () {
        new Container(
          child: Column(
            children: <Widget>[
              new Text(
                _loginStatus != null ? _loginStatus : "",
                style: new TextStyle(fontSize: 20.0, color: Colors.blueAccent),
              )
            ],
          ),
        );
      },
    );

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: ListView(
          shrinkWrap: true,
          padding: EdgeInsets.only(left: 24.0, right: 24.0),
          children: <Widget>[
            logo,
            SizedBox(height: 48.0),
            email,
            SizedBox(height: 8.0),
            password,
            SizedBox(height: 24.0),
            loginButton,
            forgotLabel
          ],
        ),
      ),
    );
  }
}
