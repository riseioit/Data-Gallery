import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:practice_project/Screens/item_home.dart';
import 'package:practice_project/models/item.dart';

class HomeQR extends StatefulWidget {
  final String id;
  HomeQR({this.id});
  @override
  _HomeQRState createState() => _HomeQRState();
}

class _HomeQRState extends State<HomeQR> {
  List<Item> list = [];

  void getItemsFromDatabase(String id) async {
    final DatabaseReference itemImages =
        FirebaseDatabase.instance.reference().child(id);

    await itemImages.once().then((DataSnapshot snapshot) {
      List<Item> l = [];
      var keys = snapshot.value.keys;
      var values = snapshot.value;
      for (var key in keys) {
        Item item = new Item(
          name: values[key]['name'],
          description: values[key]['description'],
          price: double.parse(values[key]['price'].toString()),
          imageURL: values[key]['imageURL'],
        );
        l.add(item);
      }
      setState(() {
        list = l;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    getItemsFromDatabase(widget.id);
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: list.length == 0
          ? Container(
              child: Center(
                child: Text('You have not uploaded any data'),
              ),
            )
          : AllItems(list: list),
    );
  }
}
