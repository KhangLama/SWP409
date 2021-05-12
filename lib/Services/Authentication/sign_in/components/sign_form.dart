import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:swp409/Components/default_button.dart';
import 'package:swp409/Components/form_error.dart';
import 'package:swp409/Interface/Home/mainScreen.dart';
import 'package:swp409/Models/user.dart';
import 'package:swp409/Services/Authentication/forgot_password/forgot_password_screen.dart';
import 'package:swp409/helper/keyboard.dart';
import '../../../../constants.dart';
import '../../../../size_config.dart';
import 'package:dio/dio.dart';
class SignForm extends StatefulWidget {
  @override
  _SignFormState createState() => _SignFormState();
}

class _SignFormState extends State<SignForm> {
  final _formKey = GlobalKey<FormState>();
  String email;
  String password;
  bool remember = false;
  int userID = 0;
  final List<String> errors = [];

  List<User> _users = <User>[];
  Future<List<User>> fetchUsers() async {
    var fetchdata = await rootBundle.loadString('assets/json/user.mock.json');
    var users = <User>[];
    var userjson = json.decode(fetchdata)['User'] as List;
    for (var user in userjson) {
      users.add(User.fromJson(user));
    }
    return users;
  }

  @override
  void initState() {
    fetchUsers().then((value) {
      setState(() {
        _users.addAll(value);
      });
    });
    super.initState();
  }

  void addError({String error}) {
    if (!errors.contains(error))
      setState(() {
        errors.add(error);
      });
  }

  void removeError({String error}) {
    if (errors.contains(error))
      setState(() {
        errors.remove(error);
      });
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          buildEmailFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildPasswordFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          Row(
            children: [
              Checkbox(
                value: remember,
                activeColor: kPrimaryColor,
                onChanged: (value) {
                  setState(() {
                    remember = value;
                  });
                },
              ),
              Text("Remember me"),
              Spacer(),
              GestureDetector(
                onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ForgotPasswordScreen())),
                child: Text(
                  "Forgot Password",
                  style: TextStyle(decoration: TextDecoration.underline),
                ),
              )
            ],
          ),
          FormError(errors: errors),
          SizedBox(height: getProportionateScreenHeight(20)),
          SizedBox(height: SizeConfig.screenHeight * 0.08),
          DefaultButton(
            text: "Continue",
            press: () {

              if (_formKey.currentState.validate()) {
                _formKey.currentState.save();
                // if all are valid then go to success screen
                KeyboardUtil.hideKeyboard(context);
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => MainScreen()));
              }
            },
          ),
        ],
      ),
    );
  }
  TextFormField buildEmailFormField() {
    return TextFormField(
      keyboardType: TextInputType.text,
      onSaved: (newValue) => email = newValue,
      onChanged: (value) {
        remember = false;
        if (value.isNotEmpty) {
          removeError(error: kUsernameNullError);
        } else {
          for (int i = 0; i < _users.length; i++) {
            if (value.compareTo(_users[i].email) == 0) {
              remember = true;
            }
          }
          if (remember == true) {
            //removeError(error: kUsernameValid);
          }
        }
        email = value;
        return null;
      },
      validator: (value) {
        remember = false;
        if (value.isEmpty) {
          addError(error: kUsernameNullError);
          return '';
        } else {
          for (int i = 0; i < _users.length; i++) {
            if (value.compareTo(_users[i].email) == 0) {
              remember = true;
            }
          }
          if (remember == false) {
            ////addError(error: kUsernameValid);
            return '';
          }
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Email",
        hintText: "Enter your email",
        border: new OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(50)),
        ),
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: kPrimaryColor),
          borderRadius: BorderRadius.all(Radius.circular(50)),
        ),
        //suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Mail.svg"),
        suffixIcon: Icon(
          Icons.mail_outline,
          size: 30,
        ),
      ),
    );
  }

  TextFormField buildPasswordFormField() {
    return TextFormField(
      obscureText: true,
      onSaved: (newValue) => password = newValue,
      onChanged: (value) {
        remember = false;
        if (value.isNotEmpty) {
          removeError(error: kPassNullError);
        } else {
          for (int i = 0; i < _users.length; i++) {
            if (email.compareTo(_users[i].email) == 0) {
              if (value.compareTo(_users[i].password) == 0)
                remember = true;
            }
          }
        }
        if (remember == true) {
          removeError(error: kPasswordValid);
        }
        return null;
      },
      validator: (value) {
        remember = false;
        if (value.isEmpty) {
          addError(error: kPassNullError);
          return '';
        } else {
          for (int i = 0; i < _users.length; i++) {
            if (email.compareTo(_users[i].email) == 0) {
              if (value.compareTo(_users[i].password) == 0)
                remember = true;
            }
          }
          if (remember == false) {
            addError(error: kPasswordValid);
            return '';
          }
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Password",
        hintText: "Enter your password",
        border: new OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(50)),
        ),
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: kPrimaryColor),
          borderRadius: BorderRadius.all(Radius.circular(50)),
        ),
        //suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Lock.svg"),
        suffixIcon: Icon(
          Icons.lock,
          size: 30,
        ),
      ),
    );
  }
}
