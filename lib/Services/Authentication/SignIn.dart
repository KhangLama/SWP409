import 'package:flutter/material.dart';
import 'package:swp409/main.dart';
import 'package:swp409/Interface/Home/mainScreen.dart';
import 'package:flutter_otp/flutter_otp.dart';


TextEditingController myController = new TextEditingController();

int _phoneNumberValidator(String value) {
  Pattern pattern = r'(0)+([0-9]{9})\b';
  RegExp regex = new RegExp(pattern);
  if (!regex.hasMatch(value))
    return 0;
  else
    return 1;
}

class SignInPage extends StatefulWidget {
  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  String _sdt = "";

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: backgroundColor,
        body: SafeArea(
          child: Container(
            padding: EdgeInsets.all(40),
            child: Form(
              key: _formkey,
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
                    controller: myController,
                    keyboardType: TextInputType.phone,
                    validator: (value) => value.length < 10 ? "Please enter your phone number right" : null,
                    decoration: InputDecoration(
                      hintText: 'Phone number',
                      icon: Icon(Icons.phone),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(30),
                    child: ElevatedButton(
                      onPressed: () => {
                        if(_formkey.currentState.validate()){
                          _formkey.currentState.save(),
                          print('duoc roi ' + myController.text),
                          runApp(MainScreen())
                        } else {
                          print('sai roi ')
                        }
                      },
                      style: ButtonStyle(
                      ),
                      child: Text('Log In'),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
