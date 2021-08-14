import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:swp409/Interface/Home/mainScreen.dart';
import 'package:swp409/Models/clinic.dart';
import 'package:swp409/Models/user.dart';
import 'package:swp409/Services/ApiService/user_service.dart';
import 'package:swp409/constants.dart';
import 'package:table_calendar/table_calendar.dart';

class Booking extends StatefulWidget {
  List<String> cookies;
  Clinic clinic;
  User user;
  Booking({Key key, this.clinic, this.user, this.cookies}) : super(key: key);
  @override
  _BookingState createState() => _BookingState();
}

int checkedIndex = 0;

class _BookingState extends State<Booking> {
  var gridviewcontroller;
  UserService _userService = new UserService();
  DateTime _selectedDay = DateTime.now();
  DateTime _focusDay = DateTime.now();
  CalendarFormat _calendarFormat = CalendarFormat.month;
  User _user = new User();
  Clinic _clinic = new Clinic();
  List<String> _cookies;
  Dio dio = new Dio();

  @override
  void initState() {
    super.initState();

    setState(() {
      _user = widget.user;
      _clinic = widget.clinic;
      _cookies = widget.cookies;
      print(_clinic.id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          onPressed: () => Navigator.pop(context),
          color: kPrimaryLightColor,
        ),
        title: Text(
          'Pick a date',
          style: TextStyle(color: kPrimaryLightColor),
        ),
        backgroundColor: kPrimaryAppbar,
      ),
      body: SafeArea(
        child: Container(
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(14.0),
                child: TableCalendar(
                  firstDay: DateTime.now(),
                  focusedDay: _focusDay,
                  lastDay: DateTime.utc(2040),
                  startingDayOfWeek: StartingDayOfWeek.monday,
                  daysOfWeekVisible: true,
                  calendarFormat: _calendarFormat,

                  //day changed
                  selectedDayPredicate: (DateTime date) {
                    return isSameDay(_selectedDay, date);
                  },
                  onDaySelected: (selectedDay, focusedDay) {
                    setState(() {
                      _selectedDay = selectedDay;
                      _focusDay = focusedDay;
                    });
                  },

                  //Styling
                  onFormatChanged: (CalendarFormat format) {
                    setState(() {
                      _calendarFormat = format;
                    });
                  },
                  calendarStyle: CalendarStyle(
                      todayDecoration: BoxDecoration(
                          color: Colors.purpleAccent, shape: BoxShape.circle),
                      isTodayHighlighted: true,
                      selectedDecoration: BoxDecoration(
                          color: Colors.blue, shape: BoxShape.circle),
                      selectedTextStyle: TextStyle(color: Colors.white)),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(8, 0, 30, 6),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: kPrimaryColorLight, // background
                    onPrimary: kPrimaryLightColor, // foreground
                  ),
                  onPressed: _selectTime,
                  child: Text(select_time.format(context)),
                ),
              ),
              Expanded(
                flex: 0,
                child: SizedBox(
                  height: 40,
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(kPrimaryColor)),
                    child: Text('Continue',
                        style: TextStyle(color: kPrimaryLightColor)),
                    onPressed: () {
                      var time = select_time.hour * 60 + select_time.minute;

                      String url = "$ServerIP/api/v1/bookings/${_clinic.id}";

                      _userService
                          .booking(url, time, _selectedDay, _cookies)
                          .then((value) {
                        if (value.data['status'] == 'success') {
                          print(value.data);
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => MainScreen.user(
                                    user: _user,
                                    cookies: _cookies,
                                  )));
                        }
                      });
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  TimeOfDay select_time = TimeOfDay(hour: 7, minute: 00);

  void _selectTime() async {
    final TimeOfDay newTime = await showTimePicker(
      context: context,
      initialTime: select_time,
      initialEntryMode: TimePickerEntryMode.input,
    );
    if (newTime != null) {
      setState(() {
        select_time = newTime;
      });
    }
  }

//   Widget _buildGridItem(int index) {
//     bool checked = index == checkedIndex;
//     return new GestureDetector(
//         onTap: () {
//           setState(() {
//             checkedIndex = index;
//           });
//         },
//         child: Center(
//             child: SizedBox(
//           height: 40,
//           width: 120,
//           child: Card(
//             elevation: 5.0,
//             color: checked ? Colors.orange : Colors.white,
//             child: Center(
//               child: new Text(
//                 hours[index],
//                 style: TextStyle(fontSize: 18),
//               ),
//             ),
//           ),
//         )));
//   }
}
