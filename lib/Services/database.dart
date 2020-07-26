import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';

class DatabaseService {
  final String uid;
  DatabaseService({this.uid});
  // collection reference
  final CollectionReference itemImages = Firestore.instance.collection('Items');

  Future updateUserData(
      String name, String description, double price, Image image) async {
    await itemImages
        .document(uid)
        .setData({'sugars': sugars, 'name': name, 'strength': strength});
  }
}
