import 'package:flutter/material.dart';
import 'package:swp409/constants.dart';
import 'package:table_calendar/table_calendar.dart';

import 'addMedicalRecord.dart';

class MedicalRecords extends StatelessWidget {
  final CalendarController calendarController;

  const MedicalRecords({Key key, this.calendarController}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Medical Records'),
        backgroundColor: kPrimaryAppbar,
      ),
      body: SafeArea(
        child: Container(
          child: Column(
            children: [
              Text(
                'It seem like you do not have any medical records',
                style: TextStyle(fontSize: 18),
              ),
              Text('Please create one'),
              Text('${calendarController.selectedDay.toString()}'),
              Expanded(
                child: Align(
                    alignment: FractionalOffset.bottomCenter,
                    child: ElevatedButton(
                        onPressed: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => AddMedicalRecord())),
                        child: Text('Create new medical record'))),
              )
            ],
          ),
        ),
      ),
    );
  }
}
