import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:swp409/Components/default_button.dart';
import 'package:swp409/Interface/Home/mainScreen.dart';
import 'package:swp409/Models/user.dart';
import 'package:swp409/Services/ApiService/user_service.dart';
import 'package:swp409/helper/keyboard.dart';
import '../../../constants.dart';
import '../../../size_config.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

// ignore: must_be_immutable
class Body extends StatefulWidget {
  User user;
  List<String> cookies;
  Body.user({Key key, this.user, this.cookies}) : super(key: key);
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final _formKey = GlobalKey<FormState>();
  final List<String> errors = [];
  String name;
  String mail;
  String phoneNumber;
  String address;
  PickedFile _imageFile;
  final ImagePicker _picker = ImagePicker();
  User _user = new User();
  UserService _userService = new UserService();
  TextEditingController fieldNameController = new TextEditingController();
  bool loading = true;
  List<String> cookies;

  @override
  void initState() {
    _user = widget.user;
    cookies = widget.cookies;

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

  TextFormField buildAddressField() {
    return TextFormField(
      initialValue: "",
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
        address = value;
        return null;
      },
      decoration: InputDecoration(
        labelText: "address",
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

  TextFormField buildPhoneField() {
    return TextFormField(
      initialValue: _user.phone ?? "",
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
        phoneNumber = value;
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

  TextFormField buildEmailField() {
    return TextFormField(
      initialValue: _user.email ?? "",
      readOnly: true,
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

  TextFormField buildNameField() {
    return TextFormField(
      initialValue: _user.name ?? "",
      onSaved: (newValue) => name = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kNamelNullError);
        }
        name = value;
        return null;
      },
      validator: (value) {
        if (value.isEmpty) {
          addError(error: kNamelNullError);
          return kNamelNullError;
        }
        name = value;
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

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        width: double.infinity,
        child: Padding(
          padding:
              EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: SizeConfig.screenHeight * 0.02),
                SizedBox(
                  height: 220,
                  width: 220,
                  child: Stack(
                    clipBehavior: Clip.none,
                    fit: StackFit.expand,
                    children: [
                      CircleAvatar(
                          backgroundImage: _imageFile == null
                              ? NetworkImage(_user.avatar.url)
                              : FileImage(File(_imageFile.path))),
                      Positioned(
                        right: 25,
                        bottom: 0,
                        child: SizedBox(
                          height: 45,
                          width: 45,
                          // ignore: deprecated_member_use
                          child: FlatButton(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50),
                              side: BorderSide(color: Color(0xFFDFDFE3)),
                            ),
                            padding: EdgeInsets.all(10.0),
                            child: Column(
                              // Replace with a Row for horizontal icon + text
                              children: <Widget>[
                                Icon(Icons.camera_alt),
                              ],
                            ),
                            color: Color(0xFFDFDFE3),
                            onPressed: () {
                              showModalBottomSheet(
                                  context: context,
                                  builder: ((builder) => bottomSheet()));
                            },
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(height: SizeConfig.screenHeight * 0.03),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      buildNameField(),
                      SizedBox(height: getProportionateScreenHeight(30)),
                      buildEmailField(),
                      SizedBox(height: getProportionateScreenHeight(30)),
                      buildPhoneField(),
                      SizedBox(height: getProportionateScreenHeight(30)),
                      //FormError(errors: errors),
                      SizedBox(height: getProportionateScreenHeight(40)),
                      DefaultButton(
                        text: "Save change",
                        press: () {
                          String url = '$ServerIP/api/v1/users/${_user.sId}';
                          if (_formKey.currentState.validate()) {
                            _userService
                                .updateInfo(url, name, phoneNumber, address,
                                    _imageFile, _user.email, cookies)
                                .then((res) {
                              KeyboardUtil.hideKeyboard(context);
                              if (res.data['status'] == "success") {
                                _user =
                                    new User.fromJson(res.data['data']['data']);
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => MainScreen.user(
                                            user: _user, cookies: cookies)));
                              }
                            });
                          }
                        },
                      ),
                    ],
                  ),
                ),
                SizedBox(height: getProportionateScreenHeight(30)),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<String> getToken(FlutterSecureStorage _st) async {
    return await _st.read(key: 'token');
  }

  void takePhoto(ImageSource source) async {
    final pickedFile = await _picker.getImage(source: source);
    setState(() {
      _imageFile = pickedFile;
    });
  }

  Widget bottomSheet() {
    return Container(
      height: 100.0,
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 20,
      ),
      child: Column(
        children: <Widget>[
          Text(
            'Choose Profile Photo',
            style: TextStyle(fontSize: 20.0),
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              // ignore: deprecated_member_use
              FlatButton.icon(
                  onPressed: () {
                    takePhoto(ImageSource.camera);
                  },
                  icon: Icon(Icons.camera),
                  label: Text('Camera')),
              // ignore: deprecated_member_use
              FlatButton.icon(
                  onPressed: () {
                    takePhoto(ImageSource.gallery);
                  },
                  icon: Icon(Icons.image),
                  label: Text('Gallery')),
            ],
          )
        ],
      ),
    );
  }
}
