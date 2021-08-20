import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:swp409/Clinic/Interface/UpdateClinicInfo/change_password.dart';
import 'package:swp409/Clinic/Interface/UpdateClinicInfo/specialists.dart';
import 'package:swp409/Clinic/Interface/UpdateClinicInfo/working_hours.dart';
import 'package:swp409/Models/booking.dart';
import 'package:swp409/Models/clinic.dart';
import 'package:swp409/Models/user.dart';
import 'package:swp409/Services/ApiService/clinic_service.dart';
import 'package:intl/intl.dart';
import 'package:swp409/Services/Authentication/splash/splash_screen.dart';

import '../../../constants.dart';
import 'package:googleapis/calendar/v3.dart' as prefix;
import "package:googleapis_auth/auth_io.dart";
import 'package:url_launcher/url_launcher.dart';

class ListCustomerAppointment extends StatefulWidget {
  User user;
  List<String> cookies;
  ListCustomerAppointment.user({Key key, this.user, this.cookies})
      : super(key: key);
  @override
  _ListCustomerAppointmentState createState() =>
      _ListCustomerAppointmentState();
}

class _ListCustomerAppointmentState extends State<ListCustomerAppointment> {
  User _user = new User();
  Clinic _clinic = new Clinic();
  List<String> _cookies;
  String urlGet = "$ServerIP/api/v1/clinics/approved-clinics";

  //variable for google calendar
  static const _scopes = const [prefix.CalendarApi.calendarScope];
  prefix.Event _event = prefix.Event();

  var _clientID = new ClientId(
      "627402697996-vh1fp5j16jtvqt0jerb9hnebunfjb0fl.apps.googleusercontent.com",
      "");
  Clinic getClinicId(List<Clinic> list, User user) {
    if (list != null) {
      for (var i = 0; i < list.length; i++) {
        if (list[i].email == user.email) {
          print('abv');
          print(list[i].toJson());
          return list[i];
        }
      }
    }
    return null;
  }

  Future<List<Clinic>> fetchClinics() async {
    var fetchdata = await _clinicService.getClinics(urlGet);
    var clinics = <Clinic>[];
    var clinicsjson = fetchdata.data['data']['data'] as List;
    for (var clinic in clinicsjson) {
      clinics.add(Clinic.fromJson(clinic));
    }
    return clinics;
  }

