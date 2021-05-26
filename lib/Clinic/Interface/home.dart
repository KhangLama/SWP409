import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:swp409/Services/Controller/navigation_bar_controller.dart';

import 'Appointment/appointment.dart';
import 'ListCustomerAppointment/list_customer_appointment.dart';
import 'Profile/profile.dart';

class HomeScreenDoctor extends StatefulWidget {
  FlutterSecureStorage storage;
  HomeScreenDoctor(this.storage);

  @override
  _HomeScreenDoctorState createState() => _HomeScreenDoctorState();
}

class _HomeScreenDoctorState extends State<HomeScreenDoctor> {
  int _selectedIndex = 0;

  final List<GlobalKey<NavigatorState>> _navigatorKeys = [
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.white,
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: _selectedIndex,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          items: [
            BottomNavigationBarItem(
                icon: Icon(Feather.home, color: Colors.grey),
                label: Text('Home').toString(),
                activeIcon: Icon(
                  Feather.home,
                  color: Colors.orange,
                )),
            BottomNavigationBarItem(
                icon: Icon(Feather.calendar, color: Colors.grey),
                label: Text('Appointment').toString(),
                activeIcon: Icon(
                  Feather.calendar,
                  color: Colors.orange,
                )),
            BottomNavigationBarItem(
                icon: Icon(Feather.user, color: Colors.grey),
                label: Text('Profile').toString(),
                activeIcon: Icon(
                  Feather.user,
                  color: Colors.orange,
                )),
          ],
          onTap: (index) {
            setState(() {
              _selectedIndex = index;
            });
          },
        ),
        body: CommonBottomNavigationBar(
          selectedIndex: _selectedIndex,
          navigatorKeys: _navigatorKeys,
          pages: [
            ListCustomerAppointment(),
            Appointment(),
            ClinicProfile(),
          ],
        ),
      ),
    );
  }
}
