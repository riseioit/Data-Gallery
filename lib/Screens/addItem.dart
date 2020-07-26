import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

class AddItem extends StatefulWidget {
  @override
  _AddItemState createState() => _AddItemState();
}

class _AddItemState extends State<AddItem> {
  final _nameController = TextEditingController();
  final _priceController = TextEditingController();
  final _descriptionController = TextEditingController();
  var text = '';
  bool _isVisible = true;

  final _textKey = GlobalKey<EditableTextState>();

  File _image;
  final picker = ImagePicker();

  Future getImageFromCamera() async {
    final pickedFile = await picker.getImage(
        source: ImageSource.camera, maxWidth: 350, maxHeight: 350);

    setState(() {
      _image = File(pickedFile.path);
      if (_image != null) {
        _isVisible = false;
      }
    });
  }

  Future getImageFromDevice() async {
    final pickedFile = await picker.getImage(
        source: ImageSource.gallery, maxWidth: 350, maxHeight: 350);

    setState(() {
      _image = File(pickedFile.path);
      if (_image != null) {
        _isVisible = false;
      }
    });
  }

  void hideAddImageButton() {
    if (_image != null) {
      setState(() {
        _isVisible = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            // TODO: Wrap Username with AccentColorOverride (103)
            // TODO: Remove filled: true values (103)
            // TODO: Wrap Password with AccentColorOverride (103)
            // TODO: Add TextField widgets (101)
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: TextField(
                key: _textKey,
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
            Visibility(
              visible: _isVisible,
              child: Container(
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
                                padding: EdgeInsets.symmetric(horizontal: 16),
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
                                      borderRadius: BorderRadius.circular(30),
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
                                padding: EdgeInsets.symmetric(horizontal: 16),
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
                                      borderRadius: BorderRadius.circular(30),
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
                                                letterSpacing: 1),
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

            ButtonBar(
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
                  child: Text('NEXT'),
                  elevation: 10,
                  onPressed: () {
                    if (_nameController.text.isNotEmpty &&
                        _priceController.text.isNotEmpty &&
                        _descriptionController.text.isNotEmpty) {
                      setState(() {
                        text = '';
                      });
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
                    }
                  },
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
