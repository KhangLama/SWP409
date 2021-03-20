
import 'package:flutter/material.dart';
import 'package:swp409/Interface/Home/homePage.dart';

class ClinicPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          leading: BackButton(onPressed: () {runApp(HomePage());}),
          title: Text('Back'),
        ),
        body: SafeArea(
          child: Container(
            margin: EdgeInsets.only(left: 15, right: 10),
            child: Column(
              children: [
                ListBody(
                  children: [
                    Image(image: NetworkImage('https://m.phongkhamcantho.vn/modules/baotri-tkm/img/tt_3.png')),
                    Center(child: Text('Phòng Khám Đa Khoa Cần Thơ',style: TextStyle(fontSize: 28),)),
                    Center(child: Text('Address: 133A Trần Hưng Đạo, P. An Phú, Q. Ninh Kiều, Tp. Cần Thơ',style: TextStyle(fontSize: 24),))

                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
