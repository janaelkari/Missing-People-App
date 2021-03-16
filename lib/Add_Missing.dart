import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class Add_missing extends StatefulWidget {
  @override
  _Add_missingState createState() => _Add_missingState();
}

class _Add_missingState extends State<Add_missing> {

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
                ),
                new TextField(
                  decoration: new InputDecoration(labelText: " Seeker's Address"),
                ),
                new TextField(
                  decoration: new InputDecoration(
                    labelText: " Seeker's Phone Number",
                  ),
                  keyboardType: TextInputType.number,
                ),
                new TextField(
                  decoration: new InputDecoration(labelText: "Name of the Missing"),
                ),
                new TextField(
                  decoration: new InputDecoration(labelText: "Age of the Missing"),
                ),
                new TextField(
                  decoration: new InputDecoration(labelText: "Last place seen"),
                ),

                SizedBox(
                    height: 20.0
                ),
                _imageView(),
                RaisedButton(onPressed :(){
                  _showChoiceDialog(context);
                }, child: Text("Upload Image"),)

              ]
          ),
        ),
      ),
    );
  }
}
