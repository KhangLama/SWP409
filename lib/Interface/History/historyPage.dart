import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:swp409/Models/booking.dart';
import 'package:swp409/Models/user.dart';
import 'package:swp409/Services/ApiService/user_service.dart';
import 'package:swp409/constants.dart';
import 'package:flutter/cupertino.dart';

class HistoryPage extends StatefulWidget {
  User user;
  List<String> cookies;
  HistoryPage({Key key, this.user, this.cookies}) : super(key: key);
  @override
  _HistoryPageState createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  String status = "approve";
  Colors colorStatus;
  User _user = new User();
  UserService _userService = new UserService();
  List<String> _cookies;
  List<Booking> _bookings = <Booking>[];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _user = widget.user;
    _cookies = widget.cookies;
    fetchBookings().then((value) {
      setState(() {
        _bookings = value;
      });
    });
  }

  Future<List<Booking>> fetchBookings() async {
    String url = '$ServerIP/api/v1/bookings/users';
    var fetchdata = await _userService.getHistory(url, _cookies);
    var bookings = <Booking>[];
    var bookingsjson = fetchdata.data['data']['data'] as List;
    for (var clinic in bookingsjson) {
      bookings.add(Booking.fromJson(clinic));
    }
    print('akjsdnkjsa');
    print(bookings);
    return bookings;
  }

  @override
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
        ),
        body: SafeArea(
          child: buildList(_bookings),
        ),
      ),
    );
  }

  Widget buildList(List<Booking> _bookings) {
    return ListView.builder(
      itemCount: _bookings.length,
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
                    // Image(
                    //   image:
                    //       NetworkImage(_bookings[index].clinic.coverImage.url),
                    //   width: 150,
                    //   height: 100,
                    // ),
                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  _bookings[index].clinic.name ?? '',
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
                              Icon(Feather.clock,
                                  color: Colors.black, size: 17),
                              SizedBox(width: 10),
                              Expanded(
                                child: Text(
                                  DateTime.parse(_bookings[index]
                                              .bookedDate
                                              .toIso8601String())
                                          .toString() ??
                                      '',
                                  style: TextStyle(fontSize: 17),
                                ),
                              )
                            ],
                          ),
                          SizedBox(height: 5),
                          Row(
                            children: [
                              Icon(Feather.navigation,
                                  color: Colors.black, size: 17),
                              SizedBox(width: 10),
                              Expanded(
                                child: Text(
                                  _bookings[index].clinic.address ?? '',
                                  style: TextStyle(fontSize: 17),
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
                                _bookings[index].clinic.phone ?? '',
                                style: TextStyle(fontSize: 17),
                              )
                            ],
                          ),
                          SizedBox(height: 5),
                          Row(
                            children: [
                              Text(
                                'Status: ',
                                style: TextStyle(fontSize: 17),
                              ),
                              SizedBox(width: 10),
                              Text(
                                _bookings[index].status ?? '',
                                style: TextStyle(
                                  fontSize: 17,
                                  color:
                                      getStatusColor(_bookings[index].status),
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
      ),
    );
  }

  Color getStatusColor(String statusColor) {
    if (statusColor.compareTo("approved") == 0) {
      return Colors.green;
    } else if (statusColor.compareTo("pending") == 0) {
      return Colors.lightBlue;
    } else {
      return Colors.red;
    }
  }
}
