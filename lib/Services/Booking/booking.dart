import 'package:flutter/material.dart';
import 'package:swp409/Interface/Home/clinicView.dart';
import 'package:table_calendar/table_calendar.dart';

class Booking extends StatefulWidget {
  @override
  _BookingState createState() => _BookingState();
}

class _BookingState extends State<Booking> {
  CalendarController _calendarController;
  @override
  void initState() {
    super.initState();
    _calendarController = CalendarController();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          leading: BackButton(onPressed: () => runApp(ClinicPage())),
        ),
        body: SafeArea(
          child: Expanded(
            child: Column(
              children: <Widget>[
                TableCalendar(
                  initialCalendarFormat: CalendarFormat.week,
                  calendarController: _calendarController,
                  startingDayOfWeek: StartingDayOfWeek.monday,
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
