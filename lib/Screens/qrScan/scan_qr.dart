import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:practice_project/Screens/qrScan/qr_home.dart';

class ScanQR extends StatefulWidget {
  @override
  _ScanQRState createState() => _ScanQRState();
}

class _ScanQRState extends State<ScanQR> {
  ScanResult _barcode;
  bool _qrScanned = false;

  @override
  Widget build(BuildContext context) {
    return _qrScanned
        ? HomeQR(
            id: _barcode.rawContent.toString(),
          )
        : Scaffold(
            appBar: AppBar(
              leading: IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () => Navigator.pop(context),
              ),
              title: Text('Scan QR'),
            ),
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: RaisedButton(
                      color: Colors.blue,
                      textColor: Colors.white,
                      splashColor: Colors.blueGrey,
                      onPressed: scan,
                      child: Text('START CAMERA SCAN'),
                    ),
                  ),
                  if (_barcode != null)
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      child: Text(
                        _barcode.rawContent ?? '',
                        textAlign: TextAlign.center,
                      ),
                    )
                ],
              ),
            ),
          );
  }

  Future scan() async {
    try {
      ScanResult barcode = await BarcodeScanner.scan();
      setState(() {
        this._barcode = barcode;
        this._qrScanned = true;
      });
    } on PlatformException catch (e) {
      if (e.code == BarcodeScanner.cameraAccessDenied) {
        setState(() {
          this._barcode.rawContent = 'The user did not the camera permission';
          this._qrScanned = false;
        });
      } else {
        setState(() {
          this._barcode.rawContent = 'Unknown error $e';
          this._qrScanned = false;
        });
      }
    } on FormatException {
      setState(() {
        this._barcode.rawContent =
            'null (User returned using the "back" button before scanning anything. Result';
        this._qrScanned = false;
      });
    } catch (e) {
      setState(() {
        this._barcode.rawContent = 'Unknown exception $e';
        this._qrScanned = false;
      });
    }
  }
}
