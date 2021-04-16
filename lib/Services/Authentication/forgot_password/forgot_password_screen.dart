import 'package:flutter/material.dart';

import '../../../constants.dart';
import 'components/body.dart';

class ForgotPasswordScreen extends StatelessWidget {
  //static String routeName = "/forgot_password";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Forgot Password"),
        backgroundColor: kPrimaryColor,
      ),
      body: Body(),
    );
  }
}
