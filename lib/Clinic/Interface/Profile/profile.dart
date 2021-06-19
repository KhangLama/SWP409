import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:swp409/Components/default_button.dart';
import 'package:swp409/Models/clinic.dart';
import 'package:swp409/Services/ApiService/clinic_service.dart';
import 'dart:io';
import '../../../constants.dart';
import '../../../size_config.dart';

class ClinicProfile extends StatefulWidget {
  Clinic clinic;
  List<String> cookies;
  ClinicProfile({Key key, this.clinic, this.cookies}) : super(key: key);
  @override
  _ClinicProfileState createState() => _ClinicProfileState();
}

class _ClinicProfileState extends State<ClinicProfile> {
    final _formKey = GlobalKey<FormState>();
    final List<String> errors = [];
    String name;
    String mail;
    String phoneNumber;
    String address;
    String description;
    PickedFile _imageFile;
    final ImagePicker _picker = ImagePicker();
    List<String> _cookies;
    Clinic _clinic;
    String urlGetBooking = "$ServerIP/api/v1/bookings/booking-for-clinics";
    ClinicService _clinicService = new ClinicService();

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
    void initState() {
      // TODO: implement initState
      super.initState();
      setState(() {
        _clinic = widget.clinic;
        _cookies = widget.cookies;
      });
    }
    TextFormField buildDescriptionField() {
      return TextFormField(
        initialValue: _clinic.description,
        maxLines: 3,
        maxLength: 150,
        onSaved: (newValue) => description = newValue,
        onChanged: (value) {
          if (value.isNotEmpty) {
            removeError(error: kAddressNullError);
          }
          description = value;
          return null;
        },
        validator: (value) {
          if (value.isEmpty) {
            addError(error: kAddressNullError);
            return kAddressNullError;
          }
          description = value;
          return null;
        },
        decoration: InputDecoration(
          labelText: "Description",
          hintText: "Enter your description",
          labelStyle: TextStyle(color: kPrimaryColor),
          border: new OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(15)),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: kPrimaryColor),
            borderRadius: BorderRadius.all(Radius.circular(15)),
          ),
          floatingLabelBehavior: FloatingLabelBehavior.always,
          suffixIcon: Icon(
            Icons.description_outlined,
            size: 30,
            color: kPrimaryColor,
          ),
        ),
      );
    }

    TextFormField buildAddressField() {
      return TextFormField(
        initialValue: _clinic.address,
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
          labelText: "Address",
          labelStyle: TextStyle(
            color: kPrimaryColor,
          ),
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
            color: kPrimaryColor,
          ),
        ),
      );
    }

    TextFormField buildPhoneField() {
      return TextFormField(
        initialValue: _clinic.phone,
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
          labelStyle: TextStyle(
            color: kPrimaryColor,
          ),
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
            color: kPrimaryColor,
          ),
        ),
      );
    }

    TextFormField buildEmailField() {
      return TextFormField(
        readOnly: true,
        initialValue: _clinic.email,
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
          labelStyle: TextStyle(
            color: kPrimaryColor,
          ),
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
            color: kPrimaryColor,
          ),
        ),
      );
    }

    TextFormField buildNameField() {
      return TextFormField(
        initialValue: "",
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
          labelStyle: TextStyle(
            color: kPrimaryColor,
          ),
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
            color: kPrimaryColor,
          ),
        ),
      );
    }


    @override
    Widget build(BuildContext context) {
      return MaterialApp(
        home: Scaffold(
          appBar: AppBar(
            title: Text(
              'Home',
              style: TextStyle(color: kPrimaryLightColor),
            ),
            backgroundColor: kPrimaryAppbar,
            actions: <Widget>[
              IconButton(
                icon: Icon(
                  Icons.logout,
                  color: Colors.white,
                ),
                onPressed: () {
                  // do something
                },
              )
            ],
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
                      SizedBox(
                        height: 250,
                        width: 350,
                        child: Stack(
                          clipBehavior: Clip.none,
                          fit: StackFit.expand,
                          children: [
                            Image(
                              image: _imageFile == null
                                  ? AssetImage('images/0.jpg')
                                  : FileImage(File(_imageFile.path)),
                            ),
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
                            buildAddressField(),
                            SizedBox(height: getProportionateScreenHeight(30)),
                            buildDescriptionField(),
                            //FormError(errors: errors),
                            SizedBox(height: getProportionateScreenHeight(40)),
                            DefaultButton(
                              text: "Save change",
                              press: () {
                                if (_formKey.currentState.validate()) {
                                  // _userService
                                  //     .updateInfo(
                                  //         url, name, phoneNumber, address, _imageFile)
                                  //     .then((res) {
                                  //   print(res.data);
                                  //   KeyboardUtil.hideKeyboard(context);
                                  //   if (res.data['status'] == "success") {
                                  //     _user.name = name;
                                  //     _user.phone = phoneNumber;
                                  //     _user.address = address;
                                  //     _user.avatar = _imageFile;
                                  //     Navigator.push(
                                  //         context,
                                  //         MaterialPageRoute(
                                  //             builder: (context) =>
                                  //                 MainScreen.user(user: _user)));
                                  //   }
                                  // });
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
          ),
        ),
      );
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
