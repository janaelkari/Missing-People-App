import 'package:flutter/material.dart';
import 'package:flutter_appretry/Authentication/user.dart';
import 'package:provider/provider.dart';
import '../main.dart';
import '../main.dart';
import 'Authentication.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final user = Provider.of<User>(context);
    if(user ==  null){
      return Authenticate();
    }else {
      return MyHomePage();
    }
  }
}
