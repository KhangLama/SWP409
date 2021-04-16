import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:swp409/Interface/Profile/profilePage.dart';
import 'package:swp409/Services/Authentication/splash/splash_screen.dart';
import 'package:swp409/Services/Booking/booking.dart';
import 'clinicView.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var clinicList = [];

  void getClinic() async {
    var data = await rootBundle.loadString('assets/json/clinic.mock.json');
    clinicList = json.decode(data)['Clinic'] as List;
  }

  @override
  void initState() {
    super.initState();
    getClinic();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.tealAccent,
      drawer: SideDrawer(),
      appBar: AppBar(title: Text('Find Clinic You Want')),
      body: SafeArea(
        child: Container(
          child: ListView.builder(
              scrollDirection: Axis.vertical,
              itemCount: clinicList.length,
              itemBuilder: (context, index) {
                return new Card(
                  child: Column(
                    children: [
                      ListTile(
                          onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ClinicPage())),
                          title: clinicList[index]['name']),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Booking()),
                          );
                        },
                        child: Text('Book an appointment'),
                      ),
                    ],
                  ),
                );
              }),
        ),
      ),
    );
  }
}

class SideDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          DrawerHeader(
            child: Center(
              child: Text(
                'Side menu  FlutterCorner',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white, fontSize: 25),
              ),
            ),
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text('Home'),
            onTap: () => {},
          ),
          ListTile(
            leading: Icon(Icons.shopping_cart),
            title: Text('Cart'),
            onTap: () => {Navigator.of(context).pop()},
          ),
          ListTile(
            leading: Icon(Icons.border_color),
            title: Text('Feedback'),
            onTap: () => {Navigator.of(context).pop()},
          ),
          ListTile(
            leading: Icon(Icons.person_rounded),
            title: Text('Profile'),
            onTap: () => {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ProfilePage()))
            },
          ),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text('Logout'),
            onTap: () => runApp(SplashScreen()),
          ),
        ],
      ),
    );
  }
}
