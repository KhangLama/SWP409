import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

import '../../../constants.dart';

class ListCustomerAppointment extends StatefulWidget {
  @override
  _ListCustomerAppointmentState createState() =>
      _ListCustomerAppointmentState();
}

class _ListCustomerAppointmentState extends State<ListCustomerAppointment> {
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
                buildList1(),
                buildList2(),
                buildList3(),
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
                                    builder: (BuildContext context) =>  AlertDialog(
                                      title: Text("Approve this appointment", style: TextStyle(fontSize: 25),),
                                      content: Text("Are you sure?", style: TextStyle(fontSize: 24),),
                                      actions: [
                                        // ignore: deprecated_member_use
                                        new FlatButton(
                                            onPressed: (){
                                            },
                                            child: Text("Yes", style: TextStyle(fontSize: 23),)),
                                        // ignore: deprecated_member_use
                                        new FlatButton(
                                            onPressed: (){
                                              Navigator.of(context).pop();
                                            },
                                            child: Text("No", style: TextStyle(fontSize: 23),)),
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
                                    builder: (BuildContext context) =>  AlertDialog(
                                      title: Text("Reject this appointment", style: TextStyle(fontSize: 25),),
                                      content: Text("Are you sure?", style: TextStyle(fontSize: 24),),
                                      actions: [
                                        // ignore: deprecated_member_use
                                        new FlatButton(
                                            onPressed: (){
                                            },
                                            child: Text("Yes", style: TextStyle(fontSize: 23),)),
                                        // ignore: deprecated_member_use
                                        new FlatButton(
                                            onPressed: (){
                                              Navigator.of(context).pop();
                                            },
                                            child: Text("No", style: TextStyle(fontSize: 23),)),
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
                              "Khang Lam",
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
                              "26 May 2021, 11.30 AM",
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
                              "khanglm@gmail.com",
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
                              "0258654789",
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
                                  // Navigator.of(context, rootNavigator: true).push(
                                  //     MaterialPageRoute(
                                  //         builder: (context) => new Booking()));
                                },
                                child: Text('Accept')),
                            SizedBox(width: 10),
                            ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  primary: Colors.red, // background
                                  onPrimary: Colors.white, // foreground
                                ),
                                onPressed: () {},
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
                              "Luyl Da",
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
                              "27 May 2021, 09.00 AM",
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
                              "dalq@gmail.com",
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
                              "0245669987",
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
                                  // Navigator.of(context, rootNavigator: true).push(
                                  //     MaterialPageRoute(
                                  //         builder: (context) => new Booking()));
                                },
                                child: Text('Accept')),
                            SizedBox(width: 10),
                            ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  primary: Colors.red, // background
                                  onPrimary: Colors.white, // foreground
                                ),
                                onPressed: () {},
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
                              "Duy Anh",
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
                              "29 May 2021, 07.30 AM",
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
                              "0909846995",
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
                                  // Navigator.of(context, rootNavigator: true).push(
                                  //     MaterialPageRoute(
                                  //         builder: (context) => new Booking()));
                                },
                                child: Text('Accept')),
                            SizedBox(width: 10),
                            ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  primary: Colors.red, // background
                                  onPrimary: Colors.white, // foreground
                                ),
                                onPressed: () {},
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
