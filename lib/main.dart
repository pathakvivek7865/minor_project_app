import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

import 'pages/profile.dart';
import './pages/home/home.dart';
import 'package:touristguide/pages/login.dart';
import 'package:touristguide/pages/place.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: new ThemeData(
        primarySwatch: Colors.amber,
      ),
      home: new MyHomePage(title: 'Tour'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var _tst;

/* TabBar items*/
  int _currentIndex = 0;
  final List<Widget> _children = [
    new Home(),
    PlaceholderWidget(Colors.blueAccent)
  ];

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

/* This is the function to connect to server and retrieve the tourist information */
  _fetchData() async {
    String username = 'vivek';
    String password = 'vivek';
    String basicAuth =
        'Basic ' + base64Encode(utf8.encode('$username:$password'));
    //print(basicAuth);

    final url = 'http://192.168.1.73:8090/tourists/1/';
    //final url = "http://10.2.0.0:8090/tourists/1";
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
      } else {
        // _tst = 'Error getting response:\nHttp status ${response.statusCode}';
      }
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
        // navigation drawer
        child: new ListView(
          children: <Widget>[
            new UserAccountsDrawerHeader(
              accountName: new Text(
                _tst != null ? _tst['name'] : "Unknown",
                style: new TextStyle(fontSize: 26.0, color: Colors.white),
              ),
              accountEmail: new Text(
                _tst != null
                    ? _tst['contacts'][0]['email'].toString()
                    : 'Unknown',
                style: new TextStyle(fontSize: 18.0, color: Colors.white),
              ),
              currentAccountPicture: new GestureDetector(
                onTap: () {
                  Scaffold.of(context).showSnackBar(
                        new SnackBar(
                          content: new Text("Added to favorite"),
                          action: new SnackBarAction(
                            label: "UNDO",
                            onPressed: () =>
                                Scaffold.of(context).hideCurrentSnackBar(),
                          ),
                        ),
                      );

                  /*  Fluttertoast.showToast(
                      msg: "This is Your Account Picture",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.CENTER,
                      timeInSecForIos: 1); */
                },
                child: new CircleAvatar(
                  backgroundColor: Colors.red,
                  backgroundImage: new NetworkImage("https://bit.ly/2M8yJLQ"),
                ),
              ),
              decoration: new BoxDecoration(
                  color: Colors.orange,
                  image: new DecorationImage(
                      fit: BoxFit.fill,
                      image: new NetworkImage("https://bit.ly/2nf4Hbb"))),
            ),
            new ListTile(
              /* this populate profile of the tourist from /pages/profile.dart file */
              title: new Text("Profile"),
              leading: new Icon(Icons.person),
              onTap: () => Navigator.of(context).push(new MaterialPageRoute(
                  builder: (BuildContext context) => new Profile())),
            ),
            new ListTile(
              title: new Text("Favorites"),
              leading: new Icon(Icons.tag_faces),
            ),
            new ListTile(
              title: new Text("Places"),
              leading: new Icon(Icons.place),
              onTap: () => Navigator.of(context).push(new MaterialPageRoute(
                  builder: (BuildContext context) => new Place())),
            ),
            new ListTile(
              title: new Text("About Us"),
              leading: new Icon(Icons.contact_phone),
            ),
            new Divider(),
            new ListTile(
              title: new Text("Close"),
              leading: new Icon(Icons.close),
              onTap: () => Navigator.of(context).pop(),
            )
          ],
        ),
      ),
      appBar: new AppBar(
        title: new Text(widget.title),
        actions: <Widget>[
          IconButton(
            onPressed: () {
              Navigator.push(context,
                  new MaterialPageRoute(builder: (context) => new Profile()));
            },
            icon: new Icon(Icons.local_gas_station),
          ),
          IconButton(
            onPressed: () {
              Navigator.push(context,
                  new MaterialPageRoute(builder: (context) => new Login()));
            },
            icon: new Icon(Icons.supervised_user_circle),
          )
        ],
      ),

      /* botttom navigatiation bar*/
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

/* class for tab onTap to display colos*/
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
