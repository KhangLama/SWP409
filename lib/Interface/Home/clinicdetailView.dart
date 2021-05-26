import 'package:flutter/material.dart';
import 'package:swp409/Services/Booking/booking.dart';
import 'package:swp409/constants.dart';

class ClinicPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Clinic\'s information'),
        backgroundColor: kPrimaryAppbar,
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
                              'https://lh5.googleusercontent.com/p/AF1QipNfMT9alf72auaXkafqbtfY51b-5Z0qzHBWEPsv=w408-h306-k-no',
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
                              child: Text('Phòng khám bác sĩ Tiêu Phương Lâm',
                                  style: TextStyle(fontSize: 20)),
                            ),
                            SizedBox(height: 10),
                            Center(
                              child: Text(
                                  '85A Đường Nguyễn Văn Cừ, An Bình, Ninh Kiều, Cần Thơ',
                                  style: TextStyle(
                                    fontSize: 20,
                                  )),
                            ),
                            SizedBox(height: 10),
                            Text('Doctor: Tiêu Phương Lâm',
                                style: TextStyle(fontSize: 20)),
                            SizedBox(height: 10),
                            Text(
                              'Contact: 02923740999',
                              style: TextStyle(fontSize: 20),
                            ),
                            Row(
                              children: [
<<<<<<< Updated upstream
                                ElevatedButton(
                                    onPressed: () {},
                                    child: Text('View on map')),
=======
                                Icon(Icons.description_outlined, color: Colors.black),
                                SizedBox(width: 5),
                                Expanded(
                                  child: Text(
                                      'Description: Phòng khám xịn xò nhất đất nước Việt Nam',
                                      style: TextStyle(
                                        fontSize: 20,
                                      )),
                                ),
                              ],
                            ),
                            SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    primary: kPrimaryColor, // background
                                    onPrimary: Colors.white,
                                    textStyle: TextStyle(
                                      fontSize: 17,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    minimumSize: Size(180,50),
                                    shape: new RoundedRectangleBorder(
                                        borderRadius:
                                        new BorderRadius.all(Radius.circular(15))),// foreground
                                  ),
                                  onPressed: () { },
                                  child: Text('View on map'),
                                ),
                                SizedBox(width: 10),
                                ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      primary: kPrimaryColor, // background
                                      onPrimary: Colors.white,
                                      textStyle: TextStyle(
                                        fontSize: 17,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      minimumSize: Size(180,50),
                                      shape: new RoundedRectangleBorder(
                                          borderRadius:
                                          new BorderRadius.all(Radius.circular(15))),// foreground
                                    ),
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => Booking()),
                                      );
                                    },
                                    child: Text('Book now')),
>>>>>>> Stashed changes
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
