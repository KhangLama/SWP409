import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:swp409/Interface/Home/mainScreen.dart';
import 'package:swp409/Interface/Profile/components/body.dart';
import 'package:swp409/Models/clinic.dart';
import 'package:swp409/Models/user.dart';
import 'package:swp409/Services/ApiService/user_service.dart';
import 'package:swp409/constants.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../size_config.dart';

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
      bottomNavigationBar: BottomAppBar(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: kPrimaryColor,
                    // background
                    onPrimary: Colors.white,
                    textStyle: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                    minimumSize: Size(SizeConfig.screenWidth - 40, 60),
                    shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.all(
                            Radius.circular(10))), // foreground
                  ),
                  onPressed: () {
                    var time = select_time.hour * 60 + select_time.minute;
                    List<WorkingHours> list =
                        getDayOfWeek(_clinic, _selectedDay);
                    bool check = list.length == 0 ? true : false;
                    for (int i = 0; i < list.length; i++) {
                      if (list[i].startTime <= time &&
                          list[i].endTime >= time) {
                        break;
                      } else {
                        check = true;
                      }
                    }

                    if (check) {
                      toastFail(
                          "Your picking time is not in working hours to day!");
                    } else {
                      String url = "$ServerIP/api/v1/bookings/${_clinic.id}";

                      _userService
                          .booking(url, time, _selectedDay, _cookies)
                          .then((value) {
                        if (value.data['status'] == 'success') {
                          toast("Successfully");
                          print(value.data);
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => MainScreen.user(
                                    user: _user,
                                    cookies: _cookies,
                                  )));
                        } else if (value.data['message'] ==
                            "Unable to book an appointment. You have a pending request.") {
                          toastFail(
                              "Unable to book an appointment. You have a pending request.");
                        }
                      });
                    }
                  },
                  child: Text('Book apointment now')),
            ],
          ),
        ),
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
              Row(
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(20, 5, 10, 5),
                    child: Text(
                      "Pick a time:",
                      style: TextStyle(fontSize: 20, color: Colors.black),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(10, 5, 20, 5),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: kPrimaryColorLight, // background
                        onPrimary: kPrimaryLightColor, // foreground
                      ),
                      onPressed: _selectTime,
                      child: Text(select_time.format(context)),
                    ),
                  ),
                ],
              )
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

  List<WorkingHours> getDayOfWeek(Clinic clinic, DateTime date) {
    int checkDate = 0;
    if (date.weekday == 7) {
      checkDate = 0;
    } else {
      checkDate = date.weekday;
    }
    return clinic.schedule[checkDate].workingHours;
  }
}
