import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:swp409/Models/clinic.dart';
import 'package:swp409/constants.dart';

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
    print(_clinics.length);
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
        body: Column(
          children: [
            Expanded(
              child: ListView.builder(
                  itemCount: _clinics.length,
                  itemBuilder: (context, index) {
                    return Card(
                        child: Padding(
                      padding: const EdgeInsets.only(
                          top: 32, bottom: 32, left: 16, right: 16),
                      child: Row(
                        children: [
                          Image(image: AssetImage('images/0-1.png')),
                          Column(
                            children: [
                              Text(_clinics[index].id),
                              Text(_clinics[index].name),
                            ],
                          ),
                        ],
                      ),
                    ));
                  }),
            ),
          ],
        ));
  }
}
