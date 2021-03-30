import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'user.dart';

class AuthService {

  final FirebaseAuth _auth = FirebaseAuth.instance;

  //create a user obj based on a firebase user
  User _userFromFirebaseUser( FirebaseUser user){
    return user!= null ? User(uid: user.uid) : null;
  }

  // auth change user stream
  Stream <User> get user{
    return _auth.onAuthStateChanged
        .map(_userFromFirebaseUser);
  }

  //sign in anonymous
  Future signInAnon() async{
    try{
      AuthResult result = await _auth.signInAnonymously();
      FirebaseUser user =  result.user;
      return _userFromFirebaseUser(user);
    }catch(e){
      print(e.toString());
      return null ;
    }
  }


  //sign in with email and password
  Future signIN_With_Email_Password(String email , String password) async {
    try{
      AuthResult result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      FirebaseUser user  =  result.user;
      return _userFromFirebaseUser(user);

    }catch(e){
      print(e.toString());
      return null;
    }
  }

  //register using email and password
  Future register_With_Email_Password(String email , String password) async {
    try{
      AuthResult result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      FirebaseUser user  =  result.user;
      return _userFromFirebaseUser(user);

    }catch(e){
      print(e.toString());
      return null;
    }
  }
  //sign out
  Future signOut() async{
    try{
      return await _auth.signOut();
    }catch(e){
      print(e.toString());
      return null;
    }
  }


}