import 'package:flutter/material.dart';
import 'package:practice_project/Screens/customer/cus_item_tile.dart';
import 'package:practice_project/models/item.dart';

class CustomerAllItems extends StatefulWidget {
  List<Item> list;
  CustomerAllItems({this.list});
  @override
  _CustomerAllItemsState createState() => _CustomerAllItemsState();
}

class _CustomerAllItemsState extends State<CustomerAllItems> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.list.length,
      itemBuilder: (_, index) {
        return CustomerItemTile(item: widget.list[index]);
      },
    );
  }
}
