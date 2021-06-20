import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:swp409/Models/user.dart';

// ignore: must_be_immutable
class GuideHome extends StatefulWidget {
  List<String> cookies;
  User user;
  GuideHome.user({Key key, this.user, this.cookies}) : super(key: key);
  @override
  _GuideHomeState createState() => _GuideHomeState();
}

class _GuideHomeState extends State<GuideHome> {
  int _selectedIndex = 0;
  User _user = new User();
  List<String> _cookies;
  final List<GlobalKey<NavigatorState>> _navigatorKeys = [
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
  ];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _user = widget.user;
    _cookies = widget.cookies;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(

        ),
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
        body: SafeArea(

        ),
      ),
    );
  }
}
