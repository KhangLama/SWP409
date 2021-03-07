import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:swp409/main.dart';

import 'package:swp409/homePage.dart';

void buttonClick() {
  if (_phoneNumberValidator(sdt.text.toString()) == 1) {
    runApp(HomePage());
  } else {
    ;
  }
}

TextEditingController sdt = new TextEditingController();
int _phoneNumberValidator(String value) {
  Pattern pattern = r'(0)+([0-9]{9})\b';
  RegExp regex = new RegExp(pattern);
  if (!regex.hasMatch(value))
    return 0;
  else
    return 1;
}

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: backgroundColor,
        body: SafeArea(
          child: Container(
            padding: EdgeInsets.all(40),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(height: 30),
                Row(
                  children: <Widget>[
                    Text(
                      'Welcome Back,',
                      style: TextStyle(
                        fontSize: 24,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  children: <Widget>[
                    Text(
                      'Sign in to continue',
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                ),
                SizedBox(height: 30),
                TextFormField(
                  controller: sdt,
                  textAlignVertical: TextAlignVertical.center,
                  keyboardType: TextInputType.number,
                  maxLength: 10,
                  decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15.0)),
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15.0)),
                        borderSide: BorderSide(color: Colors.blue),
                      ),
                      hintText: 'Enter Your Phone Number',
                      fillColor: Colors.white,
                      filled: true,
                      prefixIcon: Icon(Icons.phone)),
                ),
                Container(
                  margin: EdgeInsets.all(30),
                  child: FlatButton(
                    onPressed: () => {buttonClick()},
                    color: buttonColor,
                    textColor: Colors.white,
                    child: Text('Log In'),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
