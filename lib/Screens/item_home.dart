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

/*Widget listView = 
  // ignore: non_constant_identifier_names
  static cardUI(
      String imgURL, String name, String description, String price) async {
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
                price,
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
*/
