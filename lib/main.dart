import 'dart:async';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_appretry/Add_Missing.dart';
import 'package:flutter_appretry/SpalshScreen.dart';
import 'package:flutter_appretry/about_screen.dart';
import 'package:flutter_appretry/SettingScreen.dart';
import 'package:flutter_appretry/MissingList.dart';
import 'package:provider/provider.dart';

import 'Authentication/Wrapper.dart';
import 'Authentication/auth.dart';
import 'Authentication/user.dart';

void main() => runApp(MaterialApp(
      theme: ThemeData(primaryColor: Colors.red, accentColor: Colors.white),
      debugShowCheckedModeBanner: false,
      home: MyApp(),
    ));

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>.value(
    value: AuthService().user,
     child: MaterialApp(
      title: 'Flutter Demo',
      routes: {
        '/about': (context) => AboutScreen(),
        "/contact": (context) => ContactScreen(),
        "/Add_A_Missing": (context) => Add_missing(),
      },
      theme: ThemeData(
        primarySwatch: Colors.red,

      ),
      home: Wrapper(),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  File _image;
  bool showSplash;

  Future getImage() async {
    setState(() {});
  }

  Timer _timer;
  int _start = 2;

  void startTimer() {
    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(
      oneSec,
      (Timer timer) {
        if (_start == 0) {
          setState(() {
            timer.cancel();
            showSplash = false;
          });
        } else {
          setState(() {
            _start--;
          });
        }
      },
    );
  }

  @override
  void initState() {
    showSplash = true;
    startTimer();
    super.initState();
  }

  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    if(showSplash) return SplashScreen();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,

        title: Center(
          child: Text('Missing People'),
        ),

        actions: <Widget>[
          FlatButton.icon(
            icon: Icon(Icons.person),
            label: Text('logout'),
            onPressed: () async {
              await _auth.signOut();
            },
          )
        ],
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            UserAccountsDrawerHeader(
              accountName: Text('Missing People'),
              accountEmail: Text("MissingPeopleTeam@gmail.com"),
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.white,
                backgroundImage: NetworkImage(
                    "https://nen.press/wp-content/uploads/2019/02/people_graphic.png"),
              ),
            ),
            ListTile(
              leading: Icon(Icons.home),
              title: Text("Home"),
              onTap: () {
                Navigator.of(context).pop();
              },
            ),
            ListTile(
              leading: Icon(Icons.info),
              title: Text("About Application"),
              onTap: () {
                Navigator.of(context).pushNamed("/about");
              },
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text("Settings"),
              onTap: () {
                Navigator.of(context).pushNamed("/contact");
              },
            ),
          ],
        ),
      ),
      body: MissingList(),
      floatingActionButton: FloatingActionButton.extended(
        icon: Icon(Icons.add),
        label: Text(
          "Add a Missing Person",
          style: TextStyle(fontSize: 18),
        ),
        onPressed: () {
          Navigator.of(context).pushNamed("/Add_A_Missing");
        },
        backgroundColor: Colors.red,
      ),
    );
  }
}
