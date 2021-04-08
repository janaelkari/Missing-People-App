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

  _openCamera(BuildContext context) async {
    var picture = await ImagePicker.pickImage(source: ImageSource.camera);
    this.setState(() {
      imageFile = picture;
    });
    Navigator.of(context).pop();
  }

////////////////////////////////////////////////////////////////////////////////
  Future <void> _showChoiceDialog(BuildContext context) {
    return showDialog(context: context, builder: (BuildContext context) {
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

  Widget _imageView() {
    if (imageFile == null) {
      return Text("No Image Selected!");
    }
    else {
      return Image.file(imageFile, height: 400, width: 400);
    }
  }

////////////////////////////////////////////////////////////////////////////////
  final _formKey = GlobalKey<FormState>();
  bool _validate = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: new AppBar(
          title: Text("Add A Missing Person"),
          backgroundColor: Colors.red,
        ),
        body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Form(
              key: _formKey,
              autovalidate: _validate,
              child: SingleChildScrollView(
                child: new Column(
                    children: <Widget>[

                      Padding(
                        padding: const EdgeInsets.symmetric(vertical:8.0),
                        child: new TextFormField(
                          validator: validateName,

                          decoration: new InputDecoration(
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.red),
                                  borderRadius: BorderRadius.circular(15)

                              ),
                              labelText: "Full Name of missing"),
                          onChanged: (value) {
                            textname = value;
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical:8.0),
                        child: new TextFormField(
                          validator: validateAge,

                          decoration: new InputDecoration(
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.red),
                                  borderRadius: BorderRadius.circular(15)

                              ),
                              labelText: " Age of missing"),
                          keyboardType: TextInputType.number,

                          onChanged: (value) {
                            adressname = value;
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical:8.0),
                        child: new TextFormField(
                          validator: validateNumber,

                          onChanged: (value) {
                            phonenum = value;
                          },
                          decoration: new InputDecoration(
                            border: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.red),
                                borderRadius: BorderRadius.circular(15)

                            ),
                            labelText: " Phone Number",
                          ),
                          keyboardType: TextInputType.number,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical:8.0),
                        child: new TextFormField(
                          validator: validateCity,

                          onChanged: (value) {
                            nofm = value;
                          },
                          decoration: new InputDecoration(
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.red),
                                  borderRadius: BorderRadius.circular(15)

                              ),
                              labelText: "City"),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical:8.0),
                        child: new TextFormField(
                          validator: validateAddress,

                          onChanged: (value) {
                            agenum = value;
                          },
                          decoration: new InputDecoration(
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.red),
                                  borderRadius: BorderRadius.circular(15)

                              ),
                              labelText: "Address"),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical:8.0),
                        child: new TextFormField(
                          validator: validateDescription,

                          onChanged: (value) {
                            ls = value;
                          },
                          decoration: new InputDecoration(
                            border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.red),
                              borderRadius: BorderRadius.circular(15)

                            ),
                              labelText: "Description",
                            helperText: "Where was the missing person last seen,\nwhat he was wearing,any specific info on the missing..."
                          ),
                        ),
                      ),

                      SizedBox(
                          height: 20.0
                      ),
                      _imageView(),
                      RaisedButton(onPressed: () {
                        _showChoiceDialog(context);
                      }, child: Text("Upload Image"),),

                      RaisedButton(onPressed: () {
                        if (_formKey.currentState.validate()){
                          _firestore.collection('m').add({
                            'name': textname,
                            'adress': adressname,
                            'phone': phonenum,
                            'age' : agenum,
                            'nameofmissing': nofm,
                            'lastseen': ls,
                          });

                        }
                        else{
                          setState(() {
                            _validate = true;

                          });
                        }

                      },

                        child: Text("Submit"),
                        color: Colors.red,),

                    ]

                ),
              ),
            )
        )
    );
  }

  String validateName(String value) {
    if (value.isEmpty) {
      return "Name is required!.";
    }

    if (value.length < 3) {
      return "Name must be more than two characters!.";
    }

      return null;
  }

  String validateAge(String value) {
    if (value.isEmpty) {
      return "Age is Required!";
    }
      return null;

  }

  String validateCity(String value) {
    if (value.isEmpty) {
      return "City is Required!";
    }
      return null;

  }

  String validateAddress(String value) {
    if (value.isEmpty) {
      return "Address is Required!";
    }

      return null;
  }

  String validateDescription(String value) {
    if (value.isEmpty) {
      return "Description is Required!";
    }
      return null;

  }
  String validateNumber(String value) {
    if (value.isEmpty) {
      return "Phone Number is Required!";
    }
    if (value.length != 8){
      return 'Mobile Number must be of 8 digits';}
    else {
      return null;
    }
  }
}
