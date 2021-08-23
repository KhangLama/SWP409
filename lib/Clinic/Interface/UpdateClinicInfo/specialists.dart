import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:swp409/Models/clinic.dart';
import 'package:swp409/Models/specialist.dart';
import 'package:swp409/Services/ApiService/clinic_service.dart';
import 'package:swp409/Services/ApiService/specialist_service.dart';
import 'package:swp409/constants.dart';
import 'package:swp409/helper/keyboard.dart';

import '../../../size_config.dart';

class ChangeSpecialistsScreen extends StatefulWidget {
  Clinic clinic;
  List<String> cookies;
  ChangeSpecialistsScreen({Key key, this.clinic, this.cookies})
      : super(key: key);

  @override
  _ChangeSpecialistsScreenState createState() =>
      _ChangeSpecialistsScreenState();
}

class _ChangeSpecialistsScreenState extends State<ChangeSpecialistsScreen> {
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
      home: Scaffold(
        appBar: AppBar(
          leading: BackButton(
            onPressed: () => Navigator.pop(context),
          ),
          title: Text(
            'Update Specialists',
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
                      _clinic.specialists.clear();
                      for (int i = 0; i < listIsSelected.length; i++) {
                        if (listIsSelected[i]) {
                          _clinic.specialists
                              .add(new Specialist(id: listSpecialist[i].id));
                        }
                      }

                      if (_clinic.specialists.length == 0) {
                        toastFail("Please choose at least 1");
                      } else {
                        _clinicService
                            .updateSpecialists(urlUpdate, _clinic, _cookies)
                            .then((res) {
                          print('bodyyyyy');
                          KeyboardUtil.hideKeyboard(context);
                          if (res.data['status'] == "success") {
                            toast("Successfully");
                            print('update success');
                          } else {
                            print('fail to update');
                          }
                        });
                      }

                      // Navigator.push(context,
                      //     MaterialPageRoute(builder: (context) => SplashScreen()));
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
  String urlUpdate = "$ServerIP/api/v1/clinics/detail";
  List<String> _cookies;

  @override
  void initState() {
    fetchSpecialists().then((value) {
      setState(() {
        listSpecialist = value;
      });
    });
    super.initState();
    _clinic = widget.clinic;
    _cookies = widget.cookies;
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

    int n = _clinic.specialists.length;

    for (int i = 0; i < list.length; i++) {
      int j = 0;
      for (j = 0; j < n; j++) {
        if (list[i].id.compareTo(_clinic.specialists[j].id) == 0) {
          listIsSelected.add(true);
          break;
        }
      }
      if (j == n) {
        listIsSelected.add(false);
      }
    }
    return list;
  }
}
