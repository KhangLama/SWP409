import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class Booking extends StatefulWidget {
  @override
  _BookingState createState() => _BookingState();
}

List hours = [
  '9:30',
  '9:30',
  '9:30',
  '9:30',
  '9:30',
  '9:30',
  '9:30',
  '9:30',
  '9:30',
  '9:30',
  '9:30',
  '9:30',
  '9:30',
  '9:30'
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
                initialCalendarFormat: CalendarFormat.week,
                calendarController: _calendarController,
                startingDayOfWeek: StartingDayOfWeek.monday,
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
                            onTap: () => {
                              TextStyle(
                                backgroundColor: Colors.green
                              )
                            },
                            child: Center(
                                child: new Text(
                                  
                              hours[index],
                              style: TextStyle(fontSize: 17),
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
                            builder: (context) => MedicalRecords())),
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

class MedicalRecords extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Medical Records'),
      ),
    );
  }
}
