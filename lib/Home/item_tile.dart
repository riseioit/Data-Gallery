import 'package:auto_size_text/auto_size_text.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:practice_project/models/item.dart';
import 'package:practice_project/models/user.dart';
import 'package:provider/provider.dart';

class ItemTile extends StatelessWidget {
  final Item item;

  ItemTile({this.item});

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    final DatabaseReference itemImages =
        FirebaseDatabase.instance.reference().child(user.uid);

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
                  Divider(),
                  FlatButton(
                    child: Text(
                      'DELETE',
                      style: TextStyle(color: Colors.blue),
                    ),
                    onPressed: () async {
                      bool result = await buildAlertDialog(context);
                      if (result) {
                        StorageReference storageReference =
                            await FirebaseStorage.instance
                                .getReferenceFromUrl(item.imageURL);
                        print(storageReference.path);
                        await storageReference.delete();
                        print("image Deleted");
                        await itemImages.child(item.key).remove().then((_) {
                          print('Transaction commited.');
                          print(item.key);
                        });
                      }
                    },
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<bool> buildAlertDialog(BuildContext context) {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) => AlertDialog(
        elevation: 5,
        title: Text(
          "Delete",
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        content: AutoSizeText('Are you sure to delete this item ?'),
        actions: <Widget>[
          FlatButton(
            child: Text(
              'CANCEL',
              style: TextStyle(color: Colors.grey[800], letterSpacing: 1),
            ),
            onPressed: () {
              Navigator.pop(context, false);
            },
          ),
          FlatButton(
            child: Text(
              'DELETE',
              style: TextStyle(color: Colors.blue, letterSpacing: 1),
            ),
            onPressed: () {
              Navigator.pop(context, true);
            },
          ),
        ],
      ),
    );
  }
}
