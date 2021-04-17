import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:swp409/Models/clinic.dart';
import 'package:swp409/Services/Booking/booking.dart';
import 'clinicdetailView.dart';

class ClinicListView extends StatefulWidget {
  @override
  _ClinicListViewState createState() => _ClinicListViewState();
}

class _ClinicListViewState extends State<ClinicListView> {
  var clinicList = [];
  Future<List<Clinic>> getClinic() async {
    var data = await DefaultAssetBundle.of(context)
        .loadString('assets/json/clinic.mock.json');
    clinicList = json.decode(data)['Clinic'] as List;
    return clinicList;
  }

  @override
  Widget build(BuildContext context) {
    getClinic();
    return Scaffold(
        backgroundColor: Colors.tealAccent,
        appBar: AppBar(title: Text('Find Clinic You Want')),
        body: SafeArea(
          child: ClinicList(clinicList: clinicList),
        ));
  }
}

class ClinicList extends StatefulWidget {
  const ClinicList({
    Key key,
    @required this.clinicList,
  }) : super(key: key);

  final List clinicList;

  @override
  _ClinicListState createState() => _ClinicListState();
}

class _ClinicListState extends State<ClinicList> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            itemCount:
                widget.clinicList.length == null ? 0 : widget.clinicList.length,
            shrinkWrap: true,
            itemBuilder: (BuildContext context, index) => Container(
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: GestureDetector(
                onTap: () => Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ClinicPage())),
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
                        Text(widget.clinicList[index]['name']),
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
          ),
        ),
      ],
    );
  }
}
