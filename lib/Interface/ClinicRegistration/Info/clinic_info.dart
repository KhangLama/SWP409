import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:swp409/Components/default_button.dart';
import 'package:swp409/Interface/ClinicRegistration/Date/clinic_date.dart';
import 'package:swp409/Interface/ClinicRegistration/Location/clinic_location.dart';
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
                    SizedBox(height: getProportionateScreenHeight(30)),
                    buildName(),
                    SizedBox(height: getProportionateScreenHeight(30)),
                    buildPhone(),
                    SizedBox(height: getProportionateScreenHeight(30)),
                    buildDescription(),
                    SizedBox(height: getProportionateScreenHeight(30)),
                    buildUploadImg(),
                    SizedBox(height: getProportionateScreenHeight(5)),
                    uploadClinicImg(),
                    SizedBox(height: SizeConfig.screenHeight * 0.04),
                    DefaultButton(
                      text: "Continue",
                      press: () {
                        String url = "$ServerIP/api/v1/clinics";
                        // Navigator.pushReplacement(
                        //     context,
                        //     MaterialPageRoute(
                        //         builder: (context) => MainScreen()));
                        var email = emailController.text;
                        var name = nameController.text;
                        var phone = phoneController.text;
                        var description = descriptionController.text;
                        var file = _imageFile;
                        // _clinicService
                        //     .register(
                        //         url, email, name, phone, description, file)
                        //     .then((value) {
                        //   print(value.data);
                        //   if (value.data['status'] == 'success') {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ClinicLocationScreen(
                                    emailController.text,
                                    nameController.text,
                                    phoneController.text,
                                    descriptionController.text)));
                        // }
                        // });
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
      controller: emailController,
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(50),
          //borderSide: BorderSide(color: Colors.black),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: kPrimaryColor),
          borderRadius: BorderRadius.all(Radius.circular(50)),
        ),
        labelText: "Email",
        hintText: "Enter your email",
        prefixIcon: Icon(
          Icons.mail_outline,
          size: 30,
        ),
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
      controller: nameController,
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(50),
          //borderSide: BorderSide(color: Colors.black),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: kPrimaryColor),
          borderRadius: BorderRadius.all(Radius.circular(50)),
        ),
        labelText: "Clinic name",
        hintText: "Enter clinic name",
        prefixIcon: Icon(
          Icons.local_hospital_outlined,
          size: 30,
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
      controller: phoneController,
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(50),
          //borderSide: BorderSide(color: Colors.black),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: kPrimaryColor),
          borderRadius: BorderRadius.all(Radius.circular(50)),
        ),
        labelText: "Phone",
        hintText: "Enter your phone",
        prefixIcon: Icon(
          Icons.phone,
          size: 30,
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
      controller: descriptionController,
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(50),
          //borderSide: BorderSide(color: Colors.black),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: kPrimaryColor),
          borderRadius: BorderRadius.all(Radius.circular(50)),
        ),
        labelText: "Clinic description",
        hintText: "Enter clinic description",
        prefixIcon: Icon(
          Icons.description_outlined,
          size: 30,
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
            ),
          ),
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
            style: TextStyle(fontSize: 20.0),
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
              side: BorderSide(color: Colors.black),
            ),
            padding: EdgeInsets.all(5.0),
            child: Column(
              // Replace with a Row for horizontal icon + text
              children: <Widget>[
                Icon(Icons.file_copy_outlined),
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
