import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

class Test extends StatefulWidget {
  @override
  _TestState createState() => new _TestState();
  getMyF(){
    _TestState test = _TestState();
   test._fetchData();
    return test._tst['name'];
  }
}

class _TestState extends State<Test> {
  var _tst;

  _fetchData() async {
    String username = 'beingbivek@gmail.com';
    String password = 'bivek';
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
        });
        //print(_tst);
        //print(responseJson);
      } else {
        // _tst = 'Error getting response:\nHttp status ${response.statusCode}';
      }

      //print(map["List"]);

    } catch (exception) {
      setState(() {
        // this._tst = "Failed parsing response because of: $exception";
      });
    }
  }


  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Login Test"),
      ),
      body: Column(children: <Widget>[
        new Container(
          child: new Column(
            children: <Widget>[
              new Text(_tst['id'].toString()),
              new Text(_tst['name']),
              new Text(_tst['status'].toString()),
              new Text(_tst['address'][0]['country'].toString()),

            ],
          ),
        )
      ]),
    );
  }
}