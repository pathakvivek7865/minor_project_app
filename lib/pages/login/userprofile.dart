import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

import 'package:touristguide/pages/afterloginhome.dart';

class UserProfile extends StatefulWidget{
  final String uname;

  UserProfile({Key key, this.uname}) : super(key: key);

  UserProfileState createState()=>  UserProfileState();
}


class UserProfileState extends State<UserProfile> {
  static String tag = 'home-page';
  var _tst;
  String datas, tid;

   @override
  void initState() {
    super.initState();
    tid = "${widget.uname}";
    print(tid);
    datas = tid;
    _fetchData(tid);
  }

  _fetchData(String tid) async {
    String username = 'vivek';
    String password = 'vivek';
    print(tid);
    String basicAuth =
        'Basic ' + base64Encode(utf8.encode('$username:$password'));
    //print(basicAuth);

    final url = "http://192.168.13.168:8090/tourists/$tid";
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

  @override
  Widget build(BuildContext context) {
    final alucard = Hero(
      tag: 'hero',
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: CircleAvatar(
          radius: 72.0,
          backgroundColor: Colors.transparent,
          backgroundImage: AssetImage('assets/alucard.jpg'),
        ),
      ),
    );

    final welcome = Padding(
      padding: EdgeInsets.all(8.0),
      child:
       Text(_tst == null ?  "Unknown" : _tst['name'] ,
        style: TextStyle(fontSize: 28.0, color: Colors.white),
      ),
    );

    final lorem = Padding(
      padding: EdgeInsets.all(8.0),
      child: Text(/* _tst['address'][0]['country'] != null ? _tst['address'][0]['country'].toString() :  */"Kathmandu",
        style: TextStyle(fontSize: 16.0, color: Colors.white),
      ),
    );

    final homebutton = Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: Material(
        borderRadius: BorderRadius.circular(30.0),
        shadowColor: Colors.lightBlueAccent.shade200,
        elevation: 5.0,
        child: MaterialButton(
          minWidth: 200.0,
          height: 42.0,
          onPressed: () {
            AfterLoginHome();
            var route = new MaterialPageRoute(
              builder: (BuildContext context) =>
                  new AfterLoginHome(pvalue: datas),
            );
            Navigator.of(context).push(route);
          },
          color: Colors.lightBlueAccent,
          child: Text('Home', style: TextStyle(color: Colors.white)),
        ),
      ),
    );

    final body = Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.all(28.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [
          Colors.blue,
          Colors.lightBlueAccent,
        ]),
      ),
      child: Column(
        children: <Widget>[alucard, welcome, lorem, homebutton],
      ),
    );

    return Scaffold(
      body: body,
    );
  }
}
