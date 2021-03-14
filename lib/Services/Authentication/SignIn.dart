import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:swp409/Interface/Home/mainScreen.dart';
import 'package:swp409/Models/User.dart';
import 'package:swp409/Services/Authentication/theme.dart';


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
  TextEditingController myController = new TextEditingController();
  List<User> userList;
  Future<void> readJson() async {
    final String response = await rootBundle.loadString('assets/json/user.json');
    final data = await json.decode(response);
    setState(() {
      userList = data["User"];
    });
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: theme(),
      home: Scaffold(

        backgroundColor: Colors.grey[200],
        appBar: AppBar(
          title: Text("Sign In"),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: SafeArea(
            child: Container(
              padding: EdgeInsets.all(40),
              child: Form(
                key: _formkey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(height: 30),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'Welcome Back',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 28,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'Sign in with your phone number \nor email',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                    SizedBox(height: 30),
                    TextFormField(
                      controller: myController,
                      keyboardType: TextInputType.phone,
                      validator: (value) => value.length < 10
                          ? "Please enter your phone number right"
                          : null,
                      decoration: InputDecoration(
                        hintText: 'Enter your phone or email',
                        icon: Icon(Icons.phone),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.all(30),
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
                        style: ButtonStyle(),
                        child: Text('Sign In'),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
