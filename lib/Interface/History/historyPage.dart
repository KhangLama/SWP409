import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:swp409/constants.dart';
import 'package:flutter/cupertino.dart';

class HistoryPage extends StatefulWidget {
  @override
  _HistoryPageState createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  @override
  String status = "approve";
  Colors colorStatus;
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: kPrimaryBackground,
        appBar: AppBar(
          title: Text(
            'Appointment',
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
                top: 5.0, bottom: 10.0, left: 10.0, right: 10.0),
            child: Padding(
              padding: const EdgeInsets.only(
                  top: 15, bottom: 10, left: 0, right: 16),
              child: Row(
                children: [
                  Image(
                    image: AssetImage('images/0.jpg'),
                    width: 150,
                    height: 100,
                  ),
                  Flexible(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                "Benh Vien Da Khoa Can Tho",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            )
                          ],
                        ),
                        SizedBox(height: 5),
                        Row(
                          children: [
                            Icon(Feather.clock, color: Colors.black, size: 17),
                            SizedBox(width: 10),
                            Expanded(
                              child: Text(
                                "31 May 2021, 10.00 AM",
                                style: TextStyle(fontSize: 17),
                              ),
                            )
                          ],
                        ),
                        SizedBox(height: 5),
                        Row(
                          children: [
                            Icon(Feather.navigation, color: Colors.black, size: 17),
                            SizedBox(width: 10),
                            Expanded(
                              child: Text(
                                "389 duong Nguyen Van Cu, quan Ninh Kieu, thanh pho Can Tho",
                                style: TextStyle(fontSize: 17),
                              ),
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
                            Text(
                              "Status: ",
                              style: TextStyle(fontSize: 17),
                            ),
                            SizedBox(width: 10),
                            Text(
                              status,
                              style: TextStyle(
                                fontSize: 17,
                                color: getStatusColor(status),
                              ),
                            ),
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


  Color getStatusColor(String statusColor) {
    if (statusColor.compareTo("approve") == 0) {
      return Colors.green;
    } else if (statusColor.compareTo("pending") == 0) {
      return Colors.lightBlue;
    } else {
      return Colors.red;
    }
  }
}
