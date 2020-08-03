import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class GenerateQR extends StatelessWidget {
  final String id;
  GenerateQR({this.id});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text('QR CODE'),
      ),
      body: Center(
        child: QrImage(
          data: id,
          version: QrVersions.auto,
          size: 200,
        ),
      ),
    );
  }
}
