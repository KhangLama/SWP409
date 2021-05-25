import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import '../../../constants.dart';

class ClinicProfile extends StatefulWidget {
  @override
  _ClinicProfileState createState() => _ClinicProfileState();
}

class _ClinicProfileState extends State<ClinicProfile> {
  String email = "trinhha@gmail.com";
  String phone = "0123456789";
  String name = "Healthy clinic";
  String description = "Healthy clinic- The best chosen for you! Healthy clinic- The best chosen for you! Healthy clinic- The best chosen for you!";

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text(
            'Clinic profile',
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
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 5),
                Center(
                  child: Text(
                    "Clinic Profile",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 10),
                uploadClinicImg(),
                buildForm(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  PickedFile _imageFile;
  Widget uploadClinicImg() {
    return SizedBox(
      height: 250,
      width: 450,
      child: Stack(
        clipBehavior: Clip.none,
        fit: StackFit.expand,
        children: [
          Container(
            child: _imageFile == null
                ? Image.asset('images/0-1.png')
                : FileImage(File(_imageFile.path)),
          ),
        ],
      ),
    );
  }

  Widget buildForm() {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 25, 20, 10),
          child: Container(
            height: 60,
            child: Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(15, 5, 15, 5),
                child: Text(
                  name,
                  style: TextStyle(color: Colors.black, fontSize: 18),
                ),
              ),
            ),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(20)),
                border: Border.all(width: 1.0, color: Colors.black)),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
          child: Container(
            height: 60,
            child: Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(15, 5, 15, 5),
                child: Text(
                  email,
                  style: TextStyle(color: Colors.black, fontSize: 18),
                ),
              ),
            ),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(20)),
                border: Border.all(width: 1.0, color: Colors.black)),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
          child: Container(
            height: 60,
            child: Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(15, 5, 15, 5),
                child: Text(
                  phone,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                  ),
                ),
              ),
            ),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(20)),
                border: Border.all(
                  width: 1.0,
                  color: Colors.black,
                )),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 10, 20, 30),
          child: Container(
            height: 100,
            child: Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(15, 5, 15, 5),
                child: Text(
                  description,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                  ),
                ),
              ),
            ),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(20)),
                border: Border.all(width: 1.0, color: Colors.black)),
          ),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            // background color
            primary: kPrimaryColor,
            padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
            textStyle: TextStyle(fontSize: 20),
          ),
          child: Text('Setting account'),
          onPressed: () {
            print('Button clicked!');
          },
        ),
      ],
    );
  }
}
