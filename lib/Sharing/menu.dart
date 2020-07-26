import 'package:flutter/material.dart';
import 'package:practice_project/Services/database.dart';
import 'package:practice_project/main.dart';

Future addItem() async {
  await DatabaseService(uid: '1').updateUserData('2', 'Vaibhav', 3);
}

Future close;
TextStyle text = TextStyle(
  color: Colors.white,
  fontWeight: FontWeight.normal,
);
