import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:practice_project/models/item.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

class DatabaseService {
  final String uid;
  DatabaseService({this.uid});
  static List<Item> list = [];

  // firebase Database
  final Future<FirebaseApp> app = FirebaseApp.configure(
    name: 'db',
    options: const FirebaseOptions(
      googleAppID: '1:194319437976:android:fd5b5374dc296f170c00ed',
      apiKey: 'AIzaSyCc8lU3M1SWg1TPHdqUliVlWHxXpbl_n6E',
      databaseURL: 'https://practice-project-c4605.firebaseio.com',
    ),
  );

  // collection reference
  final DatabaseReference itemImages =
      FirebaseDatabase.instance.reference().child('items');

  /* Future updateUserData(String name, String description, double price) async {
    return await itemImages
        .document(uid)
        .setData({'name': name, 'description': description, 'price': price});
  }*/

  // Item list from the snapshot

  void initState() {
    itemImages.once().then((DataSnapshot snapshot) {
      var keys = snapshot.value.keys;
      var values = snapshot.value;

      for (var key in keys) {
        Item item = new Item(
          name: values[key]['name'],
          description: values[key]['description'],
          price: values[key]['price'],
          imageURL: values[key]['imgURL'],
        );
        list.add(item);
      }
    });
  }

  Widget listView = ListView.builder(
    itemCount: list.length,
    itemBuilder: (_, index) {
      return CardUI(
        list[index].imageURL,
        list[index].name,
        list[index].description,
        list[index].price,
      );
    },
  );

  static Widget CardUI(
      String imgURL, String name, String description, double price) {
    return Card(
      margin: EdgeInsets.all(15.0),
      child: Container(
        color: Colors.white,
        margin: EdgeInsets.all(1.5),
        padding: EdgeInsets.all(10),
        child: Column(
          children: <Widget>[
            Image.network(imgURL),
            SizedBox(height: 2.0),
            Text(
              name,
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 25,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 2.0),
            Text("description : $description"),
            SizedBox(height: 2.0),
            Container(
              width: double.infinity,
              child: Text(
                price.toString(),
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 20,
                ),
              ),
            ),
            SizedBox(height: 2.0)
          ],
        ),
      ),
    );
  }

  // get user doc stream

}
