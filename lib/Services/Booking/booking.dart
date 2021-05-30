import 'package:flutter/material.dart';
import 'package:swp409/Services/Booking/medical_record.dart';
import 'package:swp409/constants.dart';
import 'package:table_calendar/table_calendar.dart';

class Booking extends StatefulWidget {
  @override
  _BookingState createState() => _BookingState();
}

int checkedIndex = 0;

class _BookingState extends State<Booking> {
  CalendarController _calendarController;

  var gridviewcontroller;
  @override
  void initState() {
    super.initState();
    _calendarController = CalendarController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          onPressed: () => Navigator.pop(context),
          color: kPrimaryLightColor,
        ),
        title: Text('Pick a date',
          style: TextStyle(color: kPrimaryLightColor) ,),
        backgroundColor: kPrimaryAppbar,
      ),
      body: SafeArea(
        child: Container(
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(14.0),
                child: TableCalendar(
                  initialCalendarFormat: CalendarFormat.month,
                  calendarController: _calendarController,
                  startDay: DateTime.now(),
                  startingDayOfWeek: StartingDayOfWeek.monday,
                  calendarStyle: CalendarStyle(
                      highlightSelected: true,
                      highlightToday: true,
                      todayColor: Colors.orangeAccent[100],
                      todayStyle: TextStyle(color: Colors.black),
                      selectedColor: Colors.orangeAccent[400],
                      selectedStyle: TextStyle(color: Colors.black)),
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
              // Expanded(
              //   flex: 1,
              //   child: Padding(
              //     padding: const EdgeInsets.all(14.0),
              //     child: Card(
                    // child: GridView.builder(
                    //     itemCount: hours.length,
                    //     controller: gridviewcontroller,
                    //     gridDelegate:
                    //         new SliverGridDelegateWithFixedCrossAxisCount(
                    //             crossAxisCount: 5),
                    //     itemBuilder: (BuildContext context, int index) {
                    //       return _buildGridItem(index);
                    //     }),
    
                  //),
              //   ),
              // ),
              Expanded(
                flex: 0,
                child: SizedBox(
                  height: 40,
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(kPrimaryColor)),
                    child:
                        Text('Continue', style: TextStyle(color: kPrimaryLightColor)),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => MedicalRecords(
                                  calendarController: _calendarController)));
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
