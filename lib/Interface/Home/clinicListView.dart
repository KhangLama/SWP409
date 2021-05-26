import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:swp409/Interface/Profile/profilePage.dart';
import 'package:swp409/Models/clinic.dart';
import 'package:swp409/Models/user.dart';
import 'package:swp409/Services/Authentication/splash/splash_screen.dart';
import 'package:swp409/Services/Booking/booking.dart';
import 'package:swp409/constants.dart';
import 'clinicdetailView.dart';
import '../../constants.dart';
import 'package:dio/dio.dart';

// ignore: must_be_immutable
class ClinicListView extends StatefulWidget {
  FlutterSecureStorage storage;
  User user;
  ClinicListView(this.storage);
  ClinicListView.user(this.user);
  @override
  _ClinicListViewState createState() => _ClinicListViewState();
}

class _ClinicListViewState extends State<ClinicListView> {
  User _user = new User();

  @override
  void initState() {
    fetchClinics().then((value) {
      setState(() {
        _clinics = value;
        _filteredclinic = _clinics;
        _user = widget.user;
        print('listview');
        print(_user.toJson());
      });
    });
    //getUserData(widget.storage).then((value) => _user = value);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: kPrimaryBackground,
        drawer: buildDrawer(context),
        appBar: AppBar(
          title: Text(
            'Find Clinic You Want',
            style: TextStyle(color: kPrimaryLightColor),
          ),
          backgroundColor: kPrimaryAppbar,
        ),
        body: SafeArea(
          child: Column(
            children: <Widget>[
              // search bar
              Container(
                margin: const EdgeInsets.only(left: 1, right: 1),
                child: TextField(
                  decoration: InputDecoration(
                    fillColor: Colors.white,
                    filled: true,
                    contentPadding: EdgeInsets.all(8),
                    hintText: 'Search clinic\'s name',
                    suffixIcon: Icon(
                      Icons.search_outlined,
                      color: kPrimaryColor,
                    ),
                    enabledBorder: new OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      borderSide: BorderSide(color: kPrimaryColor, width: 2),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: kPrimaryColor, width: 2),
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    // focusedBorder: OutlineInputBorder(
                    //   borderSide: BorderSide(color: kPrimaryColor),
                    // ),
                  ),
                  onChanged: (text) {
                    setState(() {
                      _filteredclinic = _clinics
                          .where((c) => (c.name.toLowerCase().contains(text) ||
                              c.id.toLowerCase().contains(text)))
                          .toList();
                    });
                  },
                ),
              ),
              Expanded(child: buildListView()),
            ],
          ),
        ));
  }

  Drawer buildDrawer(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          DrawerHeader(
            child: Center(
              child: Text(
                'Hello, ${widget.user.name}',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white, fontSize: 25),
              ),
            ),
            decoration: BoxDecoration(
              color: kPrimaryColor,
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
            onTap: () {
              Navigator.of(context, rootNavigator: true).push(MaterialPageRoute(
                  builder: (context) => ProfilePage.user(user: _user)));
            },
          ),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text('Logout'),
            onTap: () {
              Navigator.of(context, rootNavigator: true).pushReplacement(
                  MaterialPageRoute(builder: (context) => new SplashScreen()));
            },
          ),
        ],
      ),
    );
  }

  // List view of clinic card
  ListView buildListView() {
    return ListView.builder(
        itemCount: _filteredclinic.length,
        itemBuilder: (context, index) {
          return Container(
            width: MediaQuery.of(context).size.width,
            child: GestureDetector(
              onTap: () => Navigator.of(context, rootNavigator: true)
                  .push(MaterialPageRoute(
                  builder: (context) => ClinicPage())),
              child: Card(
                  margin: const EdgeInsets.only(
                      top: 5.0, bottom: 10.0, left: 10.0, right: 10.0),
                  child: Padding(
                    padding: const EdgeInsets.only(
                        top: 20, bottom: 15, left: 0, right: 16),
                    child: Row(
                      children: [
                        Image(
                          image: AssetImage('images/0-1.png'),
                          width: 150,
                          height: 100,
                        ),
                        Flexible(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                _filteredclinic[index].name,
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 10),
                              Row(
                                children: [
                                  Icon(Icons.location_on_outlined,
                                      color: Colors.black),
                                  SizedBox(width: 5),
                                  Expanded(
                                    child: Text(
                                      _filteredclinic[index].address,
                                      style: TextStyle(fontSize: 17),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 10),
                              ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    primary: kPrimaryColor, // background
                                    onPrimary: Colors.white,
                                    textStyle: TextStyle(
                                      fontSize: 17,
                                      color: Colors.white,
                                    ),
                                    minimumSize: Size(180, 40),
                                    shape: new RoundedRectangleBorder(
                                        borderRadius: new BorderRadius.all(
                                            Radius.circular(15))), // foreground
                                  ),
                                  onPressed: () {
                                    Navigator.of(context, rootNavigator: true)
                                        .push(MaterialPageRoute(
                                            builder: (context) => Booking()));
                                  },
                                  child: Text('Book an appointment'))
                            ],
                          ),
                        ),
                      ],
                    ),
                  )),
            ),
          );
        });
  }

  Future<User> getUserData(FlutterSecureStorage storage) async {
    var email = await widget.storage.read(key: 'userEmail');
    var sId = await widget.storage.read(key: 'userID');
    var name = await widget.storage.read(key: 'userName');
    var role = await widget.storage.read(key: 'userRole');
    User u = new User(sId: sId, email: email, name: name, role: role);
    return u;
  }
}

List<Clinic> _clinics = <Clinic>[];
List<Clinic> _filteredclinic = <Clinic>[];
Future<List<Clinic>> fetchClinics() async {
  var fetchdata = await rootBundle.loadString('assets/json/clinic.mock.json');
  var clinics = <Clinic>[];
  var clinicsjson = json.decode(fetchdata)['Clinic'] as List;
  for (var clinic in clinicsjson) {
    clinics.add(Clinic.fromJson(clinic));
  }
  return clinics;
}
