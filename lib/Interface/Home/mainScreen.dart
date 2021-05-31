import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:swp409/Interface/History/historyPage.dart';
import 'package:swp409/Interface/Maps/mapViewPage.dart';
import 'package:swp409/Models/user.dart';
import 'package:swp409/Services/Controller/navigation_bar_controller.dart';
import 'clinicListView.dart';

// ignore: must_be_immutable
class MainScreen extends StatefulWidget {
  List<String> cookies;
  User user;
  MainScreen.user({Key key, this.user, this.cookies}) : super(key: key);
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
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
            ClinicListView.user(user: widget.user, cookies: widget.cookies),
            MapViewPage(),
            HistoryPage(),
          ],
        ),
      ),
    );
  }
}
