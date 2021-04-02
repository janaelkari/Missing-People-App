import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';


class Add_missing extends StatefulWidget {
  @override
  _Add_missingState createState() => _Add_missingState();
}

class _Add_missingState extends State<Add_missing> {
  final _firestore = Firestore.instance;
  String textname;
  String adressname;
  String phonenum;
  String agenum;
  String nofm;
  String ls;
  File imageFile;

  _openGallery(BuildContext context) async {
    var picture = await ImagePicker.pickImage(source: ImageSource.gallery);
    this.setState(() {
      imageFile = picture;
    });
    Navigator.of(context).pop();
  }
  _openCamera(BuildContext context) async{
    var picture = await ImagePicker.pickImage(source: ImageSource.camera);
    this.setState(() {
      imageFile = picture;
    });
    Navigator.of(context).pop();
  }
////////////////////////////////////////////////////////////////////////////////
  Future <void> _showChoiceDialog(BuildContext context){
    return showDialog(context: context,builder: (BuildContext context) {
      return AlertDialog(
        title: Text("Upload From :"),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              GestureDetector(
                  child: Text("Gallery"),
                  onTap: () {
                    _openGallery(context);
                  }
              ),
              Padding(padding: EdgeInsets.all(8.0)),
              GestureDetector(
                  child: Text("Camera"),
                  onTap: () {
                    _openCamera(context);
                  }
              ),
            ],
          ),
        ),
      );
    });
  }
////////////////////////////////////////////////////////////////////////////////

  Widget _imageView(){
    if (imageFile == null) {
      return Text("No Image Selected!");
    }
    else{
      return  Image.file(imageFile, height:400, width:400);
    }
  }

////////////////////////////////////////////////////////////////////////////////
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: Text("Add A Missing Person"),
        backgroundColor: Colors.red,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                new TextField(
                  decoration: new InputDecoration(labelText: "Name of the Seeker"),
                  onChanged: (value){
                    textname = value;
                  },
                ),
                new TextField(
                  decoration: new InputDecoration(labelText: " Seeker's Address"),
                  onChanged: (value){
                    adressname = value;
                  },
                ),
                new TextField(
                  onChanged: (value){
                    phonenum = value;
                  },
                  decoration: new InputDecoration(
                    labelText: " Seeker's Phone Number",
                  ),
                  keyboardType: TextInputType.number,
                ),
                new TextField(
                  onChanged: (value){
                    nofm = value;
                  },
                  decoration: new InputDecoration(labelText: "Name of the Missing"),
                ),
                new TextField(
                  onChanged: (value){
                    agenum = value;
                  },
                  decoration: new InputDecoration(labelText: "Age of the Missing"),
                ),
                new TextField(
                  onChanged: (value){
                    ls = value;
                  },
                  decoration: new InputDecoration(labelText: "Last place seen"),
                ),

                SizedBox(
                    height: 20.0
                ),
                _imageView(),
                RaisedButton(onPressed :(){
                  _showChoiceDialog(context);
                }, child: Text("Upload Image"),),

                RaisedButton(onPressed :(){
                    _firestore.collection('m').add({
                      'name': textname,
                      'adress': adressname,
                      'phone': phonenum,
                      'age' : agenum,
                      'nameofmissing': nofm,
                      'lastseen': ls,
                    });
                }, child: Text("Submit"),
                color: Colors.red,),

              ]
          ),
        ),
      ),
    );
  }
}
