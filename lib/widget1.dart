import 'package:flutter/material.dart';

Widget titleSelection = Container(
  padding: const EdgeInsets.all(32),
  child: Row(
    children: [
      Expanded(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.only(bottom: 8),
              child: Text(
                "This is vaibhav gole",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Text(
              'this is second line',
              style: TextStyle(
                fontWeight: FontWeight.normal,
                color: Colors.grey[500],
              ),
            ),
          ],
        ),
      ),
      Text("41"),
    ],
  ),
);
