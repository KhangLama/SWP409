import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
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
  var email, password, token;
  bool remember = false;
  //int userID = 0;
  final List<String> errors = [];
  final storage = new FlutterSecureStorage();
  bool loading = false;
  User _user = new User();

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
                  String url = '$ServerIP/api/v1/users/login';
                  if (_formKey.currentState.validate()) {
                    authService.login(url, email, password).then((val) async {
                      print(val.data);
                      if (val.data["status"] == "success") {
                        var sId = val.data['data']['user']['_id'];
                        var name = val.data['data']['user']['name'];
                        var role = val.data['data']['user']['role'];
                        var phone = val.data['data']['user']['phone'];
                        var email = val.data['data']['user']['email'];
                        var filename =
                            val.data['data']['user']['avatar']['filename'];
                        var url = val.data['data']['user']['avatar']['url'];
                        await storage.write(
                            key: 'token', value: val.data['token']);
                        _user = new User(
                            sId: sId,
                            email: email,
                            name: name,
                            role: role,
                            phone: phone,
                            avatar: new Avatar(filename: filename, url: url));
                        KeyboardUtil.hideKeyboard(context);
                        print('token');
                        print(token);
                        print('token 2');
                        print(await storage.read(key: 'token'));
                        token = await storage.read(key: 'token');
                        if (_user.role == 'patient') {
                          Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      MainScreen.user(
                                          user: _user, token: token)));
                        }
                        if (_user.role == 'doctor') {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      HomeScreenDoctor.user(user: _user)));
                        }
                      } else if (val.data["status"] == "error") {
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
      obscureText: true,
      onSaved: (newValue) => password = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kPassNullError);
        } else if (value.length != 8) {
          removeError(error: kShortPassError);
        }
        password = value;
      },
      validator: (value) {
        if (value.isEmpty) {
          addError(error: kPassNullError);
          return kPassNullError;
        } else if (value.length < 8) {
          addError(error: kShortPassError);
          return kShortPassError;
        }
        return null;
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
        suffixIcon: Icon(
          Icons.lock,
          size: 30,
          color: kPrimaryColor,
        ),
      ),
    );
  }

  TextFormField buildEmailFormField() {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      onSaved: (newValue) => email = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kEmailNullError);
        } else if (emailValidatorRegExp.hasMatch(value)) {
          removeError(error: kInvalidEmailError);
        }
        email = value;
        return null;
      },
      validator: (value) {
        if (value.isEmpty) {
          addError(error: kEmailNullError);
          return kEmailNullError;
        } else if (!emailValidatorRegExp.hasMatch(value)) {
          addError(error: kInvalidEmailError);
          return kInvalidEmailError;
        }
        return null;
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
        suffixIcon: Icon(
          Icons.mail_outline,
          size: 30,
          color: kPrimaryColor,
        ),
      ),
    );
  }
}
