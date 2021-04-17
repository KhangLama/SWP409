import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:swp409/Models/clinic.dart';
import 'package:swp409/Services/Booking/booking.dart';
import 'package:swp409/constants.dart';
import 'clinicdetailView.dart';

class ClinicListView extends StatefulWidget {
  @override
  _ClinicListViewState createState() => _ClinicListViewState();
}

class _ClinicListViewState extends State<ClinicListView> {
  Future<List<Clinic>> _getClinic() async {
    var data = await DefaultAssetBundle.of(context)
        .loadString('assets/json/clinic.mock.json');
    var clinicList = json.decode(data)['Clinic'] as List;
    List<Clinic> clinics = [];
    for (var c in clinicList) {
      Clinic clinic =
          Clinic(id: c['id'], lat: c['lat'], lng: c['lng'], name: c['name']);
      clinics.add(clinic);
    }
    return clinics;
  }

  @override
  Widget build(BuildContext context) {
    _getClinic();
    return Scaffold(
      backgroundColor: Colors.tealAccent,
      appBar: AppBar(
        title: Text(
          'Find Clinic You Want',
          style: TextStyle(color: kPrimaryLightColor),
        ),
        actions: [IconButton(icon: Icon(Icons.search), onPressed: () {
          showSearch(context: context, delegate: _getClinic())
        })],
        backgroundColor: Colors.lightBlue,
      ),
      body: SafeArea(
          child: Column(
        children: [
          Expanded(
            child: FutureBuilder(
                future: _getClinic(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.data == null) {
                    return Container(
                      child: Center(child: Text('Loading...')),
                    );
                  } else
                    return ListView.builder(
                      itemCount: snapshot.data.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) => Container(
                        width: MediaQuery.of(context).size.width,
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        child: GestureDetector(
                          onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ClinicPage())),
                          child: Card(
                              child: Row(
                            children: [
                              Image(
                                image: AssetImage('images/0-1.png'),
                                height: 100,
                                width: 150,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(snapshot.data[index].name),
                                  ElevatedButton(
                                      onPressed: () => Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => Booking())),
                                      child: Text('Book an appointment'))
                                ],
                              )
                            ],
                          )),
                        ),
                      ),
                    );
                }),
          ),
        ],
      )),
    );
  }
}
