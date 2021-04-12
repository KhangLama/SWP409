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
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          leading: BackButton(onPressed: () => Navigator.pop(context)),
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
                    child: ListTile(
                      title: Text('Time'),
                      subtitle: GridView.count(
                        crossAxisCount: 3,
                        children: List.generate(hours.length, (index) {
                          return Center(
                            child: Text('[${hours[index]}]',
                                style: Theme.of(context).textTheme.headline6),
                          );
                        }),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 0,
                    child: SizedBox(
                      height: 40,
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(Colors.blue)
                        ),
                        child: Text('Make an appointment', style: TextStyle(
                          color: Colors.white
                        )),
                      ),
                    )
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
