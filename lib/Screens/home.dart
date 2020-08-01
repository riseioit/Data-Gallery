import 'package:flutter/material.dart';
import 'package:practice_project/Home/item_tile.dart';
import 'package:practice_project/Screens/addItem.dart';
import 'package:practice_project/Screens/item_home.dart';
import 'package:practice_project/Services/auth.dart';
import 'package:practice_project/Services/database.dart';
import 'package:practice_project/models/item.dart';
import 'package:practice_project/models/user.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';

class CustomDrawer extends StatefulWidget {
  @override
  CustomDrawerState createState() => new CustomDrawerState();
}

class CustomDrawerState extends State<CustomDrawer>
    with SingleTickerProviderStateMixin {
  List<Item> list = [];
  //===========================================================================================
  //===========================================================================================

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 250),
    );
  }

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

  //===========================================================================================
  //===========================================================================================

  final AuthService _auth = AuthService();
  AnimationController _animationController;

  final double maxSlide = 225.0;
  var _canBeDragged;

  void _onDragStart(DragStartDetails details) {
    bool isDragOpenFromLeft =
        _animationController.isDismissed && details.globalPosition.dx < 50.0;
    bool isDragCloseFromRight =
        _animationController.isCompleted && details.globalPosition.dx > 150.0;

    _canBeDragged = isDragOpenFromLeft || isDragCloseFromRight;
  }

  void _onDragUpdate(DragUpdateDetails details) {
    if (_canBeDragged) {
      double delta = details.primaryDelta / maxSlide;
      _animationController.value += delta;
    }
  }

  void _onDragEnd(DragEndDetails details) {
    if (_animationController.isDismissed || _animationController.isCompleted) {
      return;
    }
    if (details.velocity.pixelsPerSecond.dx.abs() >= 365.0) {
      double visualVelocity = details.velocity.pixelsPerSecond.dx /
          MediaQuery.of(context).size.width;
      _animationController.fling(velocity: visualVelocity);
    } else if (_animationController.value < 0.5) {
      close();
    }
  }

  int close() {
    if (!_animationController.isDismissed) {
      _animationController.reverse();
    }
    return 1;
  }

  void toggle() => _animationController.isDismissed
      ? _animationController.forward()
      : _animationController.reverse();

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    getItemsFromDatabase(user.uid);
    var myDrawer = Scaffold(
      backgroundColor: Colors.blue[600],
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.fromLTRB(30, 80, 0, 0),
              child: Container(
                height: 100,
                width: 100,
                child: Text(
                  'Grocery Shop',
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(padding: EdgeInsets.only(left: 50)),
                FlatButton.icon(
                  icon: Icon(
                    Icons.home,
                    color: Colors.white,
                  ),
                  label: Text('Home'),
                  textColor: Colors.white,
                  onPressed: () {
                    setState(() {
                      _animationController.reverse();
                    });
                  },
                ),
                SizedBox(height: 12),
                FlatButton.icon(
                  icon: Icon(
                    Icons.add,
                    color: Colors.white,
                  ),
                  label: Text('Add Item'),
                  textColor: Colors.white,
                  onPressed: () {
                    setState(() {
                      _animationController.reverse();
                    });
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AddItem(),
                        ));
                  },
                ),
              ],
            )
          ],
        ),
      ),
    );
    var myChild = Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.menu),
          onPressed: toggle,
        ),
        title: Text('Home Page'),
        actions: <Widget>[
          FlatButton.icon(
            onPressed: () async {
              await _auth.SignOut();
            },
            icon: Icon(Icons.person),
            label: Text('logout'),
          ),
        ],
      ),
      body: list.length == 0 ? Container() : AllItems(list: list),
    );

    return GestureDetector(
      onHorizontalDragStart: _onDragStart,
      onHorizontalDragUpdate: _onDragUpdate,
      onHorizontalDragEnd: _onDragEnd,
      child: AnimatedBuilder(
        animation: _animationController,
        builder: (context, _) {
          double slide = maxSlide * _animationController.value;
          double scale = 1 - (_animationController.value * 0.3);
          return Stack(
            children: <Widget>[
              myDrawer,
              Transform(
                transform: Matrix4.identity()
                  ..translate(slide)
                  ..scale(scale),
                alignment: Alignment.centerLeft,
                child: myChild,
              )
            ],
          );
        },
      ),
    );
  }
}
