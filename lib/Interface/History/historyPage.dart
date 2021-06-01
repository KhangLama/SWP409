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
  List<Booking> _bookings;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _user = widget.user;
    _cookies = widget.cookies;
    fetchBookings().then((value) => _bookings = value);
    print(_bookings.length);
    print(_bookings[0].toJson());
  }

  Future<List<Booking>> fetchBookings() async {
    String url = '$ServerIP/api/v1/bookings/${_user.sId}';
    var fetchdata = await _userService.getHistory(url, _cookies);
    print(fetchdata.data);
    var bookings = <Booking>[];
    var bookingsjson = fetchdata.data['data']['data'] as List;
    for (var clinic in bookingsjson) {
      bookings.add(Booking.fromJson(clinic));
    }
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
          child: SingleChildScrollView(
            child: Column(
              children: [
                buildList(_bookings),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildList(List<Booking> _bookings) {
    return ListView.builder(
      itemCount: _bookings.length,
          itemBuilder:(context, index) => Container(
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
                              Icon(Feather.navigation,
                                  color: Colors.black, size: 17),
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
