import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:location/location.dart';
import 'package:swp409/Models/clinic.dart';
import 'package:swp409/Models/user.dart';
import 'package:swp409/Services/ApiService/clinic_service.dart';
import 'package:swp409/Services/Booking/booking.dart';
import 'package:swp409/constants.dart';

import 'clinicdetailView.dart';

class ListClinicSearchBySymp extends StatefulWidget {
  List<String> cookies;
  User user;
  String urlSymptoms;
  ListClinicSearchBySymp({Key key, this.cookies, this.user, this.urlSymptoms})
      : super(key: key);

  @override
  _ListClinicSearchBySympState createState() => _ListClinicSearchBySympState();
}

class _ListClinicSearchBySympState extends State<ListClinicSearchBySymp> {
  User _user = new User();
  List<String> _cookies;
  String urlSymp;
  LocationData _locationData;
  Location location = new Location();
  List<Clinic> _clinics = <Clinic>[];
  List<Clinic> _filteredclinic = <Clinic>[];
  ClinicService _clinicService = new ClinicService();
  Dio dio = new Dio();
  List listDistance = [];

  @override
  void initState() {
    _cookies = widget.cookies;
    _user = widget.user;
    urlSymp = widget.urlSymptoms;
    fetchClinics().then((value) {
      setState(() {
        _clinics = value;
        _filteredclinic = _clinics;
      });
    });
    super.initState();
  }

  sorting(listDistance, clinics) {
    print(listDistance);
    for (var i = 0; i < clinics.length - 1; i++) {
      for (var j = 0; j < clinics.length - i - 1; j++) {
        if (double.parse(listDistance[j].split(' ')[0]) >
            double.parse(listDistance[j + 1].split(' ')[0])) {
          var tmp = listDistance[j];
          listDistance[j] = listDistance[j + 1];
          listDistance[j + 1] = tmp;
          var tmp1 = clinics[j];
          clinics[j] = clinics[j + 1];
          clinics[j + 1] = tmp1;
        }
      }
    }
  }

  Future<String> getDT(
      double startLat, double startLng, double destLat, double destLng) async {
    String urlDist =
        "https://maps.googleapis.com/maps/api/distancematrix/json?origins=heading=90:$startLat,$startLng&destinations=$destLat,$destLng&key=${dotenv.env['GOOGLE_MAP_KEY']}";
    Response resultz = await dio.get(urlDist);
    print(resultz);
    var rs =
        resultz.data['rows'][0]['elements'][0]['distance']['text'].toString();

    return rs;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: kPrimaryBackground,
        appBar: AppBar(
          leading: BackButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context);
            },
            color: kPrimaryLightColor,
          ),
          title: Text(
            'List clinic by search symptoms',
            style: TextStyle(
                color: kPrimaryLightColor,
                fontWeight: FontWeight.bold,
                fontSize: 20),
          ),
          centerTitle: true,
          backgroundColor: kPrimaryAppbar,
        ),
        body: SafeArea(
            child: Column(
          children: [
            Expanded(child: buildListView()),
          ],
        )),
      ),
    );
  }

  buildListView() {
    return ListView.builder(
        itemCount: _filteredclinic.length,
        itemBuilder: (context, index) {
          return Container(
            width: MediaQuery.of(context).size.width,
            child: GestureDetector(
              onTap: () => Navigator.of(context, rootNavigator: true)
                  .push(MaterialPageRoute(
                      builder: (context) => ClinicPage.clinic(
                            clinic: _filteredclinic[index],
                            user: _user,
                            cookies: _cookies,
                          ))),
              child: Card(
                  margin: const EdgeInsets.only(
                      top: 5.0, bottom: 10.0, left: 10.0, right: 10.0),
                  child: Padding(
                    padding: const EdgeInsets.only(
                        top: 20, bottom: 15, left: 0, right: 16),
                    child: Row(
                      children: [
                        Image(
                          image: NetworkImage(
                              _filteredclinic[index].coverImage.url),
                          //image: AssetImage("images/0-1.png"),
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
                                      _filteredclinic[index].address ?? "",
                                      style: TextStyle(fontSize: 17),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 10),
                              Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [Text(listDistance[index] ?? "")]),
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
                                            builder: (context) => Booking(
                                                  clinic:
                                                      _filteredclinic[index],
                                                  user: _user,
                                                  cookies: _cookies,
                                                )));
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

  Future<List<Clinic>> fetchClinics() async {
    _locationData = await location.getLocation();
    String urlGet = "$ServerIP/api/v1/clinics/symptom?symptoms=$urlSymp";
    var fetchdata = await _clinicService.getClinics(urlGet);
    List<Clinic> clinics = <Clinic>[];
    var clinicsjson = fetchdata.data['data']['data'] as List;
    for (var clinic in clinicsjson) {
      clinics.add(Clinic.fromJson(clinic));
      getDT(
              _locationData.latitude,
              _locationData.longitude,
              clinics.last.geometry.coordinates[1],
              clinics.last.geometry.coordinates[0])
          .then((value) {
        listDistance.add(value);
      });
    }
    await Future.delayed(Duration(seconds: 1));
    sorting(listDistance, clinics);
    setState(() {});
    return clinics;
  }
}
