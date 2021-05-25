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
  ClinicListView(this.storage);

  @override
  _ClinicListViewState createState() => _ClinicListViewState();
}

class _ClinicListViewState extends State<ClinicListView> {
  Dio dio = new Dio();
  Response _response;
  String url = '$ServerIP/api/v1/users/';
  User _user = new User();

  Future<User> getUserData(FlutterSecureStorage storage) async {
    var _id = await storage.read(key: 'userid');
    User u = new User();
    _response = await dio.get('$url$_id');
    print(_response.data);
    u.role = _response.data['data']['data']['role'];
    u.sId = _response.data['data']['data']['_id'];
    u.email = _response.data['data']['data']['email'];
    u.name = _response.data['data']['data']['name'];
    print(u.name);
    print(u.email);
    return u;
  }

  @override
  void initState() {
    fetchClinics().then((value) {
      setState(() {
        _clinics = value;
        _filteredclinic = _clinics;
      });
    });
    getUserData(widget.storage).then((value) {
      _user = value;
    });

    print(_user.name);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFFAED2E8),
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
                    suffixIcon: Icon(Icons.search_outlined),
                    border: new OutlineInputBorder(
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
                'Hello, ${_user.name}',
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
            onTap: () {
              Navigator.of(context, rootNavigator: true).push(MaterialPageRoute(
                  builder: (context) => new ProfilePage(widget.storage)));
            },
          ),
          // ListTile(
          //   leading: Icon(Icons.app_registration),
          //   title: Text('Register as a doctor'),
          //   onTap: () {
          //     Navigator.of(context, rootNavigator: true).push(
          //         MaterialPageRoute(builder: (context) => new Registration()));
          //   },
          // ),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text('Logout'),
            onTap: () {
              print(widget.storage.read(key: 'jwt').toString());
              widget.storage.deleteAll();
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
              onTap: () => Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ClinicPage())),
              child: Card(
                  margin: const EdgeInsets.only(
                      top: 5.0, bottom: 10.0, left: 10.0, right: 10.0),
                  child: Padding(
                    padding: const EdgeInsets.only(
                        top: 32, bottom: 32, left: 0, right: 16),
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
                              ),
                              SizedBox(height: 20),
                              Text(
                                _filteredclinic[index].address,
                              ),
                              ElevatedButton(
                                  onPressed: () {
                                    Navigator.of(context, rootNavigator: true)
                                        .push(MaterialPageRoute(
                                            builder: (context) =>
                                                new Booking()));
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
