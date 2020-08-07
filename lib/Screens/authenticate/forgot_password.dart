import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:practice_project/Services/auth.dart';
import 'package:practice_project/Shared/constants.dart';

class ForgotPassword extends StatefulWidget {
  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  String email = '';

  final _formKey = GlobalKey<FormState>();
  final AuthService _auth = AuthService();
  @override
  Widget build(BuildContext context) {
    final _height = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text('Reset Password'),
        elevation: 0.0,
      ),
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("lib/assets/img3.jpg"), fit: BoxFit.cover)),
        padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              SizedBox(height: _height * 0.07),
              SizedBox(height: _height * 0.08),
              Text(
                'Reset Password',
                style: TextStyle(fontSize: 30, color: Colors.white),
              ),
              SizedBox(
                height: 40,
              ),
              TextFormField(
                decoration: textInputDecoration.copyWith(
                    hintText: 'Email', fillColor: Colors.white),
                validator: (val) => val.isEmpty ? 'Enter an email' : null,
                onChanged: (mail) {
                  setState(
                    () {
                      email = mail;
                    },
                  );
                },
              ),
              RaisedButton(
                color: Colors.pink[400],
                child: AutoSizeText(
                  'Submit',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () async {
                  if (_formKey.currentState.validate()) {
                    await _auth.sendPasswordResetEmail(email);
                  }
                  Navigator.pop(
                      context, 'A password reset link has been sent to $email');
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
