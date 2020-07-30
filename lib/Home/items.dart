import 'package:flutter/material.dart';
import 'package:practice_project/models/item.dart';
import 'package:provider/provider.dart';
import '';

class ItemsList extends StatefulWidget {
  @override
  _ItemsListState createState() => _ItemsListState();
}

class _ItemsListState extends State<ItemsList> {
  @override
  Widget build(BuildContext context) {
    final items = Provider.of<List<Item>>(context);
    if (items != null) {
      items.forEach((element) {
        print(element.name);
        print(element.description);
        print(element.price);
      });
    }

    return Container();
  }
}
