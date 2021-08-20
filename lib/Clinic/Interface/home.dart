import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:swp409/Clinic/Interface/ReviewComment/reiview_cmt.dart';
import 'package:swp409/Interface/Home/clinicListView.dart';
import 'package:swp409/Models/clinic.dart';
import 'package:swp409/Models/user.dart';
import 'package:swp409/Services/ApiService/clinic_service.dart';
import 'package:swp409/Services/Controller/navigation_bar_controller.dart';
import 'package:swp409/constants.dart';

import 'Appointment/appointment.dart';
import 'ListCustomerAppointment/list_customer_appointment.dart';
import 'Profile/profile.dart';

class HomeScreenDoctor extends StatefulWidget {
  User user;
  List<String> cookies;
  HomeScreenDoctor.user({Key key, this.user, this.cookies}) : super(key: key);
  @override
  _HomeScreenDoctorState createState() => _HomeScreenDoctorState();
}

class _HomeScreenDoctorState extends State<HomeScreenDoctor> {
  int _selectedIndex = 0;

  final List<GlobalKey<NavigatorState>> _navigatorKeys = [
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
  ];
  Future loading;
  User _user = new User();
  List<String> _cookies;
  ClinicService _clinicService = new ClinicService();
  Clinic _clinic = new Clinic();

  @override
  void initState() {
    _cookies = widget.cookies;
    _user = widget.user;

    print("home");
    super.initState();
  }

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
                  icon: Icon(Feather.shopping_bag, color: Colors.grey),
                  label: Text('Appointment').toString(),
                  activeIcon: Icon(
                    Feather.shopping_bag,
                    color: Colors.orange,
                  )),
              BottomNavigationBarItem(
                  icon: Icon(Feather.message_square, color: Colors.grey),
                  label: Text('Review  comment').toString(),
                  activeIcon: Icon(
                    Feather.message_square,
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
            pages: <Widget>[
              ListCustomerAppointment.user(user: _user, cookies: _cookies),
              Appointment(cookies: _cookies),
              ReviewCmtScreen(user: _user, cookies: _cookies),
              ClinicProfile(user: _user, cookies: _cookies),
            ],
          ),
        ));
  }
}
