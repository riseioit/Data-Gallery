import 'package:flutter/material.dart';
import 'package:practice_project/models/item.dart';

class ItemTile extends StatelessWidget {
  final Item item;

  ItemTile({this.item});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 8.0),
      child: Card(
        elevation: 5.0,
        margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Image.network(item.imageURL),
            Expanded(
              child: Padding(
                padding: EdgeInsets.fromLTRB(16.0, 12.0, 16.0, 8.0),
                child: Column(
                  // TODO Allign labels to the bottom and centre (103)
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      item.name.toUpperCase(),
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                      maxLines: 1,
                    ),
                    SizedBox(height: 8.0),
                    Text(
                      item.description,
                      style: TextStyle(
                          fontSize: 13, fontWeight: FontWeight.normal),
                    ),
                    SizedBox(height: 8.0),
                    Text(item.price.toString())
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
