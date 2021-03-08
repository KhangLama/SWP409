import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:swp409/homePage.dart';
import 'package:swp409/profilePage.dart';
import 'package:swp409/calendarPage.dart';
import 'package:swp409/navigation_bar_controller.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  List<GlobalKey<NavigatorState>> _navigatorKeys = [
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>()
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          actions: <Widget>[
            IconButton(icon: Icon(Feather.message_square), onPressed: (){})
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
                icon: new Icon(Feather.info, color: Colors.grey),
                label: new Text('Profile').toString(),
                activeIcon: new Icon(
                  Feather.info,
                  color: Colors.orange,
                )
            ),
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
            CalendarPage(),
            ProfilePage(),
          ],
        ),
      ),
    );
  }
}
