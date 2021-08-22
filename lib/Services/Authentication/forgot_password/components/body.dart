import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:swp409/Components/default_button.dart';
import 'package:swp409/Components/no_account_text.dart';
import 'package:swp409/Services/ApiService/auth_service.dart';
import 'package:swp409/Services/Authentication/sign_in/sign_in_screen.dart';

import '../../../../constants.dart';
import '../../../../size_config.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: SingleChildScrollView(
        child: Padding(
          padding:
              EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
          child: Column(
            children: [
              SizedBox(height: SizeConfig.screenHeight * 0.04),
              Text(
                "Forgot Password",
                style: TextStyle(
                  fontSize: getProportionateScreenWidth(28),
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "Please enter your email and we will send \nyou a link to return to your account",
                textAlign: TextAlign.center,
              ),
              SizedBox(height: SizeConfig.screenHeight * 0.1),
              ForgotPassForm(),
            ],
          ),
        ),
      ),
    );
  }
}

class ForgotPassForm extends StatefulWidget {
  @override
  _ForgotPassFormState createState() => _ForgotPassFormState();
}

class _ForgotPassFormState extends State<ForgotPassForm> {
  final _formKey = GlobalKey<FormState>();
  AuthService _authService = new AuthService();
  String email = "";
  bool checkEmail = true;
  String err = "";
  Future<bool> toast(String message) {
    Fluttertoast.cancel();
    return Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 2,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 22.0);
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            keyboardType: TextInputType.emailAddress,
            onSaved: (value) {
              setState(() {
                email = value;
              });
            },
            onChanged: (value) {
              setState(() {
                email = value;
              });
            },
            decoration: InputDecoration(
              errorText: checkEmail ? err : "",
              labelText: "Email",
              labelStyle: TextStyle(color: kPrimaryColor),
              hintText: "Enter your email",
              // If  you are using latest version of flutter then lable text and hint text shown like this
              // if you r using flutter less then 1.20.* then maybe this is not working properly
              floatingLabelBehavior: FloatingLabelBehavior.always,
              border: new OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(50)),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: kPrimaryColor),
                borderRadius: BorderRadius.all(Radius.circular(50)),
              ),
              suffixIcon: Icon(
                Icons.email_outlined,
                size: 30,
                color: kPrimaryColor,
              ),
            ),
          ),
          SizedBox(height: getProportionateScreenHeight(30)),
          SizedBox(height: SizeConfig.screenHeight * 0.1),
          DefaultButton(
            text: "Continue",
            press: () {
              if (!emailValidatorRegExp.hasMatch(email)) {
                setState(() {
                  err = "Email is not valid";
                  checkEmail = true;
                });
              } else {
                String url = "$ServerIP/api/v1/users/forgotPassword";
                setState(() {
                  checkEmail = false;
                  _authService.forgotPassword(url, email).then((value) {
                    if (value.data['message'] ==
                        "There is no user with email address.") {
                      setState(() {
                        err = "There is no user with email address";
                        checkEmail = true;
                      });
                    } else if (value.data['status'] == "success") {
                      toast(
                          "Successfully!! Please check mail to reset password");
                    }
                  });
                });
              }
            },
          ),
          SizedBox(height: SizeConfig.screenHeight * 0.1),
          NoAccountText(),
        ],
      ),
    );
  }
}
