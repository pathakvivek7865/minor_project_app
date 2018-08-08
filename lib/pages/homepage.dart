import 'package:flutter/material.dart';
// import 'dart:convert';
// import 'dart:io';

// import './profile.dart';
import './home/home.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:touristguide/pages/home/login/login_page.dart';
// import './home/login/userprofile.dart';
// import 'package:material_search/material_search.dart';
import 'package:touristguide/pages/home/search/search.dart';
// import 'package:http/http.dart' as http;

class MyHomePage extends StatefulWidget {
  // final String pvalue;

  // MyHomePage({Key key, this.pvalue}) : super(key: key);

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // var _tst;

  int _currentIndex = 0;
    // final List<Widget> _children = [ PlaceholderWidget(Colors.orangeAccent), PlaceholderWidget(Colors.blueAccent)]; 
  final List<Widget> _children = [new Home(),new SearchBar()/* PlaceholderWidget(Colors.blueAccent) */];

  @override
  void initState() {
    super.initState();
/*     String duser = "${widget.pvalue}";
    String pbool = duser[0];
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
    }
    _fetchData(tid); */
  }
/* 
  _fetchData(String tid) async {
    String username = 'beingbivek@gmail.com';
    String password = 'bivek';
    String basicAuth =
        'Basic ' + base64Encode(utf8.encode('$username:$password'));
    //print(basicAuth);

    final url = "http://192.168.100.4:8090/tourists/$tid";
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
  } */

      _neverSatisfied() async {
        final logo = Hero(
      tag: 'hero',
      child: CircleAvatar(
        backgroundColor: Colors.transparent,
        radius: 48.0,
        child: Image.network("https://bit.ly/2OR2OhK"),
      ),
    );
    return showDialog<Null>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return new AlertDialog(
        title: new Container(
        child: Column(
          children: <Widget>[
            logo,
        new Text('Login or SignUp'),
          ],
        ),
        ),
        actions: <Widget>[
          new RaisedButton(
            child: new Text('Login'),
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (BuildContext context) => LoginPage()
              ));
            },
          ),
          new RaisedButton(
            child: new Text('SignUp'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
    }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      drawer: new Drawer(
        child: new ListView(
          children: <Widget>[
            new UserAccountsDrawerHeader(
              accountName: new Text("Username",style: new TextStyle(fontSize: 18.0),),
              accountEmail: new Text("Email"),
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
              title: new Text("Login/Signup"),
              trailing: new Icon(Icons.arrow_forward),
              onTap: () => _neverSatisfied()
            ),/* 
             new ListTile(
              title: new Text("Profile"),
              trailing: new Icon(Icons.person),
              onTap: () => Navigator.of(context).push(new MaterialPageRoute(
                builder: (BuildContext context) => new UserProfile()
              )),
            ), */
            new ListTile(
              title: new Text("Favorites"),
              trailing: new Icon(Icons.tag_faces),
            ),
            new ListTile(
              title: new Text("Places"),
              trailing: new Icon(Icons.place),
              onTap: () => Navigator.of(context).push(new MaterialPageRoute(
                  builder: (BuildContext context) => new Home()
                  )),
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
        title: new Text("ITG"),
        actions: <Widget>[
/*           IconButton(
            onPressed: () {
              Navigator.push(context,
                  new MaterialPageRoute(builder: (context) => new Profile()));
            },
            icon: new Icon(Icons.local_gas_station),
          ), */
          IconButton(
            onPressed: () {
              Navigator.push(context,
                  new MaterialPageRoute(builder: (context) => new LoginPage()));
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