  @override
  void initState() {
    _cookies = widget.cookies;
    fetchBookings().then((value) {
      setState(() {
        _booking = value;
      });
    });
    fetchClinics().then((value) {
      setState(() {
        _user = widget.user;
        _clinic = getClinicId(value, _user);
        print('testing');
        print(_clinic.email);
        print(_clinic.name);
      });
    });

    super.initState();
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
          ListTile(
            leading: Icon(Icons.access_time_rounded),
            title: Text('Change Working hours'),
            onTap: () => {
              Navigator.of(context, rootNavigator: true).push(MaterialPageRoute(
                  builder: (context) => ChangeWorkingHoursScreen(
                        clinic: _clinic,
                        cookies: _cookies,
                      )))
            },
          ),
          ListTile(
            leading: Icon(Icons.medical_services_rounded),
            title: Text('Change Specialists'),
            onTap: () {
              Navigator.of(context, rootNavigator: true).push(MaterialPageRoute(
                  builder: (context) => ChangeSpecialistsScreen(
                        clinic: _clinic,
                        cookies: _cookies,
                      )));
            },
          ),
          ListTile(
            leading: Icon(Icons.lock_rounded),
            title: Text('Change password'),
            onTap: () {
              Navigator.of(context, rootNavigator: true).push(MaterialPageRoute(
                  builder: (context) => ChangePassClinicScreen(
                        user: _user,
                        cookies: _cookies,
                      )));
            },
          ),
          ListTile(
            leading: Icon(Icons.exit_to_app),
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

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: kPrimaryBackground,
        drawer: buildDrawer(context),
        appBar: AppBar(
          title: Text(
            'Home',
            style: TextStyle(color: kPrimaryLightColor),
          ),
          backgroundColor: kPrimaryAppbar,
        ),
        body: SafeArea(
          child: buildList(),
        ),
      ),
    );
  }

  ListView buildList() {
    return ListView.builder(
        itemCount: _booking.length,
        itemBuilder: (context, index) => Container(
              width: MediaQuery.of(context).size.width,
              child: GestureDetector(
                child: Card(
                    margin: const EdgeInsets.only(
                        top: 5.0, bottom: 10.0, left: 10.0, right: 10.0),
                    child: Padding(
                      padding: const EdgeInsets.only(
                          top: 15, bottom: 10, left: 0, right: 16),
                      child: Row(
                        children: [
                          Image(
                            image:
                                NetworkImage(_booking[index].user.avatar.url),
                            width: 150,
                            height: 100,
                          ),
                          Flexible(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      _booking[index].user.name,
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    )
                                  ],
                                ),
                                SizedBox(height: 5),
                                Row(
                                  children: [
                                    Icon(Feather.clock,
                                        color: Colors.black, size: 17),
                                    SizedBox(width: 10),
                                    Text(
                                      '${DateFormat('yyyy-MM-dd').format(_booking[index].bookedDate)}, ${(_booking[index].bookedTime ~/ 60).toString().padLeft(2, '0')}:${(_booking[index].bookedTime % 60).toInt().toString().padLeft(2, '0')}',
                                      style: TextStyle(fontSize: 17),
                                    ),
                                    SizedBox(width: 5),
                                  ],
                                ),
                                SizedBox(height: 5),
                                Row(
                                  children: [
                                    Icon(Feather.mail,
                                        color: Colors.black, size: 17),
                                    SizedBox(width: 10),
                                    Expanded(
                                      child: Text(
                                        _booking[index].user.email,
                                        style: TextStyle(
                                          fontSize: 17,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                SizedBox(height: 5),
                                Row(
                                  children: [
                                    Icon(Feather.phone,
                                        color: Colors.black, size: 17),
                                    SizedBox(width: 10),
                                    Text(
                                      _booking[index].user.phone,
                                      style: TextStyle(fontSize: 17),
                                    )
                                  ],
                                ),
                                SizedBox(height: 5),
                                Row(
                                  children: [
                                    ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          primary: Colors.green, // background
                                          onPrimary: Colors.white, // foreground
                                        ),
                                        onPressed: () {
                                          showDialog(
                                            context: context,
                                            builder: (BuildContext context) =>
                                                AlertDialog(
                                              title: Text(
                                                "Approve this booking",
                                                style: TextStyle(fontSize: 25),
                                              ),
                                              content: Text(
                                                "Are you sure?",
                                                style: TextStyle(fontSize: 24),
                                              ),
                                              actions: [
                                                // ignore: deprecated_member_use
                                                new FlatButton(
                                                    onPressed: () {
                                                      //works with google calendar
                                                      _event.summary =
                                                          "Appointment at ${_clinic.name}";

                                                      //apointment start time
                                                      _event.attendees = [
                                                        prefix.EventAttendee
                                                            .fromJson({
                                                          'email':
                                                              '${_booking[index].user.email}'
                                                        })
                                                      ];

                                                      prefix.EventDateTime
                                                          start = new prefix
                                                              .EventDateTime();
                                                      DateTime _bookday =
                                                          DateTime(
                                                              _booking[index]
                                                                  .bookedDate
                                                                  .year,
                                                              _booking[index]
                                                                  .bookedDate
                                                                  .month,
                                                              _booking[index]
                                                                  .bookedDate
                                                                  .day);
                                                      start.dateTime =
                                                          _bookday.add(Duration(
                                                              minutes: _booking[
                                                                      index]
                                                                  .bookedTime));
                                                      start.timeZone =
                                                          "GTM+07:00";
                                                      _event.start = start;
                                                      //appointment end time
                                                      prefix.EventDateTime end =
                                                          new prefix
                                                              .EventDateTime();
                                                      end.dateTime = start
                                                          .dateTime
                                                          .add(Duration(
                                                              minutes: 15));
                                                      end.timeZone =
                                                          "GTM+07:00";
                                                      _event.end = end;
                                                      insertEvent(_event);
                                                      fetchBookings()
                                                          .then((value) {
                                                        setState(() {
                                                          _booking = value;
                                                          print(_booking);
                                                        });
                                                      });
                                                      Navigator.of(context)
                                                          .pop();
                                                    },
                                                    child: Text(
                                                      "Yes",
                                                      style: TextStyle(
                                                          fontSize: 23),
                                                    )),
                                                // ignore: deprecated_member_use
                                                new FlatButton(
                                                    onPressed: () {
                                                      Navigator.of(context)
                                                          .pop();
                                                    },
                                                    child: Text(
                                                      "No",
                                                      style: TextStyle(
                                                          fontSize: 23),
                                                    )),
                                              ],
                                            ),
                                          );
                                        },
                                        child: Text('Accept')),
                                    SizedBox(width: 20),
                                    ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          primary: Colors.red, // background
                                          onPrimary: Colors.white, // foreground
                                        ),
                                        onPressed: () {
                                          showDialog(
                                            context: context,
                                            builder: (BuildContext context) =>
                                                AlertDialog(
                                              title: Text(
                                                "Reject this appointment",
                                                style: TextStyle(fontSize: 25),
                                              ),
                                              content: Text(
                                                "Are you sure?",
                                                style: TextStyle(fontSize: 24),
                                              ),
                                              actions: [
                                                // ignore: deprecated_member_use
                                                new FlatButton(
                                                    onPressed: () {},
                                                    child: Text(
                                                      "Yes",
                                                      style: TextStyle(
                                                          fontSize: 23),
                                                    )),
                                                // ignore: deprecated_member_use
                                                new FlatButton(
                                                    onPressed: () {
                                                      Navigator.of(context)
                                                          .pop();
                                                    },
                                                    child: Text(
                                                      "No",
                                                      style: TextStyle(
                                                          fontSize: 23),
                                                    )),
                                              ],
                                            ),
                                          );
                                        },
                                        child: Text('Cancel')),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    )),
              ),
            ));
  }

  List<Booking> _booking = <Booking>[];
  String urlGetBooking = "$ServerIP/api/v1/bookings/users";
  ClinicService _clinicService = new ClinicService();

  Future<List<Booking>> fetchBookings() async {
    var fetchdata =
        await _clinicService.getBookingsOfClinic(urlGetBooking, _cookies);
    var list = <Booking>[];
    print(urlGetBooking);
    var bookingsjson = fetchdata.data['data']['data'] as List;
    print('booking json');
    //print(bookingsjson);
    for (var booking in bookingsjson) {
      list.add(new Booking.fromJson(booking));
    }
    return list;
  }

  insertEvent(event) {
    try {
      clientViaUserConsent(_clientID, _scopes, prompt)
          .then((AuthClient client) {
        var calendar = prefix.CalendarApi(client);
        String calendarId = "primary";
        calendar.events
            .insert(event, calendarId, sendNotifications: true)
            .then((value) {
          print("ADDEDDD_________________${value.status}");
          if (value.status == "confirmed") {
            log('Event added in google calendar');
          } else {
            log("Unable to add event in google calendar");
          }
        });
      });
    } catch (e) {
      log('Error creating event $e');
    }
  }

  void prompt(String url) async {
    print("Please go to the following URL and grant access:");
    print("  => $url");
    print("");

    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
