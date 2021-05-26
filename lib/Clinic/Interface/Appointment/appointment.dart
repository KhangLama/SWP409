import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

import '../../../constants.dart';

class Appointment extends StatefulWidget {
  @override
  _AppointmentState createState() => _AppointmentState();
}

class _AppointmentState extends State<Appointment> {
  @override
  String status = "approve";
  String status1 = "pending";
  String status2 = "reject";
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
                buildList1(),
                buildList2(),
                buildList3(),
                buildList4(),
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

  Widget buildList1() {
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
                                "Benh Vien Phuong Chau",
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
                                "25 May 2021, 11.00 AM",
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
                                "389 duong Nguyen Van Cu, quan 1, thanh pho Ho Chi Minh",
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
                              status1,
                              style: TextStyle(
                                fontSize: 17,
                                color: getStatusColor(status1),
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

  Widget buildList2() {
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
                                "Benh Vien Dan Lap",
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
                                "29 May 2021, 8.00 AM",
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
                                "16/5 Nguyen Trai, quan 7, thanh pho Ho Chi Minh",
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
                              "0258964789",
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
                              status2,
                              style: TextStyle(
                                fontSize: 17,
                                color: getStatusColor(status2),
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

  Widget buildList3() {
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
                                "Benh Vien Quan Doi QK9",
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
                                "21 May 2021, 1.00 PM",
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
                                "200 De Tham, quan 9, thanh pho Ho Chi Minh",
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
                              "0258963147",
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
                              status2,
                              style: TextStyle(
                                fontSize: 17,
                                color: getStatusColor(status2),
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

  Widget buildList4() {
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
                                "Benh Vien Da Khoa Sa Dec",
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
                                "26 May 2021, 2.00 PM",
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
                                "245 Nguyen Sinh Sac, thanh pho Sa Dec, tinh Dong Thap",
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
                              "0258746958",
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
