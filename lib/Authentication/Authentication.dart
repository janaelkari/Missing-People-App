import 'package:flutter/material.dart';
import 'package:flutter_appretry/Authentication/register.dart';

import 'Sign_in.dart';


class Authenticate extends StatefulWidget {
  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {

  bool showSignIn = true ;
  void toggleView(){
    setState(()=> showSignIn = !showSignIn);
  }

  @override
  Widget build(BuildContext context) {
    if (showSignIn){
      return SignIN(toggleView: toggleView);
    }else {
      return Register(toggleView:toggleView);
    }
  }
}
