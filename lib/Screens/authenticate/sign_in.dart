import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:practice_project/Screens/authenticate/forgot_password.dart';
import 'package:practice_project/Screens/customer/scan_qr.dart';
import 'package:practice_project/Services/auth.dart';
import 'package:practice_project/Shared/constants.dart';
import 'package:practice_project/Shared/loading.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  String email = '';
  String password = '';
  String error = '';
  String _error;
  bool loading = false;

  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final _width = MediaQuery.of(context).size.width;
    final _height = MediaQuery.of(context).size.width;
    return loading
        ? Loading()
        : Scaffold(
            appBar: AppBar(
              title: Text('Sign In'),
              elevation: 0.0,
            ),
            body: Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("lib/assets/img3.jpg"),
                      fit: BoxFit.cover)),
              child: Column(
                children: <Widget>[
                  SizedBox(height: _height * 0.07),
                  showAlert(),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: <Widget>[
                          SizedBox(height: _height * 0.08),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'SIGN IN',
                              style:
                                  TextStyle(fontSize: 30, color: Colors.white),
                            ),
                          ),
                          SizedBox(
                            height: 40,
                          ),
                          TextFormField(
                            decoration: textInputDecoration.copyWith(
                                hintText: 'Email', fillColor: Colors.white),
                            validator: (val) =>
                                val.isEmpty ? 'Enter an email' : null,
                            onChanged: (mail) {
                              setState(
                                () {
                                  email = mail;
                                  error = '';
                                },
                              );
                            },
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          TextFormField(
                            decoration: textInputDecoration.copyWith(
                                hintText: 'Password', fillColor: Colors.white),
                            validator: (val) => val.length < 6
                                ? 'Enter the password 6+ chars long'
                                : null,
                            onChanged: (pass) {
                              setState(() => password = pass);
                            },
                            obscureText: true,
                          ),
                          SizedBox(height: 20),
                          RaisedButton(
                            color: Colors.pink[400],
                            child: AutoSizeText(
                              'Sign In',
                              style: TextStyle(color: Colors.white),
                            ),
                            onPressed: () async {
                              try {
                                if (_formKey.currentState.validate()) {
                                  setState(() => loading = true);
                                  dynamic result =
                                      await _auth.signInWithEmailAndPassword(
                                          email, password);
                                  if (result[1] == true) {
                                    setState(
                                      () {
                                        _error = result[0].message;
                                        // 'coluld not sign in with those creadentials';
                                        loading = false;
                                      },
                                    );
                                  }
                                }
                              } catch (e) {
                                print(e);
                                setState(() {
                                  _error = e.message;
                                });
                              }
                            },
                          ),
                          SizedBox(height: _height * 0.04),
                          FlatButton(
                            child: AutoSizeText(
                              'Forgot Password ?',
                              style: TextStyle(color: Colors.blue),
                            ),
                            onPressed: () async {
                              final messageFromFP = await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ForgotPassword(),
                                  ));
                              setState(() {
                                _error = messageFromFP;
                              });
                            },
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            resizeToAvoidBottomPadding: false,
            floatingActionButton: FloatingActionButton.extended(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ScanQR(),
                    ));
              },
              label: Text('Scan QR'),
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
          );
  }

  Widget showAlert() {
    if (_error != null) {
      return Container(
        color: Colors.amberAccent,
        width: double.infinity,
        padding: EdgeInsets.all(8.0),
        child: Row(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Icon(Icons.error_outline),
            ),
            Expanded(
              child: AutoSizeText(
                _error,
                maxLines: 3,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: IconButton(
                icon: Icon(Icons.close),
                onPressed: () {
                  setState(() {
                    _error = null;
                  });
                },
              ),
            )
          ],
        ),
      );
    }
    return SizedBox(height: 0.0);
  }
}
