import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:swp409/Clinic/Interface/home.dart';
import 'package:swp409/Components/default_button.dart';
import 'package:swp409/Components/form_error.dart';
import 'package:swp409/Interface/Home/mainScreen.dart';
import 'package:swp409/Services/ApiService/auth_service.dart';
import 'package:swp409/Services/Authentication/forgot_password/forgot_password_screen.dart';
import 'package:swp409/helper/keyboard.dart';
import '../../../../constants.dart';
import '../../../../size_config.dart';
import 'package:swp409/constants.dart';
import 'package:swp409/Models/user.dart';

class SignForm extends StatefulWidget {
  @override
  _SignFormState createState() => _SignFormState();
}

class _SignFormState extends State<SignForm> {
  final _formKey = GlobalKey<FormState>();
  var email, password;
  bool remember = false;
  //int userID = 0;
  final List<String> errors = [];
  bool loading = false;
  User _user = new User();
  final emailController = TextEditingController();
  bool isPasswordVisible = true;

  @override
  void initState() {
    super.initState();
    emailController.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
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
    AuthService authService = new AuthService();
    return ModalProgressHUD(
      inAsyncCall: loading,
      opacity: 0.9,
      color: Colors.blue,
      progressIndicator: CircularProgressIndicator(),
      child: Container(
        child: Form(
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
                press: () async {
                  KeyboardUtil.hideKeyboard(context);
                  String url = '$ServerIP/api/v1/users/login';
                  if (_formKey.currentState.validate()) {
                    print(url);
                    print("${email} ${password}");
                    authService.login(url, email, password).then((val) async {
                      if (val.data['status'] == "success") {
                        _user = new User.fromJson(val.data['data']['user']);
                        KeyboardUtil.hideKeyboard(context);
                        final cookies = val.headers.map['set-cookie'];
                        if (_user.role == 'patient') {
                          Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      MainScreen.user(
                                          user: _user, cookies: cookies)));
                        }
                        if (_user.role == 'doctor') {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => HomeScreenDoctor.user(
                                        user: _user,
                                        cookies: cookies,
                                      )));
                        }
                        removeError(error: "Incorrect email or password");
                      } else if (val.data["status"] == "fail") {
                        addError(error: "Incorrect email or password");
                      }
                    });
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  TextFormField buildPasswordFormField() {
    return TextFormField(
      obscureText: isPasswordVisible,
      onSaved: (value) {
        setState(() {
          password = value;
        });
      },
      onChanged: (value) {
        setState(() {
          password = value;
        });
      },
      decoration: InputDecoration(
        labelText: "Password",
        labelStyle: TextStyle(color: kPrimaryColor),
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
        prefixIcon: Icon(
          Icons.lock,
          size: 30,
          color: kPrimaryColor,
        ),
        suffixIcon: IconButton(
          color: kPrimaryColor,
          icon: isPasswordVisible
              ? Icon(Icons.visibility_off)
              : Icon(Icons.visibility),
          onPressed: () =>
              setState(() => isPasswordVisible = !isPasswordVisible),
        ),
      ),
    );
  }

  TextFormField buildEmailFormField() {
    return TextFormField(
      controller: emailController,
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
        labelText: "Email",
        hintText: "Enter your email",
        labelStyle: TextStyle(color: kPrimaryColor),
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
        prefixIcon: Icon(
          Icons.mail_outline,
          size: 30,
          color: kPrimaryColor,
        ),
        suffixIcon: emailController.text.isEmpty
            ? Container(width: 0)
            : IconButton(
                icon: Icon(
                  Icons.close,
                  color: kPrimaryColor,
                ),
                onPressed: () => emailController.clear(),
              ),
      ),
    );
  }
}
