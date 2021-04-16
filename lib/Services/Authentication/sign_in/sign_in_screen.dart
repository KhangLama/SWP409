import 'package:flutter/material.dart';
import 'package:swp409/constants.dart';

import 'components/body.dart';

class SignInScreen extends StatelessWidget {
  //static String routeName = "/sign_in";
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
