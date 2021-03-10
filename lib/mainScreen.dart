import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:swp409/homePage.dart';
import 'package:swp409/profilePage.dart';
import 'package:swp409/calendarPage.dart';
import 'package:swp409/navigation_bar_controller.dart';
import 'package:swp409/messagePage.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  List<GlobalKey<NavigatorState>> _navigatorKeys = [
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
  ];
  String _abc = 'Khang';
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          leading: Text(
            'Hello\n$_abc',
            style: TextStyle(fontSize: 20),
          ),
          
          leadingWidth: 70,
          titleSpacing: 20,
          actions: <Widget>[
            IconButton(icon: Icon(Feather.bell), onPressed: () {})
          ],
        ),
        backgroundColor: Colors.white,
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: _selectedIndex,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          items: [
            new BottomNavigationBarItem(
                icon: new Icon(Feather.home, color: Colors.grey),
                label: new Text('Home').toString(),
                activeIcon: new Icon(
                  Feather.home,
                  color: Colors.orange,
                )),
            new BottomNavigationBarItem(
                icon: new Icon(Feather.mail, color: Colors.grey),
                label: new Text('Message').toString(),
                activeIcon: new Icon(
                  Feather.mail,
                  color: Colors.orange,
                )),
            new BottomNavigationBarItem(
                icon: new Icon(Feather.calendar, color: Colors.grey),
                label: new Text('Calendar').toString(),
                activeIcon: new Icon(
                  Feather.calendar,
                  color: Colors.orange,
                )),
            new BottomNavigationBarItem(
                icon: new Icon(Feather.user, color: Colors.grey),
                label: new Text('Profile').toString(),
                activeIcon: new Icon(
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
            HomePage(),
            MessagePage(),
            CalendarPage(),
            ProfilePage(),
          ],
        ),
      ),
    );
  }
}
