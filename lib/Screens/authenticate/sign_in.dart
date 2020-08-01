import 'package:flutter/material.dart';
import 'package:practice_project/Services/auth.dart';
import 'package:practice_project/Shared/constants.dart';
import 'package:practice_project/Shared/loading.dart';

class SignIn extends StatefulWidget {
  final Function toggleView;
  SignIn({this.toggleView});

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  String email = '';
  String password = '';
  String error = '';
  bool loading = false;

  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            backgroundColor: Colors.grey[400],
            appBar: AppBar(
              title: Text('Sign In'),
              elevation: 0.0,
              actions: <Widget>[
                FlatButton.icon(
                  icon: Icon(Icons.person),
                  label: Text('Register'),
                  onPressed: () {
                    widget.toggleView();
                  },
                ),
              ],
            ),
            body: Container(
              padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
              child: Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      decoration:
                          textInputDecoration.copyWith(hintText: 'Email'),
                      validator: (val) => val.isEmpty ? 'Enter an email' : null,
                      onChanged: (mail) {
                        setState(() {
                          email = mail;
                          error = '';
                        });
                      },
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    TextFormField(
                      decoration:
                          textInputDecoration.copyWith(hintText: 'Password'),
                      validator: (val) => val.length < 2
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
                      child: Text(
                        'Sign In',
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () async {
                        if (_formKey.currentState.validate()) {
                          setState(() => loading = true);
                          dynamic result = await _auth
                              .signInWithEmailAndPassword(email, password);
                          if (result == null) {
                            setState(() {
                              error =
                                  'coluld not sign in with those creadentials';
                              loading = false;
                            });
                          }
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          );
  }
}
