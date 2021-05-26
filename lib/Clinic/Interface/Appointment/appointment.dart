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
<<<<<<< Updated upstream
  String status = "complete";
  String status1 = "pending";
=======
  String status = "approve";
  Colors colorStatus;
>>>>>>> Stashed changes
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Color(0xFFAED2E8),
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
<<<<<<< Updated upstream
                buildList1(),
                buildList(),
                buildList1(),
                buildList(),
                buildList(),
=======
>>>>>>> Stashed changes
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
                              "31 May 20211, 10.00 AM",
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
<<<<<<< Updated upstream
                              "trinhhq@gmail.com",
                              style: TextStyle(fontSize: 17),
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
                              style: TextStyle(fontSize: 17,
                              color: status == "complete" ? Colors.green : Colors.blue),
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
                              "31 May 20211, 10.00 AM",
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
                            Icon(Feather.phone,
                                color: Colors.black, size: 17),
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
                              style: TextStyle(fontSize: 17,
                                  color: status1 == "complete" ? Colors.green : Colors.lightBlue),
=======
                              status,
                              style: TextStyle(
                                fontSize: 17,
                                color: getStatusColor(status),
                              ),
>>>>>>> Stashed changes
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
<<<<<<< Updated upstream
=======


  Color getStatusColor(String statusColor) {
    if (statusColor.compareTo("approve") == 0) {
      return Colors.green;
    } else if (statusColor.compareTo("pending") == 0) {
      return Colors.lightBlue;
    } else {
      return Colors.red;
    }
  }
>>>>>>> Stashed changes
}
