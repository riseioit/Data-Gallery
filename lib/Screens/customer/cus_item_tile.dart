import 'package:flutter/material.dart';
import 'package:practice_project/models/item.dart';

class CustomerItemTile extends StatelessWidget {
  final Item item;

  CustomerItemTile({this.item});

  @override
  Widget build(BuildContext context) {
    final _width = MediaQuery.of(context).size.width;
    final _height = MediaQuery.of(context).size.height;
    return Padding(
      padding: EdgeInsets.only(top: 8.0),
      child: Card(
        elevation: 5.0,
        margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            AspectRatio(
              aspectRatio: 11 / 10,
              child: Image.network(item.imageURL),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(25.0, 12.0, 16.0, 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    item.name,
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.w700),
                  ),
                  SizedBox(height: 8),
                  Text(
                    item.description,
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w300),
                  ),
                  SizedBox(height: 8),
                  Text(
                    "Price: " + item.price.toString(),
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w300),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
