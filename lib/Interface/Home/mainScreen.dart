import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:swp409/Interface/History/historyPage.dart';
import 'package:swp409/Interface/Maps/mapViewPage.dart';
import 'package:swp409/Interface/Message/messagePage.dart';
import 'package:swp409/Services/Controller/navigation_bar_controller.dart';
import 'homePage.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  final List<GlobalKey<NavigatorState>> _navigatorKeys = [
    GlobalKey<NavigatorState>(),
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
                icon: Icon(Feather.mail, color: Colors.grey),
                label: Text('Message').toString(),
                activeIcon: Icon(
                  Feather.mail,
                  color: Colors.orange,
                )),
            BottomNavigationBarItem(
                icon: Icon(MaterialCommunityIcons.google_maps,
                    color: Colors.grey),
                label: Text('Map').toString(),
                activeIcon: Icon(
                  MaterialCommunityIcons.google_maps,
                  color: Colors.orange,
                )),
            BottomNavigationBarItem(
                icon: Icon(Feather.calendar, color: Colors.grey),
                label: Text('Calendar').toString(),
                activeIcon: Icon(
                  Feather.calendar,
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
            MapViewPage(),
            HistoryPage(),
          ],
        ),
      ),
    );
  }
}
