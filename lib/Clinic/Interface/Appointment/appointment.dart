import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:swp409/Models/booking.dart';
import 'package:swp409/Services/ApiService/clinic_service.dart';
import 'package:intl/intl.dart';
import '../../../constants.dart';

// ignore: must_be_immutable
class Appointment extends StatefulWidget {
  List<String> cookies;
  Appointment({Key key, this.cookies}) : super(key: key);
  @override
  _AppointmentState createState() => _AppointmentState();
}

class _AppointmentState extends State<Appointment> {
  List<String> _cookies;

  @override
  void initState() {
    _cookies = widget.cookies;
    fetchBookingsStats().then((value) {
      setState(() {
        _booking = value;
      });
    });
    print("lengthh: ${_booking.length}");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
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
          child: buildList(),
        ),
      ),
    );
  }

  Widget buildList() {
    return ListView.builder(
      itemCount: _booking.length,
      itemBuilder: (context, index) => Container(
        width: MediaQuery.of(context).size.width,
        child: GestureDetector(
          child: Card(
              margin: const EdgeInsets.only(
                  top: 5.0, bottom: 10.0, left: 10.0, right: 10.0),
              child: Padding(
                padding: const EdgeInsets.only(
                    top: 20, bottom: 20, left: 0, right: 16),
                child: Row(
                  children: [
                    Image(
                      image: NetworkImage(_booking[index].user.avatar.url),
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
                                _booking[index].user.name,
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
                              Icon(Feather.clock,
                                  color: Colors.black, size: 17),
                              SizedBox(width: 10),
                              Text(
                                '${DateFormat('yyyy-MM-dd').format(_booking[index].bookedDate)}, ${(_booking[index].bookedTime ~/ 60).toString().padLeft(2, '0')}:${(_booking[index].bookedTime % 60).toInt().toString().padLeft(2, '0')}',
                                style: TextStyle(fontSize: 17),
                              ),
                            ],
                          ),
                          SizedBox(height: 5),
                          Row(
                            children: [
                              Icon(Feather.mail, color: Colors.black, size: 17),
                              SizedBox(width: 10),
                              Text(
                                _booking[index].user.email,
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
                                _booking[index].user.phone,
                                style: TextStyle(fontSize: 17),
                              )
                            ],
                          ),
                          SizedBox(height: 5),
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

  List<Booking> _booking = <Booking>[];
  String urlGetBookingStats = "$ServerIP/api/v1/bookings/users";
  ClinicService _clinicService = new ClinicService();
  Future<List<Booking>> fetchBookingsStats() async {
    var fetched =
        await _clinicService.getBookingsOfClinic(urlGetBookingStats, _cookies);
    var list = <Booking>[];
    print(urlGetBookingStats);
    var bookings = fetched.data['data']['data'] as List;
    print('booking json');
    for (var booking in bookings) {
      Booking checkBookApproved = Booking.fromJson(booking);
      if (checkBookApproved.status == 'approved') {
        list.add(new Booking.fromJson(booking));
      }
    }
    return list;
  }
}
