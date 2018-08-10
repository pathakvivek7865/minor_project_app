import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:touristguide/component/getImage.dart';
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
    try {
      http.Response res = await http.post(url,
          body: jsonEncode(data),
          headers: {HttpHeaders.CONTENT_TYPE: 'application/json'});

      if (res.statusCode == 200) {
        var route = new MaterialPageRoute(
          builder: (BuildContext context) => new UserProfile(uname: _email),
        );
        Navigator.of(context).push(route);
      }
    } catch (exception) {}
  }

  @override
  Widget build(BuildContext context) {
    final logo = Hero(
      tag: 'hero',
      child: CircleAvatar(
          backgroundColor: Colors.transparent,
          radius: 40.0,
          child: new Column(
            children: <Widget>[
              getImage('assets/logo.png'),
              new Text('Sign Up'),
            ],
          )),
    );

    final name = new TextField(
      keyboardType: TextInputType.emailAddress,
      autofocus: true,
      decoration: InputDecoration(
        hintText: 'First Name',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      ),
      onChanged: (String string) {
        _name = string;
      },
    );
    final lastname = new TextField(
      keyboardType: TextInputType.emailAddress,
      autofocus: true,
      decoration: InputDecoration(
        hintText: 'Last Name',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      ),

    );
    final email = new TextField(
      keyboardType: TextInputType.emailAddress,
      autofocus: true,
      decoration: InputDecoration(
        hintText: 'Email',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      ),
      onChanged: (String string) {
        _email = string;
      },
    );

    final password = new TextField(
      obscureText: true,
      keyboardType: TextInputType.emailAddress,
      autofocus: true,
      decoration: InputDecoration(
        hintText: 'Password',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      ),
      onChanged: (String string) {
        _password = string;
      },
    );

    final signupButton = Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: Material(
        borderRadius: BorderRadius.circular(30.0),
        shadowColor: Colors.lightBlueAccent.shade100,
        elevation: 5.0,
        child: MaterialButton(
          minWidth: 200.0,
          height: 42.0,
          onPressed: _login,
          color: Colors.blueAccent,
          child: Text('Sign up', style: TextStyle(color: Colors.white)),
        ),
      ),
    );

    return Scaffold(
      backgroundColor: Colors.lightBlue[50],
      body: Center(
        child: ListView(
          shrinkWrap: true,
          padding: EdgeInsets.only(left: 24.0, right: 24.0),
          children: <Widget>[
            logo,
            SizedBox(height: 48.0),
            name,
            SizedBox(height: 8.0),
            lastname,
            SizedBox(height: 8.0),
            email,
            SizedBox(height: 8.0),
            password,
            SizedBox(height: 24.0),
            signupButton,
          ],
        ),
      ),
    );
  }
}