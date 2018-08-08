import 'package:flutter/material.dart';
import './pages/homepage.dart';
/* import 'dart:convert';
import 'dart:io';

import 'pages/profile.dart';
import './pages/home/home.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:touristguide/pages/home/login/login_page.dart';
import 'package:material_search/material_search.dart';
import 'package:touristguide/pages/home/search/search.dart';
import 'package:http/http.dart' as http; */

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'ITG',
      theme: new ThemeData(
        primarySwatch: Colors.amber,
      ),
      home: new MyHomePage(),
    );
  }
}
