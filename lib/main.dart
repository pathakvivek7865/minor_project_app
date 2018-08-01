import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:io';

import 'pages/profile.dart';
import './pages/home/home.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:touristguide/pages/login.dart';
// import 'package:material_search/material_search.dart';
import 'package:touristguide/pages/home/search/search.dart';
import 'package:http/http.dart' as http;

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
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

  int _currentIndex = 0;
    // final List<Widget> _children = [ PlaceholderWidget(Colors.orangeAccent), PlaceholderWidget(Colors.blueAccent)]; 
  final List<Widget> _children = [new Home(),new SearchBar()/* PlaceholderWidget(Colors.blueAccent) */];

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

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      drawer: new Drawer(
        child: new ListView(
          children: <Widget>[
            new UserAccountsDrawerHeader(
              accountName: new Text(_tst != null ?_tst['name'] : "Unknown",style: new TextStyle(fontSize: 18.0),),
              accountEmail: new Text(_tst['contacts'][0]['email'].toString()),
              currentAccountPicture: new GestureDetector(
                onTap: () {
                  Fluttertoast.showToast(
                      msg: "This is Your Account Picture",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.CENTER,
                      timeInSecForIos: 1);
                },
                child: new CircleAvatar(
                  backgroundColor: Colors.red,
                  // backgroundImage: new NetworkImage("https://bit.ly/2M41eqZ"),
                ),
              ),
              decoration: new BoxDecoration(
                color: Colors.limeAccent,
                  /* image: new DecorationImage(
                      fit: BoxFit.fill,
                      image: new NetworkImage("https://bit.ly/2M8PmUk")) */),
            ),
             new ListTile(
              title: new Text("Profile"),
              trailing: new Icon(Icons.person),
              onTap: () => Navigator.of(context).push(new MaterialPageRoute(
                builder: (BuildContext context) => new Profile()
              )),
            ),
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
              title: new Text("Close"),
              trailing: new Icon(Icons.close),
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
                  new MaterialPageRoute(builder: (context) => new Test()));
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
