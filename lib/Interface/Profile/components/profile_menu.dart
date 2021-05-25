import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:swp409/Components/default_button.dart';
import 'package:swp409/Interface/Home/mainScreen.dart';
import 'package:swp409/Models/user.dart';
import '../../../constants.dart';
import '../../../size_config.dart';

// ignore: must_be_immutable
class CompleteProfileForm extends StatefulWidget {
  FlutterSecureStorage storage;
  CompleteProfileForm(this.storage);

  @override
  _CompleteProfileFormState createState() => _CompleteProfileFormState();
}

class _CompleteProfileFormState extends State<CompleteProfileForm> {
  final _formKey = GlobalKey<FormState>();
  final List<String> errors = [];
  final storage = new FlutterSecureStorage();
  String name;
  String mail;
  String phoneNumber;
  String address;
  Dio dio = new Dio();
  Response _response;
  String url = '$ServerIP/api/v1/users/';
  User _user = new User();

  Future<User> getUserData(FlutterSecureStorage storage) async {
    var _id = await storage.read(key: 'userid');
    User u = new User();
    _response = await dio.get('$url$_id');
    print(_response.data);
    u.role = _response.data['data']['data']['role'];
    u.sId = _response.data['data']['data']['_id'];
    u.email = _response.data['data']['data']['email'];
    u.name = _response.data['data']['data']['name'];
    print(u.email);
    print(u.name);
    return u;
  }

  @override
  void initState() {
    super.initState();
    getUserData(widget.storage).then((value) {
      _user = value;
      print("1" + _user.name);
    });
    print('cehck');
    print(_user.name);
    print(_user.email);
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
          buildFirstNameFormField(context),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildEmailFormField(context),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildPhoneNumberFormField(context),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildAddressFormField(context),
          //FormError(errors: errors),
          SizedBox(height: getProportionateScreenHeight(40)),
          DefaultButton(
            text: "Save change",
            press: () {
              if (_formKey.currentState.validate()) {
                //Navigator.pop(context);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => MainScreen(storage)));
                // Navigator.pushReplacement(
                //     context,
                //     MaterialPageRoute(
                //         builder: (BuildContext context) => ProfilePage()));
              }
            },
          ),
        ],
      ),
    );
  }

  TextFormField buildAddressFormField(BuildContext context) {
    return TextFormField(
      initialValue: "79 Nguyen Van Cu noi dai, Ninh Kieu, Can Tho",
      onSaved: (newValue) => address = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kAddressNullError);
        }
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
        hintText: "Enter your address",
        border: new OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(15)),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: kPrimaryColor),
          borderRadius: BorderRadius.all(Radius.circular(15)),
        ),
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        // suffixIcon:
        //     CustomSurffixIcon(svgIcon: "assets/icons/Location point.svg"),
        suffixIcon: Icon(
          Icons.location_on_outlined,
          size: 30,
        ),
      ),
    );
  }

  TextFormField buildPhoneNumberFormField(BuildContext context) {
    return TextFormField(
      initialValue: "0987654321",
      keyboardType: TextInputType.phone,
      onSaved: (newValue) => phoneNumber = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kPhoneNumberNullError);
        }
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
        hintText: "Enter your phone number",
        border: new OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(15)),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: kPrimaryColor),
          borderRadius: BorderRadius.all(Radius.circular(15)),
        ),
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        //suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Phone.svg"),
        suffixIcon: Icon(
          Icons.phone,
          size: 30,
        ),
      ),
    );
  }

  TextFormField buildEmailFormField(BuildContext context) {
    return TextFormField(
      initialValue: "${_user.email}",
      onSaved: (newValue) => mail = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kEmailNullError);
        } else if (emailValidatorRegExp.hasMatch(value)) {
          removeError(error: kInvalidEmailError);
        }
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
        border: new OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(15)),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: kPrimaryColor),
          borderRadius: BorderRadius.all(Radius.circular(15)),
        ),
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        //suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/User.svg"),
        suffixIcon: Icon(
          Icons.mail_outline,
          size: 30,
        ),
      ),
    );
  }

  TextFormField buildFirstNameFormField(BuildContext context) {
    return TextFormField(
      initialValue: "${_user.name}",
      onSaved: (newValue) => name = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kNamelNullError);
        }
        return null;
      },
      validator: (value) {
        if (value.isEmpty) {
          addError(error: kNamelNullError);
          return kNamelNullError;
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Full Name",
        hintText: "Enter your name",
        border: new OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(15)),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: kPrimaryColor),
          borderRadius: BorderRadius.all(Radius.circular(15)),
        ),
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        //suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/User.svg"),
        suffixIcon: Icon(
          Icons.person_outline,
          size: 30,
        ),
      ),
    );
  }
}
