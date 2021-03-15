import 'package:flutter/material.dart';
class ContactScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ContactScreenState();
  }
}

class _ContactScreenState extends State<ContactScreen> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text(" App Notifications "),
      ),
    );
  }
}
