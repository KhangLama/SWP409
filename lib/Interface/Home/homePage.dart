import 'package:flutter/material.dart';
import 'package:swp409/Interface/Profile/profilePage.dart';
import 'package:swp409/Services/Authentication/splash/splash_screen.dart';
import 'clinicView.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.tealAccent,
        drawer: SideDrawer(),
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
                        subtitle: Text(
                            '133A Trần Hưng Đạo, P. An Phú, Q. Ninh Kiều, Tp. Cần Thơ'),
                        dense: true,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ClinicPage()),
                          );
                        },
                      ),
                    ],
                  ),
                  semanticContainer: true,
                ),
              ],
            ),
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
