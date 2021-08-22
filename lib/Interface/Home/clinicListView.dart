import 'dart:convert';
import 'package:delayed_display/delayed_display.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:location/location.dart';
import 'package:swp409/Interface/Calender/calender.dart';
import 'package:swp409/Interface/ChangePassword/change_password.dart';
import 'package:swp409/Interface/Home/searchBySymptom.dart';
import 'package:swp409/Interface/Profile/profilePage.dart';
import 'package:swp409/Models/clinic.dart';
import 'package:swp409/Models/user.dart';
import 'package:swp409/Services/ApiService/clinic_service.dart';
import 'package:swp409/Services/ApiService/specialist_service.dart';
import 'package:swp409/Services/Authentication/splash/splash_screen.dart';
import 'package:swp409/Services/Booking/booking.dart';
import 'package:swp409/constants.dart';
import 'clinicdetailView.dart';
import '../../constants.dart';
import 'package:dio/dio.dart';

// ignore: must_be_immutable
class ClinicListView extends StatefulWidget {
  List<String> cookies;
  User user;
  ClinicListView.user({Key key, this.user, this.cookies}) : super(key: key);
  @override
  _ClinicListViewState createState() => _ClinicListViewState();
}

class _ClinicListViewState extends State<ClinicListView> {
  User _user = new User();
  int _clinicListlength;
  List<String> _cookies;
  List listSearch = ['name', 'address'];
  String searchBy = 'name';
  Dio dio = new Dio();
  List listDistance = [];
  var location = new Location();
  LocationData _locationData;

  @override
  void initState() {
    fetchClinics().then((value) {
      setState(() {
        _clinics = value;
        _filteredclinic = _clinics;
      });
    });
    _cookies = widget.cookies;
    _user = widget.user;
    _clinicListlength = _filteredclinic.length == null ? 0 : 5;
    super.initState();
  }

  List<Clinic> _clinics = <Clinic>[];
  List<Clinic> _filteredclinic = <Clinic>[];
  String urlGet = "$ServerIP/api/v1/clinics/approved-clinics";
  ClinicService _clinicService = new ClinicService();

  Future<List<Clinic>> fetchClinics() async {
    var fetchdata = await _clinicService.getClinics(urlGet);
    _locationData = await location.getLocation();
    var clinics = <Clinic>[];
    var clinicsjson = fetchdata.data['data']['data'] as List;
    for (var clinic in clinicsjson) {
      clinics.add(Clinic.fromJson(clinic));
      getDT(
              _locationData.latitude,
              _locationData.longitude,
              clinics.last.geometry.coordinates[1],
              clinics.last.geometry.coordinates[0])
          .then((value) {
        listDistance.add(value);
      });
    }
    await Future.delayed(Duration(seconds: 1));
    sorting(listDistance, clinics);
    setState(() {});
    return clinics;
  }

  sorting(listDistance, clinics) {
    print(listDistance);
    for (var i = 0; i < clinics.length - 1; i++) {
      for (var j = 0; j < clinics.length - i - 1; j++) {
        if (double.parse(listDistance[j].split(' ')[0]) >
            double.parse(listDistance[j + 1].split(' ')[0])) {
          var tmp = listDistance[j];
          listDistance[j] = listDistance[j + 1];
          listDistance[j + 1] = tmp;
          var tmp1 = clinics[j];
          clinics[j] = clinics[j + 1];
          clinics[j + 1] = tmp1;
        }
      }
    }
  }

