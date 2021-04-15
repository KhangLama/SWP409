import 'package:flutter/material.dart';
import 'package:swp409/Services/Booking/addMedicalRecord.dart';

class HistoryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Choose a medical record'),
        ),
        body: Historybody());
  }
}

class Historybody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        child: Column(
          children: [
            Text(
              'It seem like you do not have any medical records',
              style: TextStyle(fontSize: 18),
            ),
            Text('Please create one'),
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
    );
  }
}
