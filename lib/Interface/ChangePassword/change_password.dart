import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:swp409/Components/default_button.dart';
import 'package:swp409/Models/user.dart';
import '../../constants.dart';
import '../../size_config.dart';

// ignore: must_be_immutable
class ChangePasswordScreen extends StatefulWidget {
  final User user;
  ChangePasswordScreen.user({Key key, this.user}) : super(key: key);
  @override
  _ChangePasswordScreenState createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  User _user = new User();
  String currentPassword = '';
  String newPassword = '';
  String confirmNewPassword = '';
  bool isPasswordVisible = true;
  bool isNewPasswordVisible = true;
  bool isConfirmNewPasswordVisible = true;
  @override
  void initState() {
    setState(() {
      _user = widget.user;
      print(widget.user.toJson());
    });
    print(_user.toJson());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          leading: BackButton(
            onPressed: () => Navigator.pop(context),
          ),
          title: Text('Change Password'),
          centerTitle: true,
          backgroundColor: kPrimaryAppbar,
        ),
        body: SafeArea(
          child: SizedBox(
            width: double.infinity,
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: getProportionateScreenWidth(20)),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(height: SizeConfig.screenHeight * 0.02),
                    Text(
                      "Change Your Password",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: getProportionateScreenWidth(28),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 2),
                    Text(
                      "Fill in your password ",
                    ),
                    SizedBox(height: SizeConfig.screenHeight * 0.08),
                    buildCurrentPassword(),
                    SizedBox(height: SizeConfig.screenHeight * 0.04),
                    buildNewPassword(),
                    SizedBox(height: SizeConfig.screenHeight * 0.04),
                    buildConfirmNewPassword(),
                    SizedBox(height: SizeConfig.screenHeight * 0.08),
                    DefaultButton(
                        text: "Continue",
                        press: () {
                        }),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  TextField buildCurrentPassword() {
    return TextField(
      onChanged: (value) => setState(() => currentPassword = value),
      onSubmitted: (value) => setState(() => currentPassword = value),
      decoration: InputDecoration(
        hintText: 'Enter current password',
        labelText: 'Current Password',
        labelStyle: TextStyle(color: Colors.black54),
        suffixIcon: IconButton(
          color: kPrimaryColor,
          icon: isPasswordVisible
              ? Icon(Icons.visibility_off)
              : Icon(Icons.visibility),
          onPressed: () =>
              setState(() => isPasswordVisible = !isPasswordVisible),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(50),
          borderSide: BorderSide(color: kPrimaryColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: kPrimaryColor),
          borderRadius: BorderRadius.all(Radius.circular(50)),
        ),
      ),
      obscureText: isPasswordVisible,
    );
  }

  TextField buildNewPassword() {
    return TextField(
      onChanged: (value) => setState(() => newPassword = value),
      onSubmitted: (value) => setState(() => newPassword = value),
      decoration: InputDecoration(
        hintText: 'Enter new password',
        labelText: 'New Password',
        labelStyle: TextStyle(color: Colors.black54),
        suffixIcon: IconButton(
          color: kPrimaryColor,
          icon: isNewPasswordVisible
              ? Icon(Icons.visibility_off)
              : Icon(Icons.visibility),
          onPressed: () =>
              setState(() => isNewPasswordVisible = !isNewPasswordVisible),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(50),
          borderSide: BorderSide(color: kPrimaryColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: kPrimaryColor),
          borderRadius: BorderRadius.all(Radius.circular(50)),
        ),
      ),
      obscureText: isNewPasswordVisible,
    );
  }

  TextField buildConfirmNewPassword() {
    return TextField(
      onChanged: (value) => setState(() => confirmNewPassword = value),
      onSubmitted: (value) => setState(() => confirmNewPassword = value),
      decoration: InputDecoration(
        hintText: 'Confirm new password',
        labelText: 'Confirm new Password',
        labelStyle: TextStyle(color: Colors.black54),
        suffixIcon: IconButton(
          color: kPrimaryColor,
          icon: isConfirmNewPasswordVisible
              ? Icon(Icons.visibility_off)
              : Icon(Icons.visibility),
          onPressed: () => setState(
              () => isConfirmNewPasswordVisible = !isConfirmNewPasswordVisible),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(50),
          borderSide: BorderSide(color: kPrimaryColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: kPrimaryColor),
          borderRadius: BorderRadius.all(Radius.circular(50)),
        ),
      ),
      obscureText: isConfirmNewPasswordVisible,
    );
  }
}
