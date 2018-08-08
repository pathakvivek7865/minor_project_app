import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:io';

import './home/home.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:touristguide/pages/homepage.dart';
import './login/userprofile.dart';
import 'package:touristguide/pages/search/search.dart';
import 'package:http/http.dart' as http;

class AfterLoginHome extends StatefulWidget {
  final String pvalue;

  AfterLoginHome({Key key, this.pvalue}) : super(key: key);

  @override
  _AfterLoginHomeState createState() => new _AfterLoginHomeState();
}

class _AfterLoginHomeState extends State<AfterLoginHome> {
  var _tst;
  String tid;

  int _currentIndex = 0;
  // final List<Widget> _children = [ PlaceholderWidget(Colors.orangeAccent), PlaceholderWidget(Colors.blueAccent)];
  final List<Widget> _children = [
    new Home(),
    new SearchBar() /* PlaceholderWidget(Colors.blueAccent) */
  ];

  @override
  void initState() {
    super.initState();
    tid = "${widget.pvalue}";
/*     String pbool = duser[0];
    String tid = "";
    if (pbool == "1") {
    tid = "";
    int j = duser.length;
    for (int i = 1; i < j; i++) {
    tid = tid + duser[i];
    }      
    }
    else{
    tid = '1';
    } */
    _fetchData(tid);
  }


    _neverSatisfied() async {
    return showDialog<Null>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return new AlertDialog(
        title: new Text('Are You Sure?'),
        actions: <Widget>[
          new FlatButton(
            child: new Text('Logout'),
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (BuildContext context) => MyHomePage()
              ));
            },
          ),
          new FlatButton(
            child: new Text('Cancel'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
    }

  _fetchData(String tid) async {
    String username = 'vivek';
    String password = 'vivek';
    String basicAuth =
        'Basic ' + base64Encode(utf8.encode('$username:$password'));
    //print(basicAuth);

    final url = "http://192.168.1.73:8090/tourists/$tid";
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
    return new Scaffold(
      drawer: new Drawer(
        child: new ListView(
          children: <Widget>[
            new UserAccountsDrawerHeader(
              accountName: new Text(
                _tst != null ? _tst['name'] : "Unknown",
                style: new TextStyle(fontSize: 18.0),
              ),
              accountEmail: new Text(_tst['contacts'].toString() != null ? _tst['contacts'][0]['email'].toString() : "Unknown"),
              currentAccountPicture: new GestureDetector(
                onTap: () {
                  Fluttertoast.showToast(
                      msg: "This is Your Account Picture",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.CENTER,
                      timeInSecForIos: 1);
                },
                child: new CircleAvatar(
                  backgroundImage: new NetworkImage("https://bit.ly/2OR2OhK"),
                ),
              ),
              decoration: new BoxDecoration(
                  // color: Colors.limeAccent,
                  image: new DecorationImage(
                      fit: BoxFit.fill,
                      image: new NetworkImage("https://bit.ly/2ANJNJT"))),
            ),
            new ListTile(
                title: new Text("Profile"),
                trailing: new Icon(Icons.person),
                onTap: () {
                  UserProfile();
                  var route = new MaterialPageRoute(
                    builder: (BuildContext context) =>
                        new UserProfile(uname: tid),
                  );
                  Navigator.of(context).push(route);
                }),
            new ListTile(
              title: new Text("Favorites"),
              trailing: new Icon(Icons.tag_faces),
            ),
            new ListTile(
              title: new Text("Places"),
              trailing: new Icon(Icons.place),
              onTap: () => Navigator.of(context).push(new MaterialPageRoute(
                  builder: (BuildContext context) => new Home())),
            ),
            new ListTile(
              title: new Text("About Us"),
              trailing: new Icon(Icons.contact_phone),
            ),
            new Divider(),
            new ListTile(
              title: new Text("LogOut"),
              trailing: new Icon(Icons.exit_to_app),
              onTap: () => _neverSatisfied()
            ),
          ]
        )
      ),
      appBar: new AppBar(
        title: new Text(_tst != null ? "Welcome " + _tst['name'] : "Welcome"),
        actions: <Widget>[
          /*  IconButton(
            onPressed: () {
              Navigator.push(context,
                  new MaterialPageRoute(builder: (context) => new Profile()));
            },
            icon: new Icon(Icons.local_gas_station),
          ), */
          IconButton(
            onPressed: () {
              UserProfile();
              var route = new MaterialPageRoute(
                builder: (BuildContext context) => new UserProfile(uname: tid),
              );
              Navigator.of(context).push(route);
            },
            icon: new Icon(Icons.supervised_user_circle),
          )
        ],
      ),
      body: _children[_currentIndex],
      bottomNavigationBar: new BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (int index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
              icon: new Icon(Icons.home), title: new Text("Home")),
          BottomNavigationBarItem(
            icon: new Icon(Icons.search),
            title: new Text("Search"),
          )
        ],
      ),
    );
  }
}

class PlaceholderWidget extends StatelessWidget {
  final Color color;

  PlaceholderWidget(this.color);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: color,
    );
  }
}
