import 'package:flutter/material.dart';

import 'auth.dart';
import 'loading.dart';


class SignIN extends StatefulWidget {

  final Function toggleView;
  SignIN({this.toggleView});

  @override
  _SignINState createState() => _SignINState();
}

class _SignINState extends State<SignIN> {

  final AuthService _auth =  AuthService();
  final _formkey = GlobalKey<FormState>();
  bool loading =  false;

  //text field state
  String email = "";
  String password = "";
  String error = "";

  @override
  Widget build(BuildContext context) {
    return loading ? Loading() :  Scaffold(
      backgroundColor: Colors.red[300],
      appBar: AppBar(
        backgroundColor: Colors.red,
        actions: <Widget>[
          FlatButton.icon(
            icon: Icon(Icons.person),
            label: Text("Register"),
            onPressed: (){
              widget.toggleView();
            },
          )
        ],
        elevation: 0.0,
        title: Text("Sign In To Missing People "),
      ),
      body: Container(
          padding: EdgeInsets.symmetric(vertical: 20.0 ,horizontal: 50.0),
          child:Form(
            key: _formkey,
            child: Column(
              children:<Widget>[
                SizedBox(height:20.0),
                TextFormField(
                  decoration: InputDecoration(
                    hintText: 'Email',
                    fillColor: Colors.white,
                    filled: true,
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white , width: 2.0)
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.red , width: 2.0)
                    ),
                  ),
                  validator: (val) => val.isEmpty ? 'Enter an email': null,
                  onChanged: (val){
                    setState(()=> email = val);
                  },
                ),
                SizedBox(height:20.0),
                TextFormField(
                  decoration: InputDecoration(
                    hintText: 'Password',
                    fillColor: Colors.white,
                    filled: true,
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white , width: 2.0)
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.red , width: 2.0)
                    ),
                  ),
                  validator: (val) => val.length<6 ? 'Enter The password 6+ chars long': null,
                  obscureText: true,
                  onChanged: (val){
                    setState(()=> password = val);
                  },
                ),
                SizedBox(height:20.0),
                RaisedButton(
                    color: Colors.red,
                    child : Text(
                      'Sign In',
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () async {
                      if (_formkey.currentState.validate()) {
                        setState(() => loading = true);
                        dynamic result = await _auth.signIN_With_Email_Password(
                            email, password);
                        if (result == null) {
                          setState(() {
                            error = "Could not sign in with those credentials";
                            loading = false;
                          });
                        }
                      }
                    }
                ),
                SizedBox(height: 20,),
                Text(error,
                  style: TextStyle(color: Colors.red, fontSize: 14.0),
                ),
              ],
            ),
          )
      ),
    );
  }
}
