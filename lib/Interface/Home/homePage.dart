import 'package:flutter/material.dart';

import 'clinicView.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.tealAccent,
        appBar: AppBar(title: Text('Find Clinic You Want')),
        body: SafeArea(
          child: Container(

            margin: EdgeInsets.all(10),
            child: Column(
              children: <Widget>[
                 Card(
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    margin: EdgeInsets.all(10),
                    elevation: 10,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        ListTile(
                          leading: Image.asset(
                            'images/wallpaper.jpg',
                            height: 240,
                            fit: BoxFit.fill,
                          ),
                          title: Text('Phòng Khám Đa Khoa Cần Thơ'),
                          subtitle: Text('133A Trần Hưng Đạo, P. An Phú, Q. Ninh Kiều, Tp. Cần Thơ'),
                          dense: true,

                        ),
                        RaisedButton(onPressed: () {
                          runApp(ClinicPage());
                        },)
                      ],
                    ),
                    semanticContainer: true,
                  ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
