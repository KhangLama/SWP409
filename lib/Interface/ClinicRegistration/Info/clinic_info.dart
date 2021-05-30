import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:swp409/Components/default_button.dart';
import 'package:swp409/Interface/ClinicRegistration/Location/clinic_location.dart';
import 'package:swp409/Services/ApiService/auth_service.dart';
import 'package:swp409/Services/ApiService/clinic_service.dart';

import '../../../constants.dart';
import '../../../size_config.dart';

class ClinicInfoScreen extends StatefulWidget {
  @override
  _ClinicInfoScreenState createState() => _ClinicInfoScreenState();
}

class _ClinicInfoScreenState extends State<ClinicInfoScreen> {
  final emailController = TextEditingController();
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final descriptionController = TextEditingController();
  String errorEmail = "";
  String errorName = "";
  String errorPhone = "";
  String errorDes = "";
  bool checkEmailErr = false;
  bool checkNameErr = false;
  bool checkPhoneErr = false;
  bool checkDesErr = false;
  ClinicService _clinicService = new ClinicService();
  @override
  void initState() {
    super.initState();
    emailController.addListener(() => setState(() {}));
    nameController.addListener(() => setState(() {}));
    phoneController.addListener(() => setState(() {}));
    descriptionController.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    emailController.dispose();
    nameController.dispose();
    phoneController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    AuthService authService = new AuthService();
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          leading: BackButton(
            onPressed: () => Navigator.pop(context),
          ),
          title: Text('Clinic Registration'),
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
                      "Clinic Information",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: getProportionateScreenWidth(28),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "Fill in your clinic information",
                      textAlign: TextAlign.left,
                    ),
                    SizedBox(height: SizeConfig.screenHeight * 0.04),
                    buildEmail(),
                    SizedBox(height: getProportionateScreenHeight(20)),
                    buildName(),
                    SizedBox(height: getProportionateScreenHeight(20)),
                    buildPhone(),
                    SizedBox(height: getProportionateScreenHeight(20)),
                    buildDescription(),
                    SizedBox(height: getProportionateScreenHeight(20)),
                    buildUploadImg(),
                    SizedBox(height: getProportionateScreenHeight(5)),
                    uploadClinicImg(),
                    SizedBox(height: SizeConfig.screenHeight * 0.04),
                    DefaultButton(
                      text: "Continue",
                      press: () async {
                        String url = "$ServerIP/api/v1/clinics";
                        String url1 = '$ServerIP/api/v1/users/signup';
                        var email = emailController.text;
                        var name = nameController.text;
                        var phone = phoneController.text;
                        var description = descriptionController.text;
                        String password = "123456789";
                        String confirm_password = "123456789";

                        if (email.isEmpty){
                          setState(() {
                            errorEmail = "Please enter email";
                            checkEmailErr = true;
                          });
                        } else if (!emailValidatorRegExp.hasMatch(email)){
                          setState(() {
                            errorEmail = "Please enter valid email";
                            checkEmailErr = true;
                          });
                        } else{
                          authService
                              .signup(url1, name, phone, email, password,
                              confirm_password)
                              .then((val) {
                            if (val.statusCode == 400) {
                              List list = val.data['errors'] as List;
                              for (int i = 0; i < list.length; i++) {
                                if (list[i]['field'] == 'email') {
                                  setState(() {
                                    errorEmail = list[i]['message'];
                                    checkEmailErr = true;
                                  });
                                }
                              }
                            }
                          });
                        }

                        if (name.isEmpty){
                          setState(() {
                            errorName = "Please enter name";
                            checkNameErr = true;
                          });
                        }

                        if (phone.isEmpty){
                          setState(() {
                            errorPhone = "Please enter phone";
                            checkPhoneErr = true;
                          });
                        }

                        if (description.isEmpty){
                          setState(() {
                            errorDes = "Please enter description";
                            checkDesErr = true;
                          });
                        }

                        if (!checkEmailErr && !checkNameErr && !checkPhoneErr && !checkDesErr){
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      ClinicLocationScreen(
                                          email,
                                          name,
                                          phone,
                                          description,
                                          _imageFile)));
                        }
                      },
                    ),
                    SizedBox(height: getProportionateScreenHeight(5)),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  TextField buildEmail() {
    return TextField(
      onChanged: (v){
        setState(() {
          checkEmailErr = false;
        });
      },
      controller: emailController,
      decoration: InputDecoration(
        border: new OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(50)),
        ),
        floatingLabelBehavior: FloatingLabelBehavior.always,
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: kPrimaryColor),
          borderRadius: BorderRadius.all(Radius.circular(50)),
        ),
        labelText: "Email",
        labelStyle: TextStyle(color: kPrimaryColor),
        hintText: "Enter your email",
        prefixIcon: Icon(
          Icons.mail_outline,
          size: 30,
          color: kPrimaryColor,
        ),
        errorText: checkEmailErr ? errorEmail : "",
        suffixIcon: emailController.text.isEmpty
            ? Container(width: 0)
            : IconButton(
                icon: Icon(Icons.close),
                onPressed: () => emailController.clear(),
              ),
      ),
      keyboardType: TextInputType.emailAddress,
      textInputAction: TextInputAction.done,
    );
  }

  TextField buildName() {
    return TextField(
      onChanged: (v){
        setState(() {
          checkNameErr = false;
        });
      },
      controller: nameController,
      decoration: InputDecoration(
        errorText: checkNameErr ? errorName : "",
        border: new OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(50)),
        ),
        floatingLabelBehavior: FloatingLabelBehavior.always,
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: kPrimaryColor),
          borderRadius: BorderRadius.all(Radius.circular(50)),
        ),
        labelText: "Clinic name",
        labelStyle: TextStyle(color: kPrimaryColor),
        hintText: "Enter clinic name",
        prefixIcon: Icon(
          Icons.local_hospital_outlined,
          size: 30,
          color: kPrimaryColor,
        ),
        suffixIcon: nameController.text.isEmpty
            ? Container(width: 0)
            : IconButton(
                icon: Icon(Icons.close),
                onPressed: () => nameController.clear(),
              ),
      ),
      keyboardType: TextInputType.text,
      textInputAction: TextInputAction.done,
    );
  }

  TextField buildPhone() {
    return TextField(
      onChanged: (v){
        setState(() {
          checkPhoneErr = false;
        });
      },
      controller: phoneController,
      decoration: InputDecoration(
        errorText: checkPhoneErr ? errorPhone : "",
        border: new OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(50)),
        ),
        floatingLabelBehavior: FloatingLabelBehavior.always,
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: kPrimaryColor),
          borderRadius: BorderRadius.all(Radius.circular(50)),
        ),
        labelText: "Phone",
        labelStyle: TextStyle(color: kPrimaryColor),
        hintText: "Enter your phone",
        prefixIcon: Icon(
          Icons.phone,
          size: 30,
          color: kPrimaryColor,
        ),
        suffixIcon: phoneController.text.isEmpty
            ? Container(width: 0)
            : IconButton(
                icon: Icon(Icons.close),
                onPressed: () => phoneController.clear(),
              ),
      ),
      keyboardType: TextInputType.phone,
      textInputAction: TextInputAction.done,
    );
  }

  TextField buildDescription() {
    return TextField(
      onChanged: (v){
        setState(() {
          checkDesErr = false;
        });
      },
      controller: descriptionController,
      decoration: InputDecoration(
        errorText: checkDesErr ? errorDes : "",
        border: new OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(50)),
        ),
        floatingLabelBehavior: FloatingLabelBehavior.always,
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: kPrimaryColor),
          borderRadius: BorderRadius.all(Radius.circular(50)),
        ),
        labelText: "Clinic description",
        labelStyle: TextStyle(color: kPrimaryColor),
        hintText: "Enter clinic description",
        prefixIcon: Icon(
          Icons.description_outlined,
          size: 30,
          color: kPrimaryColor,
        ),
        suffixIcon: descriptionController.text.isEmpty
            ? Container(width: 0)
            : IconButton(
                icon: Icon(Icons.close),
                onPressed: () => descriptionController.clear(),
              ),
      ),
      keyboardType: TextInputType.text,
      textInputAction: TextInputAction.done,
    );
  }

  PickedFile _imageFile;
  final ImagePicker _picker = ImagePicker();
  Widget uploadClinicImg() {
    return SizedBox(
      height: 250,
      width: 450,
      child: Stack(
        clipBehavior: Clip.none,
        fit: StackFit.expand,
        children: [
          Container(
              child: Image(
            image: _imageFile == null
                ? AssetImage('images/0.jpg')
                : FileImage(File(_imageFile.path)),
          )),
        ],
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

  Widget buildUploadImg() {
    return Row(
      children: [
        new Container(
          padding: const EdgeInsets.all(5.0),
          margin: const EdgeInsets.only(left: 5.0),
          child: Text(
            'UPLOAD IMAGE',
            style: TextStyle(fontSize: 20.0, color: Colors.black),
          ),
        ),
        SizedBox(width: 10),
        //Spacer(),
        SizedBox(
          height: 40,
          width: 40,
          // ignore: deprecated_member_use
          child: FlatButton(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
              side: BorderSide(color: kPrimaryColor),
            ),
            padding: EdgeInsets.all(5.0),
            child: Column(
              // Replace with a Row for horizontal icon + text
              children: <Widget>[
                Icon(Icons.file_copy_outlined, color: kPrimaryColor,),
              ],
            ),
            //color: Color(0xFFDFDFE3),
            onPressed: () {
              showModalBottomSheet(
                  context: context, builder: ((builder) => bottomSheet()));
            },
          ),
        ),
      ],
    );
  }
}
