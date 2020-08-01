import 'dart:async';
import 'dart:io';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:practice_project/Shared/loading.dart';
import 'package:practice_project/models/user.dart';
import 'package:provider/provider.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart' as Path;

class AddItem extends StatefulWidget {
  @override
  _AddItemState createState() => _AddItemState();
}

class _AddItemState extends State<AddItem> {
  final _nameController = TextEditingController();
  final _priceController = TextEditingController();
  final _descriptionController = TextEditingController();

  var text = '';
  bool _loading = false;

  File _image;
  final picker = ImagePicker();
  String imageURL;

  Future getImageFromCamera() async {
    final pickedFile = await picker.getImage(
        source: ImageSource.camera, maxWidth: 350, maxHeight: 350);

    setState(() {
      _image = File(pickedFile.path);
    });
  }

  Future getImageFromDevice() async {
    final pickedFile = await picker.getImage(
        source: ImageSource.gallery, maxWidth: 350, maxHeight: 350);

    setState(() {
      _image = File(pickedFile.path);
    });
  }

  // firebase real time database

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    var _firebaseRef = FirebaseDatabase().reference().child(user.uid);

    Future uploadFile(String time) async {
      StorageReference storageReference = FirebaseStorage.instance
          .ref()
          .child('Images/${Path.basename(_image.path)}}');
      StorageUploadTask uploadTask = storageReference.putFile(_image);
      await uploadTask.onComplete;
      print('File Uploaded');
      await storageReference.getDownloadURL().then((value) {
        setState(() {
          imageURL = value;
        });
      });
      print('the url of image is ' + imageURL);
    }

    Future sendMessge(String name, String description, double price) async {
      var time = DateTime.now().millisecondsSinceEpoch.toString();
      await uploadFile(time);
      await _firebaseRef.push().set({
        "name": name,
        "description": description,
        "price": price,
        "imageURL": imageURL,
      });
      setState(() {
        _loading = false;
        Navigator.pop(context);
      });
    }

    return _loading
        ? Loading()
        : Scaffold(
            appBar: AppBar(
              leading: IconButton(
                icon: Icon(
                  Icons.arrow_back,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              title: Text('Add Item'),
            ),
            body: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(height: 30),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: TextField(
                      controller: _nameController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Name',
                      ),
                    ),
                  ),
                  SizedBox(height: 20.0),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    child: TextField(
                      controller: _descriptionController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Decription',
                      ),
                    ),
                  ),
                  SizedBox(height: 20.0),

                  Container(
                    width: 100,
                    margin: EdgeInsets.only(left: 20),
                    child: TextField(
                      controller: _priceController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Price',
                      ),
                    ),
                  ),
                  // BottomModalSheet starts from here

                  Container(
                    margin: EdgeInsets.only(left: 20),
                    child: RaisedButton(
                      child: Text('Add Image'),
                      onPressed: () {
                        showModalBottomSheet(
                          context: context,
                          builder: (BuildContext context) {
                            return Container(
                              height: 170,
                              child: Column(
                                children: <Widget>[
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Container(
                                    height: 50,
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 16),
                                    child: GestureDetector(
                                      onTap: () {
                                        Navigator.pop(context);
                                        //Upload image from device
                                        getImageFromDevice();
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                            color: Color(0xFFF05A22),
                                            style: BorderStyle.solid,
                                            width: 1.0,
                                          ),
                                          color: Colors.transparent,
                                          borderRadius:
                                              BorderRadius.circular(30),
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: <Widget>[
                                            Center(
                                              child: Text(
                                                'UPLOAD FROM DEVICE',
                                                style: TextStyle(
                                                    color: Color(0xFFF05A22),
                                                    fontFamily: 'Mantserrat',
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w600,
                                                    letterSpacing: 1),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Container(
                                    height: 50,
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 16),
                                    child: GestureDetector(
                                      onTap: () {
                                        Navigator.pop(context);
                                        getImageFromCamera();
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                            color: Color(0xFFF05A22),
                                            style: BorderStyle.solid,
                                            width: 1.0,
                                          ),
                                          color: Colors.transparent,
                                          borderRadius:
                                              BorderRadius.circular(30),
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: <Widget>[
                                            Center(
                                              child: Text(
                                                'OPEN CAMERA',
                                                style: TextStyle(
                                                  color: Color(0xFFF05A22),
                                                  fontFamily: 'Mantserrat',
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w600,
                                                  letterSpacing: 1,
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ),

                  SizedBox(height: 20.0),
                  Center(
                    child: Text(text,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.red[700],
                        )),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        alignment: Alignment.center,
                        width: 400,
                        child: _image == null
                            ? Text('No image selected.')
                            : Image.file(_image),
                      )
                    ],
                  ),

                  Padding(
                    padding: EdgeInsets.fromLTRB(0.0, 10.0, 30, 0.0),
                    child: ButtonBar(
                      children: <Widget>[
                        FlatButton(
                          child: Text('CANCEL'),
                          onPressed: () {
                            _nameController.clear();
                            _priceController.clear();
                            _descriptionController.clear();
                            Navigator.pop(context);
                          },
                        ),
                        // TODO: Add an elevation to NEXT(103)
                        // TODO: Add an beveled rectangular border to NEXT(103)
                        RaisedButton(
                          child: Text('ADD'),
                          elevation: 5,
                          onPressed: () async {
                            if (_nameController.text.isNotEmpty &&
                                _priceController.text.isNotEmpty &&
                                _descriptionController.text.isNotEmpty &&
                                _image != null) {
                              /*                     await service.updateUserData(
                          _nameController.text,
                          _descriptionController.text,
                          double.parse(_priceController.text));*/
                              setState(() {
                                _loading = true;
                                text = '';
                              });
                              await sendMessge(
                                _nameController.text,
                                _descriptionController.text,
                                double.parse(_priceController.text),
                              );
                            } else if (_nameController.text.isEmpty) {
                              setState(() {
                                text = 'Name cann\'t be empty';
                              });
                            } else if (_descriptionController.text.isEmpty) {
                              setState(() {
                                text = 'Description cann\'t be empty';
                              });
                            } else if (_priceController.text.isEmpty) {
                              setState(() {
                                text = 'Price cann\'t be empty';
                              });
                            } else if (_image == null) {
                              setState(() => text = 'Image cann\'t be empty');
                            }
                          },
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
  }
}
