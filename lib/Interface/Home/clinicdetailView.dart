import 'package:flutter/material.dart';
import 'package:swp409/Services/Booking/booking.dart';

class ClinicPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Back'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.only(left: 15, right: 10),
            child: Column(
              children: [
                ListBody(
                  children: [
                    Center(
                      child: Image(
                          image: NetworkImage(
                              'https://m.phongkhamcantho.vn/modules/baotri-tkm/img/tt_3.png',
                              scale: 0.9)),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Information',
                      style: TextStyle(color: Colors.blueAccent, fontSize: 15),
                    ),
                    Card(
                      shadowColor: Colors.black,
                      child: Center(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Center(
                              child: Text('Phòng Khám Đa Khoa Cần Thơ',
                                  style: TextStyle(fontSize: 20)),
                            ),
                            SizedBox(height: 10),
                            Center(
                              child: Text(
                                  '133A Trần Hưng Đạo, P. An Phú, Q. Ninh Kiều, Tp. Cần Thơ',
                                  style: TextStyle(
                                    fontSize: 20,
                                  )),
                            ),
                            SizedBox(height: 10),
                            Text('Doctor: Khang Lmao',
                                style: TextStyle(fontSize: 20)),
                            SizedBox(height: 10),
                            Text(
                              'Contact: 0948397339\nEmail: lamminhkhang123a@gmail.com \nWebsite: phongkham.com',
                              style: TextStyle(fontSize: 20),
                            ),
                            Row(
                              children: [
                                ElevatedButton(
                                    onPressed: () {},
                                    child: Text('View on map')),
                                SizedBox(width: 15),
                                ElevatedButton(
                                    onPressed: () {}, child: Text('Chat')),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Booking()),
                            );
                          },
                          child: Text('Book an appointment')),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
