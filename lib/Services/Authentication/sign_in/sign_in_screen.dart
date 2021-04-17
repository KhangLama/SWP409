import 'package:flutter/material.dart';
import 'package:swp409/constants.dart';

import 'components/body.dart';

class SignInScreen extends StatefulWidget {
  //static String routeName = "/sign_in";
  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: kPrimaryColor,
          title: Text("Sign In"),
        ),
        body: Body(),
    );
  }
}
