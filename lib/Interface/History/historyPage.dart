import 'package:flutter/material.dart';
import 'package:swp409/constants.dart';

class HistoryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: kPrimaryAppbar,
          title: Text('Histories Booking'),
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
              'It seem like you does not have any appoinment yet',
              style: TextStyle(fontSize: 18),
            ),
            Text('Please create one'),
            Expanded(
              child: Align(
                  alignment: FractionalOffset.bottomCenter,
                  child: Container(
                    margin: const EdgeInsets.only(left: 1, right: 1, bottom: 5),
                    // child: ElevatedButton(
                    //     style: ElevatedButton.styleFrom(
                    //       primary: kPrimaryColor,
                    //       textStyle: TextStyle(
                    //         fontSize: 20,
                    //         color: Colors.white,
                    //         fontWeight: FontWeight.bold,
                    //       ),
                    //       minimumSize: Size(double.infinity,getProportionateScreenHeight(50)),
                    //       shape: new RoundedRectangleBorder(
                    //           borderRadius:
                    //               new BorderRadius.all(Radius.circular(15))),
                    //     ),
                    //     onPressed: () => Navigator.push(
                    //         context,
                    //         MaterialPageRoute(
                    //             builder: (context) => AddMedicalRecord())),
                    //     child: Text('Create new medical record')),
                  )),
            )
          ],
        ),
      ),
    );
  }
}
