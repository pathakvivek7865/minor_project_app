import 'package:flutter/material.dart';
// import 'package:meta/meta.dart';
import 'dart:convert';
import 'dart:io';
import 'package:touristguide/pages/home/login/login_page.dart';
// import 'package:touristguide/pages/home/login/home_page.dart';

/* import 'pages/profile.dart';
import './pages/home/home.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:touristguide/pages/login.dart';
import 'package:material_search/material_search.dart';
import 'package:touristguide/pages/home/search/search.dart'; */
import 'package:http/http.dart' as http;
class Profile extends StatefulWidget{
  @override
  _ProfileState createState() =>  new _ProfileState();
}

class _ProfileState extends State<Profile>{
  var _tst;

    @override
  void initState() {
    super.initState();
    _fetchData();
  }

  _fetchData() async {
    String username = 'beingbivek@gmail.com';
    String password = 'bivek';
    String basicAuth =
        'Basic ' + base64Encode(utf8.encode('$username:$password'));
    //print(basicAuth);

    final url = "http://192.168.100.4:8090/tourists/1";
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
        print(_tst);
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
  final routes = <String, WidgetBuilder>{
    LoginPage.tag: (context) => LoginPage(),
    // HomePage.tag: (context) => HomePage(),
  };

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kodeversitas',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.lightBlue,
        fontFamily: 'Nunito',
      ),
      home: LoginPage(),
      routes: routes,
    );
  }
}

