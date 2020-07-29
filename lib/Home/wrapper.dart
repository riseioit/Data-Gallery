import 'package:flutter/material.dart';
import 'package:practice_project/Screens/authenticate/authenticate.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Return either home or authenticate widget
    return Authenticate();
  }
}
