import 'package:flutter/material.dart';

import 'pages/profile.dart';
import './pages/home/home.dart';
import 'package:fluttertoast/fluttertoast.dart';

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
  int _currentIndex = 0;
  final List<Widget> _children = [
   PlaceholderWidget(Colors.deepOrange),
   PlaceholderWidget(Colors.green)
   ];

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      drawer: new Drawer(
        child: new ListView(
          children: <Widget>[
            new UserAccountsDrawerHeader(
              accountName: new Text("Bivek Thapa"),
              accountEmail: new Text("beingbivek@gmail.com"),
              currentAccountPicture: new GestureDetector(
                onTap: () {
                  Fluttertoast.showToast(
        msg: "This is Your Account Picture",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIos: 1
    );
            },
                child: new CircleAvatar(
                  backgroundImage: new NetworkImage("https://bit.ly/2M41eqZ"),
                ),
              ),
              decoration: new BoxDecoration(
                image: new DecorationImage(
                  fit: BoxFit.fill,
                  image: new NetworkImage("https://bit.ly/2M8PmUk")
                )
              ),
            ),
            new ListTile(
              title: new Text("Favorites"),
              trailing: new Icon(Icons.border_right),            
            ),
            new ListTile(
              title: new Text("Places"),
              trailing: new Icon(Icons.place),  
              onTap: () => Navigator.of(context).push(new MaterialPageRoute(builder: 
              (BuildContext context) => new Home())),          
            ),
            new ListTile(
              title: new Text("About Us"),
              trailing: new Icon(Icons.contact_phone),            
            ),
            new Divider(),
            new ListTile(
              title: new Text("Close"),
              trailing: new Icon(Icons.close), 
              onTap:() => Navigator.of(context).pop(),           
            )
          ],
        ),
      ),
      appBar: new AppBar(
        title: new Text(widget.title),
        actions: <Widget>[
          IconButton(
            onPressed:() {

              Navigator.push(
                context,
                 new MaterialPageRoute(
                   builder: (context) => new Profile()
                 )
                 
              );

            },
            icon: new Icon(Icons.local_gas_station),
          ),
          IconButton(
            onPressed:() {

              Navigator.push(
                context,
                 new MaterialPageRoute(
                   builder: (context) => new Home()
                 )
                 
              );

            },
            icon: new Icon(Icons.home),
          )
        ],
      ),
      body: _children[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _onTabTapped,
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

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}

class PlaceholderWidget extends StatelessWidget {
  final Color color;

  PlaceholderWidget(this.color);

  @override
  Widget build(BuildContext context) {
    return Container(color: color,);
  }

}
