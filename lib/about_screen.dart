import 'package:flutter/material.dart';

class AboutScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _AboutScreenState();
  }
}

class _AboutScreenState extends State<AboutScreen> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("About App"),
      ),
      body:
      new Align(
        alignment: Alignment.centerLeft,
        child:

        new Text(
          ' The main problem is that many people go missing or lost for unknown reasons in various Lebanese districts.This apps role is to spread information about the missing people through connections between seekers and trackers which raises the probability of finding the missing person.',
          textAlign: TextAlign.justify,
          style: TextStyle(
            color: Colors.red,
            fontSize: 25,

          ),

        ),


      ),

    );
  }
}
