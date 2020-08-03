import 'package:flutter/material.dart';
import 'package:practice_project/Home/item_tile.dart';
import 'package:practice_project/models/item.dart';

class AllItems extends StatefulWidget {
  List<Item> list;
  AllItems({this.list});
  @override
  _AllItemsState createState() => _AllItemsState();
}

class _AllItemsState extends State<AllItems> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.list.length,
      itemBuilder: (_, index) {
        return ItemTile(item: widget.list[index]);
      },
    );
  }
}

