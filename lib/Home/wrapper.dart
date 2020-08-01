import 'package:flutter/material.dart';
import 'package:practice_project/Screens/authenticate/authenticate.dart';
import 'package:practice_project/Screens/home.dart';
import 'package:practice_project/models/user.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    print(user);
    // Return either home or authenticate widget
    if (user == null) {
      return Authenticate();
    } else {
      return CustomDrawer();
    }
  }
}
