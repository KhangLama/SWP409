import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:swp409/Interface/Home/mainScreen.dart';
import 'package:swp409/Models/user.dart';

int _phoneNumberValidator(String value) {
  Pattern pattern = r'(0)+([0-9]{9})\b';
  var regex = RegExp(pattern);
  if (!regex.hasMatch(value)) {
    return 0;
  } else {
    return 1;
  }
}

class SignInPage extends StatefulWidget {
  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  TextEditingController myController = TextEditingController();
  List<User> userList;
  Future<void> readJson() async {
    final response = await rootBundle.loadString('assets/json/user.mock.json');
    final data = await json.decode(response);
    setState(() {
      userList = data['User'];
    });
  }

  @override
  Widget build(BuildContext context) {
    FocusNode myFocusNode;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('images/wallpaper.jpg'), fit: BoxFit.cover),
          ),
          child: Form(
            key: _formkey,
            child: Row(
              children: <Widget>[
                Expanded(
                    flex: 1,
                    child: Align(
                      alignment: Alignment.center,
                      child: Column(
                        children: [
                          Spacer(flex: 2),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                'Welcome Back',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 32,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          Spacer(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                'Sign in with your phone number \nor email',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 16, color: Colors.white),
                              ),
                            ],
                          ),
                          SizedBox(height: 20),
                          Container(
                            padding: EdgeInsets.only(right: 20, left: 20),
                            child: TextFormField(
                              style: TextStyle(color: Colors.white),
                              cursorColor: Colors.white,
                              controller: myController,
                              keyboardType: TextInputType.phone,
                              validator: (value) => value.length < 10
                                  ? 'Please enter your phone number right'
                                  : null,
                              decoration: InputDecoration(
                                  labelText: 'Phone/Email',
                                  labelStyle:
                                      TextStyle(color: Colors.lightGreen),
                                  hintText: 'Enter your phone or email',
                                  hintStyle: TextStyle(color: Colors.blueGrey),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(28),
                                    borderSide:
                                        BorderSide(color: Colors.greenAccent),
                                    gapPadding: 10,
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(28),
                                    borderSide: BorderSide(color: Colors.teal),
                                    gapPadding: 10,
                                  ),
                                  prefixIcon:
                                      Icon(Icons.phone, color: Colors.white),
                                  filled: true),
                            ),
                          ),
                          Spacer(flex: 1),
                          Container(
                            child: ElevatedButton(
                              onPressed: () => {
                                print(userList),
                                if (_formkey.currentState.validate())
                                  {
                                    _formkey.currentState.save(),
                                    print('duoc roi ' + myController.text),
                                    runApp(MainScreen())
                                  }
                                else
                                  {print('sai roi ')}
                              },
                              child: Text('Sign In'),
                            ),
                          ),
                          Spacer(flex: 3),
                        ],
                      ),
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
