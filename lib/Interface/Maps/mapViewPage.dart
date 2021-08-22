import 'dart:async';

import 'package:dio/dio.dart' as dioo;
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:googleapis/sheets/v4.dart';
import 'package:location/location.dart';
import 'package:swp409/Models/clinic.dart';
import 'package:swp409/Services/ApiService/clinic_service.dart';
import 'package:delayed_display/delayed_display.dart';
import 'package:swp409/helper/keyboard.dart';
import '../../constants.dart';
import '../../size_config.dart';

class MapViewPage extends StatefulWidget {
  const MapViewPage({Key key}) : super(key: key);

  @override
  _MapViewPageState createState() => _MapViewPageState();
}

class _MapViewPageState extends State<MapViewPage> {
  Completer<GoogleMapController> _completer = Completer();
  GoogleMapController mapController;
  final Map<String, Marker> _markers = {};
  Location location = new Location();
  LocationData _locationData;
  List<Clinic> _clinics = <Clinic>[];
  List<Clinic> _filteredclinic = <Clinic>[];
  String urlGet = "$ServerIP/api/v1/clinics/approved-clinics";
  String distance = '';
  String time = '';
  ClinicService _clinicService = new ClinicService();
  // Object for PolylinePoints
  PolylinePoints polylinePoints;
  // List of coordinates to join
  List<LatLng> polylineCoordinates = [];
  // Map storing polylines created by connecting two points
  Map<PolylineId, Polyline> polylines = {};
  static String _displayStringForOption(Clinic option) => option.name;
  dioo.Dio dio = new dioo.Dio();

  //get data of clinic from database
  Future<List<Clinic>> fetchClinics() async {
    var fetchdata = await _clinicService.getClinics(urlGet);
    var clinics = <Clinic>[];
    var clinicsjson = fetchdata.data['data']['data'] as List;
    for (var clinic in clinicsjson) {
      clinics.add(Clinic.fromJson(clinic));
    }
    return clinics;
  }

