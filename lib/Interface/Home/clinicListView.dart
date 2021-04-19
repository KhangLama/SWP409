import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:swp409/Models/clinic.dart';
import 'package:swp409/Services/Booking/booking.dart';
import 'package:swp409/constants.dart';

import 'clinicdetailView.dart';

class ClinicListView extends StatefulWidget {
  @override
  _ClinicListViewState createState() => _ClinicListViewState();
}

class _ClinicListViewState extends State<ClinicListView> {
  List<Clinic> _clinics = <Clinic>[];

  Future<List<Clinic>> fetchClinics() async {
    var fetchdata = await rootBundle.loadString('assets/json/clinic.mock.json');
    var clinics = <Clinic>[];
    var clinicsjson = json.decode(fetchdata)['Clinic'] as List;
    for (var clinic in clinicsjson) {
      clinics.add(Clinic.fromJson(clinic));
    }
    return clinics;
  }

  @override
  void initState() {
    fetchClinics().then((value) {
      setState(() {
        _clinics.addAll(value);
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.tealAccent,
        appBar: AppBar(
          title: Text(
            'Find Clinic You Want',
            style: TextStyle(color: kPrimaryLightColor),
          ),
          backgroundColor: Colors.lightBlue,
        ),
        body: ListView.builder(
            itemCount: _clinics.length,
            itemBuilder: (context, index) {
              return Container(
                width: MediaQuery.of(context).size.width,
                child: GestureDetector(
                  onTap: () => Navigator.push(context,
                      MaterialPageRoute(builder: (context) => ClinicPage())),
                  child: Card(
                      child: Padding(
                    padding: const EdgeInsets.only(
                        top: 5, bottom: 10, left: 0, right: 16),
                    child: Row(
                      children: [
                        Image(
                          image: AssetImage('images/0-1.png'),
                          width: 150,
                          height: 100,
                        ),
                        Flexible(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(_clinics[index].id,
                                  style: TextStyle(fontSize: 20)),
                              Text(_clinics[index].name,
                                  style: TextStyle(fontSize: 20),
                              ),
                              ElevatedButton(
                                  onPressed: () => Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => Booking())),
                                  child: Text('Book an appointment'))
                            ],
                          ),
                        ),
                      ],
                    ),
                  )),
                ),
              );
            }));
  }
}
