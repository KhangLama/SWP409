import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:swp409/Clinic/Interface/home.dart';
import 'package:swp409/Components/default_button.dart';
import 'package:swp409/Interface/Home/mainScreen.dart';
import 'package:swp409/Models/user.dart';
import 'package:swp409/Services/ApiService/auth_service.dart';
import 'package:swp409/helper/keyboard.dart';
import '../../../../constants.dart';
import '../../../../size_config.dart';
import 'package:swp409/constants.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SignUpForm extends StatefulWidget {
  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final _formKey = GlobalKey<FormState>();
  // ignore: non_constant_identifier_names
  var name, phoneNumber, address, email, password, confirm_password, token;
  String internalIp;
  bool remember = false;
  final List<String> errors = [];
  String errorMsg;
  bool checkMailDup = false;

  final storage = new FlutterSecureStorage();
  User _user;

  final emailController = TextEditingController();
  final nameController = TextEditingController();
  final phoneController = TextEditingController();

  @override
  void initState() {
    super.initState();
    emailController.addListener(() => setState(() {}));
    nameController.addListener(() => setState(() {}));
    phoneController.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    emailController.dispose();
    nameController.dispose();
    phoneController.dispose();
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

    return Form(
      key: _formKey,
      child: Column(
        children: [
          buildEmailFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildPasswordFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildConfirmPassFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildFirstNameFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildPhoneNumberFormField(),
          // SizedBox(height: getProportionateScreenHeight(30)),
          // buildAddressFormField(),
          //FormError(errors: errors),
          SizedBox(height: getProportionateScreenHeight(40)),
          //SizedBox(height: SizeConfig.screenHeight * 0.08),
          DefaultButton(
              text: "Continue",
              press: () async {
                KeyboardUtil.hideKeyboard(context);
                String url = '$ServerIP/api/v1/users/signup';
                if (_formKey.currentState.validate()) {
                  authService
                      .signup(url, name, phoneNumber, email, password,
                          confirm_password)
                      .then((val) {
                    if (val.data['status'] == 'success') {
                      _user = new User.fromJson(val.data['data']['user']);
                      KeyboardUtil.hideKeyboard(context);
                      final cookies = val.headers.map['set-cookie'];
                      if (_user.role == 'patient') {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => MainScreen.user(
                                      user: _user,
                                      cookies: cookies,
                                    )));
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
                    }
                    if (val.statusCode == 400) {
                      List list = val.data['errors'] as List;
                      for (int i = 0; i < list.length; i++) {
                        if (list[i]['field'] == 'email') {
                          setState(() {
                            errorMsg = list[i]['message'];
                            checkMailDup = true;
                          });
                        }
                      }
                    }
                  });
                  // if all are valid then go to success screen
                }
              }),
        ],
      ),
    );
  }

  bool isVisbleConfirm = true;

  TextFormField buildConfirmPassFormField() {
    return TextFormField(
      obscureText: isVisbleConfirm,
      onSaved: (newValue) => confirm_password = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kPassNullError);
        } else if (value.isNotEmpty && password == confirm_password) {
          removeError(error: kMatchPassError);
        }
        confirm_password = value;
      },
      validator: (value) {
        if (value.isEmpty) {
          addError(error: kPassNullError);
          return kPassNullError;
        } else if ((password != value)) {
          addError(error: kMatchPassError);
          return kMatchPassError;
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Confirm Password",
        labelStyle: TextStyle(color: kPrimaryColor),
        hintText: "Re-enter your password",
        border: new OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(50)),
        ),
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
          icon: isVisbleConfirm
              ? Icon(Icons.visibility_off)
              : Icon(Icons.visibility),
          onPressed: () => setState(() => isVisbleConfirm = !isVisbleConfirm),
        ),
      ),
    );
  }

  bool isPasswordVisible = true;
  TextFormField buildPasswordFormField() {
    return TextFormField(
      obscureText: isPasswordVisible,
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
      keyboardType: TextInputType.emailAddress,
      onSaved: (newValue) => email = newValue,
      controller: emailController,
      onChanged: (value) {
        setState(() {
          checkMailDup = false;
          email = value;
        });

        if (value.isNotEmpty) {
          removeError(error: kEmailNullError);
        }
        if (emailValidatorRegExp.hasMatch(value)) {
          removeError(error: kInvalidEmailError);
        }

        email = value;
        return null;
      },
      validator: (value) {
        if (value.isEmpty) {
          addError(error: kEmailNullError);
          return kEmailNullError;
        }
        if (!emailValidatorRegExp.hasMatch(value)) {
          addError(error: kInvalidEmailError);
          return kInvalidEmailError;
        }

        return null;
      },
      decoration: InputDecoration(
        labelText: "Email",
        labelStyle: TextStyle(color: kPrimaryColor),
        hintText: "Enter your email",
        errorText: checkMailDup ? "Email already in use" : null,
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

  TextFormField buildAddressFormField() {
    return TextFormField(
      onSaved: (newValue) => address = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kAddressNullError);
        }
        address = value;
        return null;
      },
      validator: (value) {
        if (value.isEmpty) {
          addError(error: kAddressNullError);
          return kAddressNullError;
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Address",
        labelStyle: TextStyle(color: kPrimaryColor),
        hintText: "Enter your address",
        border: new OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(50)),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: kPrimaryColor),
          borderRadius: BorderRadius.all(Radius.circular(50)),
        ),
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        // suffixIcon:
        //     CustomSurffixIcon(svgIcon: "assets/icons/Location point.svg"),
        suffixIcon: Icon(
          Icons.location_on_outlined,
          size: 30,
          color: kPrimaryColor,
        ),
      ),
    );
  }

  TextFormField buildPhoneNumberFormField() {
    return TextFormField(
      controller: phoneController,
      keyboardType: TextInputType.phone,
      onSaved: (newValue) => phoneNumber = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kPhoneNumberNullError);
        }
        phoneNumber = value;
        return null;
      },
      validator: (value) {
        if (value.isEmpty) {
          addError(error: kPhoneNumberNullError);
          return kPhoneNumberNullError;
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Phone Number",
        labelStyle: TextStyle(color: kPrimaryColor),
        hintText: "Enter your phone number",
        border: new OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(50)),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: kPrimaryColor),
          borderRadius: BorderRadius.all(Radius.circular(50)),
        ),
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        //suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Phone.svg"),
        prefixIcon: Icon(
          Icons.phone,
          size: 30,
          color: kPrimaryColor,
        ),
        suffixIcon: phoneController.text.isEmpty
            ? Container(width: 0)
            : IconButton(
                icon: Icon(
                  Icons.close,
                  color: kPrimaryColor,
                ),
                onPressed: () => phoneController.clear(),
              ),
      ),
    );
  }

  TextFormField buildFirstNameFormField() {
    return TextFormField(
      controller: nameController,
      onSaved: (newValue) => name = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kNamelNullError);
        } else if (value.contains(' ') == true) {
          removeError(error: "Full name must at least 2 words");
        } else if (RegExp(r'[!@#<>?/{}":_`~;,.[\]\\|=+)(*&^%0-9-]')
            .hasMatch(value)) {
          removeError(error: "Full name is invalid");
        }
        name = value;
        return null;
      },
      validator: (value) {
        if (value.isEmpty) {
          addError(error: kNamelNullError);
          return kNamelNullError;
        }
        if (value.contains(' ') == false) {
          addError(error: "Full name must at least 2 words");
          return "Full name must at least 2 words";
        }
        if (RegExp(r'[!@#<>?/{}":_`~;,.[\]\\|=+)(*&^%0-9-]').hasMatch(value)) {
          addError(error: "Full name is invalid");
          print("checkkk");
          return "Full name is invalid";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Full Name",
        labelStyle: TextStyle(color: kPrimaryColor),
        hintText: "Enter your full name",
        border: new OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(50)),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: kPrimaryColor),
          borderRadius: BorderRadius.all(Radius.circular(50)),
        ),
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        //suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/User.svg"),
        prefixIcon: Icon(
          Icons.person_outline,
          size: 30,
          color: kPrimaryColor,
        ),
        suffixIcon: nameController.text.isEmpty
            ? Container(width: 0)
            : IconButton(
                icon: Icon(
                  Icons.close,
                  color: kPrimaryColor,
                ),
                onPressed: () => nameController.clear(),
              ),
      ),
    );
  }
}