  Future<void> _onMapCreated(GoogleMapController controller) async {
    _locationData = await location.getLocation();
    fetchClinics().then((value) {
      setState(() {
        _clinics = value;
        _markers.clear();

        for (final clinic in _clinics) {
          final marker = Marker(
              markerId: MarkerId(clinic.name),
              position: LatLng(clinic.geometry.coordinates[1],
                  clinic.geometry.coordinates[0]),
              infoWindow: InfoWindow(
                  title: clinic.name,
                  anchor: Offset(0.5, 0.0),
                  snippet: clinic.address),
              onTap: () async {
                _createPolylines(
                    _locationData.latitude,
                    _locationData.longitude,
                    clinic.geometry.coordinates[1],
                    clinic.geometry.coordinates[0]);
                getDT(
                        _locationData.latitude,
                        _locationData.longitude,
                        clinic.geometry.coordinates[1],
                        clinic.geometry.coordinates[0])
                    .then((value) {
                  setState(() {
                    distance = value[0];
                    time = value[1];
                    setState(() {
                      distance = value[0];
                      time = value[1];
                    });
                    print(distance);
                    print(time);
                  });
                });
                List<WorkingHours> list = getDayOfWeek(clinic);
                await Future.delayed(Duration(milliseconds: 500));
                showModalBottomSheet(
                    context: context,
                    elevation: 10,
                    isScrollControlled: true,

                    builder: (context) => Wrap(
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: Text(
                                    clinic.name,
                                    style: TextStyle(
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Row(
                              children: [
                                SizedBox(
                                  width: 10,
                                ),
                                Icon(Icons.location_on_outlined,
                                    color: Colors.orange),
                                SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                    child: Text(
                                  "${clinic.address}",
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 20),
                                )),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                SizedBox(
                                  width: 10,
                                ),
                                Icon(Icons.star_border_outlined,
                                    color: Colors.orange),
                                SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                    child: Text(
                                  "${clinic.ratingAvg}",
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 20),
                                )),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                SizedBox(
                                  width: 10,
                                ),
                                Icon(Icons.access_time_outlined,
                                    color: Colors.orange),
                                SizedBox(
                                  width: 10,
                                ),
                                Container(
                                  width: 150,
                                  height: list.length == 0
                                      ? 30
                                      : (list.length * 30).toDouble(),
                                  child: list.length == 0
                                      ? Text(
                                          "Closed",
                                          style: TextStyle(fontSize: 20.0),
                                        )
                                      : ListView.builder(
                                          itemCount: list.length,
                                          itemBuilder: (context, index) {
                                            return Container(
                                              padding: EdgeInsets.fromLTRB(
                                                  2, 0, 0, 10),
                                              child: Text(
                                                '${(list[index].startTime ~/ 60).toString().padLeft(2, '0')}:'
                                                '${(list[index].startTime % 60).toString().padLeft(2, '0')} - '
                                                '${(list[index].endTime ~/ 60).toString().padLeft(2, '0')}:'
                                                '${(list[index].endTime % 60).toString().padLeft(2, '0')}',
                                                style: TextStyle(fontSize: 20),
                                              ),
                                            );
                                          }),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Row(children: [
                              SizedBox(width: 10),
                              Text('Distance: $distance'),
                              SizedBox(width: 30),
                              Text('Duration: $time'),
                            ]),
                            SizedBox(height: 20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      primary: kPrimaryColor, // background
                                      onPrimary: Colors.white,
                                      textStyle: TextStyle(
                                        fontSize: 20,
                                        color: Colors.white,
                                      ),
                                      minimumSize: Size(200, 40),
                                      shape: new RoundedRectangleBorder(
                                          borderRadius: new BorderRadius.all(
                                              Radius.circular(
                                                  15))), // foreground
                                    ),
                                    onPressed: () {},
                                    // => Navigator.of(context,
                                    //         rootNavigator: true)
                                    //     .push(MaterialPageRoute(
                                    //         builder: (context) => ClinicPage.clinic(
                                    //               clinic: clinic,
                                    //               user: _user,
                                    //               cookies: _cookies,
                                    //             ))),
                                    child: Text('View Detail')),
                              ],
                            )
                          ],
                        ));
              });
          _markers[clinic.name] = marker;
        }
      });
    });
    mapController = controller;
    _completer.complete(controller);
    location.getLocation().then((event) {
      mapController.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
          target: LatLng(event.latitude, event.longitude), zoom: 18)));
    });
  }

  List<WorkingHours> getDayOfWeek(Clinic clinic) {
    var now = new DateTime.now();
    int checkDate = 0;
    if (now.weekday == 7) {
      checkDate = 0;
    } else {
      checkDate = now.weekday;
    }
    return clinic.schedule[checkDate].workingHours;
  }

  Future<List<String>> getDT(
      double startLat, double startLng, double destLat, double destLng) async {
    String urlDist =
        "https://maps.googleapis.com/maps/api/distancematrix/json?origins=heading=90:$startLat,$startLng&destinations=$destLat,$destLng&key=${dotenv.env['GOOGLE_MAP_KEY']}";
    dioo.Response resultz = await dio.get(urlDist);
    // distance = resultz.data['rows'][0]['elements'][0]['distance']['text'];
    // time = resultz.data['rows'][0]['elements'][0]['duration']['text'];
    List<String> list = [];
    list.add(
        resultz.data['rows'][0]['elements'][0]['distance']['text'].toString());
    list.add(
        resultz.data['rows'][0]['elements'][0]['duration']['text'].toString());
    return list;
  }

  _createPolylines(
      double startLat, double startLng, double destLat, double destLng) async {
    polylinePoints = PolylinePoints();

    // drawing the polylines
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
        dotenv.env['GOOGLE_MAP_KEY'], // Google Maps API Key
        PointLatLng(startLat, startLng),
        PointLatLng(destLat, destLng),
        travelMode: TravelMode.driving);

    polylines.clear();
    polylineCoordinates.clear();
    // Adding the coordinates to the list
    if (result.points.isNotEmpty) {
      result.points.forEach((PointLatLng point) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      });
    } else {
      print(result.errorMessage);
    }

    // Defining an ID
    PolylineId id = PolylineId('poly');

    // Initializing Polyline
    Polyline polyline = Polyline(
      geodesic: true,
      polylineId: id,
      color: Colors.blue,
      points: polylineCoordinates,
      width: 3,
    );

    // Adding the polyline to the map
    polylines[id] = polyline;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Autocomplete<Clinic>(
              displayStringForOption: _displayStringForOption,
              optionsBuilder: (TextEditingValue textEditingValue) {
                if (textEditingValue.text.isEmpty) {
                  return const Iterable<Clinic>.empty();
                } else {
                  return _clinics.where((element) => element.name
                      .toLowerCase()
                      .contains(textEditingValue.text.toLowerCase()));
                }
              },
              fieldViewBuilder:
                  (context, controller, focusNode, onEditingComplete) {
                return TextField(
                    decoration: InputDecoration(
                        suffixIcon: IconButton(
                            onPressed: () {
                              controller.clear();
                              FocusScopeNode currentFocus =
                                  FocusScope.of(context);
                              if (!currentFocus.hasPrimaryFocus) {
                                currentFocus.unfocus();
                              }
                            },
                            icon: Icon(Icons.clear)),
                        fillColor: Colors.white,
                        focusColor: Colors.white,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(color: Colors.grey[100]))),
                    controller: controller,
                    focusNode: focusNode,
                    onEditingComplete: onEditingComplete);
              },
              onSelected: (Clinic selection) {
                KeyboardUtil.hideKeyboard(context);
                _markers.forEach((key, value) async {
                  if (selection.name == value.mapsId.value)
                    mapController.animateCamera(CameraUpdate.newCameraPosition(
                        CameraPosition(
                            target: LatLng(value.position.latitude,
                                value.position.longitude),
                            zoom: 18)));
                });
              },
            ),
            Expanded(
              child: Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: GoogleMap(
                  onMapCreated: _onMapCreated,
                  myLocationButtonEnabled: true,
                  myLocationEnabled: true,
                  mapType: MapType.normal,
                  zoomControlsEnabled: false,
                  initialCameraPosition: CameraPosition(
                    target: LatLng(37.4219999, -122.0862462),
                  ),
                  markers: _markers.values.toSet(),
                  polylines: Set<Polyline>.of(polylines.values),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
