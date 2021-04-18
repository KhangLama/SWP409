import 'package:flutter/material.dart';
import 'package:swp409/Services/Booking/addMedicalRecord.dart';
import 'package:swp409/constants.dart';

import '../../size_config.dart';

class HistoryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: kPrimaryColor,
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
                      style: ElevatedButton.styleFrom(
                        primary: kPrimaryColor,
                        textStyle: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
<<<<<<< HEAD
                        minimumSize: Size(350, 65),
=======
                        minimumSize: Size(double.infinity,getProportionateScreenHeight(50)),
>>>>>>> feature/trinhhq
                        shape: new RoundedRectangleBorder(
                            borderRadius:
                                new BorderRadius.all(Radius.circular(20))),
                      ),
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
