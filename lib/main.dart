import 'package:flutter/material.dart';
import 'package:practice_project/Screens/addItem.dart';

void main() {
  runApp(MaterialApp(
    initialRoute: '/',
    routes: {
      '/': (BuildContext context) => CustomDrawer(),
      '/addItem': (BuildContext context) => AddItem()
    },
  ));
}

class CustomDrawer extends StatefulWidget {
  @override
  CustomDrawerState createState() => new CustomDrawerState();
}

class CustomDrawerState extends State<CustomDrawer>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;

  final double maxSlide = 225.0;
  var _canBeDragged;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 250),
    );
  }

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
                    Navigator.pushNamed(context, '/addItem');
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
      ),
      body: Center(
        child: Text('Added Items will Display Here'),
      ),
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
