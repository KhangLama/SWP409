import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:swp409/Models/clinic.dart';
import 'package:swp409/Models/specialist.dart';
import 'package:swp409/Services/ApiService/clinic_service.dart';
import 'package:swp409/Services/ApiService/specialist_service.dart';
import 'package:swp409/Services/Authentication/sign_in/sign_in_screen.dart';
import 'package:swp409/Services/Authentication/splash/splash_screen.dart';
import 'package:swp409/constants.dart';
import '../../../size_config.dart';
import 'package:fluttertoast/fluttertoast.dart';

class SpecialistChooseScreen extends StatefulWidget {
  Clinic clinic;
  PickedFile imageFile;
  SpecialistChooseScreen({Key key, this.clinic, this.imageFile})
      : super(key: key);

  @override
  _SpecialistChooseScreenState createState() => _SpecialistChooseScreenState();
}

class _SpecialistChooseScreenState extends State<SpecialistChooseScreen> {
  Future<bool> toast(String message) {
    Fluttertoast.cancel();
    return Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 2,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 22.0);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          leading: BackButton(
            onPressed: () => Navigator.pop(context),
          ),
          title: Text(
            'Choose Specialists',
            style: TextStyle(color: kPrimaryLightColor),
          ),
          centerTitle: true,
          backgroundColor: kPrimaryAppbar,
        ),
        bottomNavigationBar: BottomAppBar(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: kPrimaryColor,
                      // background
                      onPrimary: Colors.white,
                      textStyle: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                      minimumSize: Size(SizeConfig.screenWidth - 40, 60),
                      shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.all(
                              Radius.circular(10))), // foreground
                    ),
                    onPressed: () {
                      List<String> _specialists = <String>[];
                      for (int i = 0; i < listIsSelected.length; i++) {
                        if (listIsSelected[i]) {
                          _specialists.add(listSpecialist[i].id);
                        }
                      }

                      if (_specialists.length == 0) {
                        toastFail("Please choose at least 1");
                      } else {
                        String _spec = jsonEncode(_specialists);
                        //print("toString: ${_spec}");

                        _clinicService
                            .register(
                                url: url,
                                clinic: _clinic,
                                path: widget.imageFile,
                                specId: _spec)
                            .then((value) {
                          print(value.data);
                          if (value.data['status'] == 'success') {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => SignInScreen()));
                          } else {
                            print(value.data);
                          }
                        });
                        toast(
                            "Successfully, Please wait admin to approve your request");
                      }
                    },
                    child: Text('Submit')),
              ],
            ),
          ),
        ),
        body: SafeArea(
            child: Column(
          children: [
            SizedBox(height: SizeConfig.screenHeight * 0.02),
            Text(
              "Clinic Specialists",
              style: TextStyle(
                color: Colors.black,
                fontSize: getProportionateScreenWidth(28),
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              "Choose specialists for your clinic",
            ),
            SizedBox(height: SizeConfig.screenHeight * 0.04),
            Expanded(child: buildListSpecialist()),
          ],
        )),
      ),
    );
  }

  List<bool> listIsSelected = [];
  List<Specialists> listSpecialist = <Specialists>[];
  Clinic _clinic = new Clinic();
  ClinicService _clinicService = new ClinicService();
  String url = "$ServerIP/api/v1/clinics";

  @override
  void initState() {
    fetchSpecialists().then((value) {
      setState(() {
        listSpecialist = value;
      });
    });
    super.initState();
    _clinic = widget.clinic;
  }

  Widget buildListSpecialist() {
    return ListView.builder(
        itemCount: listSpecialist.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(
              listSpecialist[index].name,
              style: TextStyle(
                color: listIsSelected[index] ? kPrimaryColor : Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            tileColor: null,
            trailing: listIsSelected[index]
                ? Icon(
                    Icons.check_outlined,
                    color: kPrimaryColor,
                  )
                : Icon(Icons.check_box_outline_blank, color: Colors.black),
            onTap: () {
              setState(() {
                listIsSelected[index] = !listIsSelected[index];
              });
            },
          );
        });
  }

  String urlGetAllSpecialist = "$ServerIP/api/v1/specialists";
  SpecialistService specialistService = new SpecialistService();
  Future<List<Specialists>> fetchSpecialists() async {
    var fetchdata =
        await specialistService.getAllSpecialist(urlGetAllSpecialist);
    var list = <Specialists>[];
    var specjson = fetchdata.data['data']['data'] as List;

    for (var spec in specjson) {
      list.add(new Specialists.fromJson(spec));
    }

    for (int i = 0; i < list.length; i++) {
      listIsSelected.add(false);
    }
    return list;
  }
}