  Future<String> getDT(
      double startLat, double startLng, double destLat, double destLng) async {
    String urlDist =
        "https://maps.googleapis.com/maps/api/distancematrix/json?origins=heading=90:$startLat,$startLng&destinations=$destLat,$destLng&key=${dotenv.env['GOOGLE_MAP_KEY']}";
    Response resultz = await dio.get(urlDist);
    print(resultz);
    var rs =
        resultz.data['rows'][0]['elements'][0]['distance']['text'].toString();

    return rs;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: kPrimaryBackground,
        drawer: buildDrawer(context),
        appBar: AppBar(
          title: Text(
            'Find Clinic You Want',
            style: TextStyle(color: kPrimaryLightColor),
          ),
          backgroundColor: kPrimaryAppbar,
        ),
        body: SafeArea(
          child: Column(
            children: <Widget>[
              // search bar
              Container(
                margin: const EdgeInsets.only(left: 1, right: 1),
                child: TextField(
                  decoration: InputDecoration(
                    fillColor: Colors.white,
                    filled: true,
                    contentPadding: EdgeInsets.all(8),
                    hintText: 'Search clinics by',
                    suffixIcon: DropdownButton(
                      icon: Icon(
                        Icons.arrow_drop_down,
                        color: kPrimaryColor,
                      ),
                      iconSize: 30,
                      value: searchBy,
                      onChanged: (type) {
                        setState(() {
                          searchBy = type;
                        });
                      },
                      items: listSearch.map((value) {
                        return DropdownMenuItem(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                    enabledBorder: new OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      borderSide: BorderSide(color: kPrimaryColor, width: 2),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: kPrimaryColor, width: 2),
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    // focusedBorder: OutlineInputBorder(
                    //   borderSide: BorderSide(color: kPrimaryColor),
                    // ),
                  ),
                  onChanged: (text) {
                    if (searchBy.compareTo('name') == 0) {
                      setState(() {
                        _filteredclinic = _clinics
                            .where((c) => (c.name
                                .toLowerCase()
                                .contains(text.toLowerCase())))
                            .toList();
                      });
                    } else if (searchBy.compareTo('address') == 0) {
                      setState(() {
                        _filteredclinic = _clinics
                            .where((c) => (c.address
                                .toLowerCase()
                                .contains(text.toLowerCase())))
                            .toList();
                      });
                    }
                  },
                ),
              ),
              Expanded(child: buildListView()),
            ],
          ),
        ));
  }

  Drawer buildDrawer(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          DrawerHeader(
            child: Center(
              child: Text(
                'Hello, ${widget.user.name}',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white, fontSize: 25),
              ),
            ),
            decoration: BoxDecoration(
              color: kPrimaryColor,
            ),
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text('Home'),
            onTap: () => {},
          ),
          // ListTile(
          //   leading: Icon(Icons.calendar_today_outlined),
          //   title: Text('Calender'),
          //   onTap: () {
          //     Navigator.push(context,
          //         MaterialPageRoute(builder: (context) => CalendarScreen()));
          //   },
          // ),
          ListTile(
            leading: Icon(Icons.search_rounded),
            title: Text('Search by symptoms'),
            onTap: () {
              Navigator.of(context, rootNavigator: true).push(MaterialPageRoute(
                  builder: (context) => searchBySymptomScreen(
                        user: _user,
                        cookies: _cookies,
                      )));
            },
          ),
          ListTile(
            leading: Icon(Icons.person_rounded),
            title: Text('Profile'),
            onTap: () {
              Navigator.of(context, rootNavigator: true).push(MaterialPageRoute(
                  builder: (context) => ProfilePage.user(
                        user: _user,
                        cookies: _cookies,
                      )));
            },
          ),
          ListTile(
            leading: Icon(Icons.lock_rounded),
            title: Text('Change password'),
            onTap: () {
              Navigator.of(context, rootNavigator: true).push(MaterialPageRoute(
                  builder: (context) => ChangePasswordScreen.user(
                        user: _user,
                        cookies: _cookies,
                      )));
            },
          ),
          ListTile(
            leading: Icon(Icons.exit_to_app_rounded),
            title: Text('Logout'),
            onTap: () {
              Navigator.of(context, rootNavigator: true).pushReplacement(
                  MaterialPageRoute(builder: (context) => new SplashScreen()));
            },
          ),
        ],
      ),
    );
  }

  // List view of clinic card
  buildListView() {
    return NotificationListener<ScrollNotification>(
      // ignore: missing_return
      onNotification: (scrollNotification) {
        assert(scrollNotification != null);
        if (scrollNotification.metrics.pixels ==
            scrollNotification.metrics.maxScrollExtent) {
          setState(() {
            _clinicListlength = _clinicListlength + 5 <= _filteredclinic.length
                ? _clinicListlength += 5
                : _filteredclinic.length;
          });
        }
      },
      child: ListView.builder(
          shrinkWrap: true,
          itemCount: _filteredclinic.length,
          itemBuilder: (context, index) {
            return DelayedDisplay(
              delay: Duration(milliseconds: 200),
              child: Container(
                width: MediaQuery.of(context).size.width,
                child: GestureDetector(
                  onTap: () => Navigator.of(context, rootNavigator: true)
                      .push(MaterialPageRoute(
                          builder: (context) => ClinicPage.clinic(
                                clinic: _filteredclinic[index],
                                user: _user,
                                cookies: _cookies,
                              ))),
                  child: Card(
                      margin: const EdgeInsets.only(
                          top: 5.0, bottom: 10.0, left: 10.0, right: 10.0),
                      child: Padding(
                        padding: const EdgeInsets.only(
                            top: 20, bottom: 15, left: 0, right: 16),
                        child: Row(
                          children: [
                            Image(
                              image: NetworkImage(
                                  _filteredclinic[index].coverImage.url),
                              //image: AssetImage("images/0-1.png"),
                              width: 150,
                              height: 100,
                            ),
                            Flexible(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    _filteredclinic[index].name,
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(height: 10),
                                  Row(
                                    children: [
                                      Icon(Icons.location_on_outlined,
                                          color: Colors.black),
                                      SizedBox(width: 5),
                                      Expanded(
                                        child: Text(
                                          _filteredclinic[index].address ?? "",
                                          style: TextStyle(fontSize: 17),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 10),
                                  Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Text(listDistance[index] ?? "")
                                      ]),
                                  SizedBox(height: 10),
                                  ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        primary: kPrimaryColor, // background
                                        onPrimary: Colors.white,
                                        textStyle: TextStyle(
                                          fontSize: 17,
                                          color: Colors.white,
                                        ),
                                        minimumSize: Size(180, 40),
                                        shape: new RoundedRectangleBorder(
                                            borderRadius: new BorderRadius.all(
                                                Radius.circular(
                                                    15))), // foreground
                                      ),
                                      onPressed: () {
                                        Navigator.of(context,
                                                rootNavigator: true)
                                            .push(MaterialPageRoute(
                                                builder: (context) => Booking(
                                                      clinic: _filteredclinic[
                                                          index],
                                                      user: _user,
                                                      cookies: _cookies,
                                                    )));
                                      },
                                      child: Text('Book an appointment'))
                                ],
                              ),
                            ),
                          ],
                        ),
                      )),
                ),
              ),
            );
          }),
    );
  }
}

List<Clinic> _clinics = <Clinic>[];
List<Clinic> _filteredclinic = <Clinic>[];
String urlGet = "$ServerIP/api/v1/clinics/approved-clinics";
ClinicService _clinicService = new ClinicService();

Future<List<Clinic>> fetchClinics() async {
  var fetchdata = await _clinicService.getClinics(urlGet);
  List<Clinic> clinics = <Clinic>[];
  var clinicsjson = fetchdata.data['data']['data'] as List;
  for (var clinic in clinicsjson) {
    clinics.add(Clinic.fromJson(clinic));
  }
  return clinics;
}
