import 'package:flutter/material.dart';
import 'package:swp409/Services/Booking/medical_record.dart';
import 'package:table_calendar/table_calendar.dart';

class Booking extends StatefulWidget {
  @override
  _BookingState createState() => _BookingState();
}

List hours = [
  '9:30',
  '10:00',
  '10:30',
  '11:00',
  '11:30',
  '12:00',
  '12:30',
  '13:00',
  '13:30',
  '14:00',
  '14:30',
  '15:00',
  '15:30',
  '16:00',
  '16:30',
  '17:00',
];

class _BookingState extends State<Booking> {
  CalendarController _calendarController;
  @override
  void initState() {
    super.initState();
    _calendarController = CalendarController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pick a date'),
      ),
      body: SafeArea(
        child: Container(
          child: Column(
            children: <Widget>[
              TableCalendar(
                initialCalendarFormat: CalendarFormat.month,
                calendarController: _calendarController,
                startingDayOfWeek: StartingDayOfWeek.monday,
                calendarStyle: CalendarStyle(
                  highlightSelected: true,
                  highlightToday: true,
                ),
              ),
              Expanded(
                flex: 1,
                child: Card(
                  child: GridView.builder(
                      itemCount: hours.length,
                      gridDelegate:
                          new SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 5),
                      itemBuilder: (BuildContext context, int index) {
                        return new GestureDetector(
                            onTap: () => print('${hours[index]}'),
                            child: Center(
                                child: new Text(
                              hours[index],
                              style: TextStyle(fontSize: 18),
                            )));
                      }),
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
                            MaterialStateProperty.all<Color>(Colors.blue)),
                    child:
                        Text('Continue', style: TextStyle(color: Colors.white)),
                    onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => MedicalRecords(
                                calendarController: _calendarController))),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
