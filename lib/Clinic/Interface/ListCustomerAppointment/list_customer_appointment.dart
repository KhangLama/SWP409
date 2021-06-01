import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:swp409/Models/clinic.dart';
import 'package:swp409/Models/user.dart';
import 'package:swp409/Services/ApiService/clinic_service.dart';

import '../../../constants.dart';

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
  Clinic _clinic = new Clinic();
  User _user = new User();
  int _clinicListlength;
  List<String> _cookies;
  @override
  void initState() {
    _user = widget.user;
    fetchClinics().then((value) {
      setState(() {
        _clinics = value;
        for (int i = 0; i < _clinics.length; i++) {
          if (_user.email.compareTo(_clinics[i].email) == 0) {
            _clinic = _clinics[i];
          }
        }
      });
    });
    _cookies = widget.cookies;
    _user = widget.user;
    //getUserData(widget.storage).then((value) => _user = value);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: kPrimaryBackground,
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
                Navigator.of(context).pop();
              },
            )
          ],
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                // search bar
                buildList(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildList() {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: GestureDetector(
        child: Card(
            margin: const EdgeInsets.only(
                top: 0, bottom: 15.0, left: 10.0, right: 10.0),
            child: Padding(
              padding: const EdgeInsets.only(
                  top: 15, bottom: 10, left: 0, right: 16),
              child: Row(
                children: [
                  Image(
                    image: AssetImage('images/userprofile.jpg'),
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
                              "Trinh Ha",
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
                            Icon(Feather.clock, color: Colors.black, size: 17),
                            SizedBox(width: 10),
                            Text(
                              "31 May 2021, 10.00 AM",
                              style: TextStyle(fontSize: 17),
                            )
                          ],
                        ),
                        SizedBox(height: 5),
                        Row(
                          children: [
                            Icon(Feather.mail, color: Colors.black, size: 17),
                            SizedBox(width: 10),
                            Text(
                              "trinhhq@gmail.com",
                              style: TextStyle(fontSize: 17),
                            )
                          ],
                        ),
                        SizedBox(height: 5),
                        Row(
                          children: [
                            Icon(Feather.phone, color: Colors.black, size: 17),
                            SizedBox(width: 10),
                            Text(
                              "0123456789",
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
                                        "Approve this appointment",
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
                                              style: TextStyle(fontSize: 23),
                                            )),
                                        // ignore: deprecated_member_use
                                        new FlatButton(
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                            child: Text(
                                              "No",
                                              style: TextStyle(fontSize: 23),
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
                                              style: TextStyle(fontSize: 23),
                                            )),
                                        // ignore: deprecated_member_use
                                        new FlatButton(
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                            child: Text(
                                              "No",
                                              style: TextStyle(fontSize: 23),
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
    );
  }
}

List<Clinic> _clinics = <Clinic>[];
String urlGet = "$ServerIP/api/v1/clinics/approved-clinics";
ClinicService _clinicService = new ClinicService();
Future<List<Clinic>> fetchClinics() async {
  var fetchdata = await _clinicService.getClinics(urlGet);
  var clinics = <Clinic>[];
  var clinicsjson = fetchdata.data['data']['data'] as List;
  for (var clinic in clinicsjson) {
    clinics.add(Clinic.fromJson(clinic));
  }
  return clinics;
}
