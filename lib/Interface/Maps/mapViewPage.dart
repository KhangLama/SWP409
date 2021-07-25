import 'dart:async';
import 'dart:convert';
import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:swp409/Interface/Home/clinicdetailView.dart';
import 'package:swp409/Models/clinic.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:flutter_config/flutter_config.dart';
import 'package:swp409/Services/ApiService/clinic_service.dart';
import 'package:swp409/constants.dart';
import 'package:swp409/helper/keyboard.dart';

class MapViewPage extends StatefulWidget {
  @override
  _MapViewPageState createState() => _MapViewPageState();
}

class _MapViewPageState extends State<MapViewPage> {
  final Completer<GoogleMapController> _controllerGoogleMap = Completer();
  GoogleMapController newGoogleMapController;
  final Map<String, Marker> _markers = {};
  var geoLocator = Geolocator();
  List<Clinic> _clinics = <Clinic>[];
  AutoCompleteTextField searchTextField;
  GlobalKey<AutoCompleteTextFieldState<Clinic>> key = GlobalKey();
  TextEditingController _editingController = new TextEditingController();
  Map<PolylineId, Polyline> polylines = {};
  List<LatLng> polylineCoordinates = [];
  PolylinePoints polylinePoints = PolylinePoints();
  bool loading = true;
  String urlGet = "$ServerIP/api/v1/clinics/approved-clinics";
  ClinicService _clinicService = new ClinicService();

  Future<List<Clinic>> fetchClinics(var url) async {
    var fetchdata = await _clinicService.getClinics(url);
    var clinics = <Clinic>[];
    var clinicsjson = fetchdata.data['data']['data'] as List;
    for (var clinic in clinicsjson) {
      clinics.add(Clinic.fromJson(clinic));
    }
    return clinics;
  }

  @override
  void initState() {
    locatePosition();
    markerCreate();

    super.initState();
  }

  void locatePosition() async {
    WidgetsFlutterBinding.ensureInitialized(); // Required by FlutterConfig
    await FlutterConfig.loadEnvVariables();
    var _currentPosition = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.bestForNavigation);

    var latLngPosition =
        LatLng(_currentPosition.latitude, _currentPosition.longitude);

    var cameraPosition = CameraPosition(target: latLngPosition, zoom: 13);
    await newGoogleMapController
        .animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
    var url =
        '$ServerIP/api/v1/clinics/nearest-clinics?lat=${_currentPosition.latitude}&lng=${_currentPosition.longitude}';
    fetchClinics(url).then((value) {
      setState(() {
        print('value');
        print(value[0].toJson());
        _clinics = value;
        print('clinic');
        print(_clinics[0].toJson());
        loading = false;
      });
    });
  }

  Future<void> _onMapCreated(GoogleMapController controller) async {
    setState(() {
      newGoogleMapController = controller;
      _controllerGoogleMap.complete(controller);
    });
  }

  Future<void> markerCreate() async {
    try {
      _markers.clear();
      for (final clinic in _clinics) {
        print('marker test: $clinic');
        final marker = Marker(
            markerId: MarkerId(clinic.name),
            draggable: false,
            position: LatLng(
                clinic.geometry.coordinates[1], clinic.geometry.coordinates[0]),
            infoWindow: InfoWindow(
                title: clinic.name,
                snippet: clinic.address,
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => ClinicPage.clinic(clinic: clinic)));
                }),
            onTap: () {});
        _markers[clinic.name] = marker;
      }
    } catch (e) {
      print("marker + $e");
      rethrow;
    }
  }

  Widget row(Clinic clinic) {
    return ListTile(
      title: Text(clinic.name ?? "", style: TextStyle(fontSize: 16)),
      subtitle: Text(clinic.address ?? "", style: TextStyle(fontSize: 14)),
      onTap: () async {
        print("map search: ${clinic.toJson()}");
        print(_markers.values);
        _editingController.text = clinic.name;

        KeyboardUtil.hideKeyboard(context);
        _markers.forEach((name, element) async {
          var _currentPosition = await Geolocator.getCurrentPosition(
              desiredAccuracy: LocationAccuracy.bestForNavigation);
          _addPolyLine() {
            PolylineId id = PolylineId(clinic.sId);
            Polyline polyline = Polyline(
                visible: true,
                polylineId: id,
                color: Colors.blue,
                width: 4,
                points: polylineCoordinates,
                geodesic: true,
                jointType: JointType.bevel,
                zIndex: 1);
            polylines[id] = polyline;
          }

          await _buildWayPoint(element, clinic, _currentPosition, _addPolyLine);
        });
      },
    );
  }

  Future _buildWayPoint(Marker element, Clinic clinic,
      Position _currentPosition, _addPolyLine()) async {
    var flag;
    for (var i = 0; i < _clinics.length; i++) {
      flag = element.infoWindow.title
          .toLowerCase()
          .compareTo(_clinics[i].name.toLowerCase());
      if (flag == 0) {
        var latLngPosition = LatLng(
            clinic.geometry.coordinates[1], clinic.geometry.coordinates[0]);
        var cameraPosition = CameraPosition(target: latLngPosition, zoom: 18);
        await newGoogleMapController
            .animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
        PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
            dotenv.env['GOOGLE_MAP_KEY'],
            PointLatLng(_currentPosition.latitude, _currentPosition.longitude),
            PointLatLng(
                clinic.geometry.coordinates[1], clinic.geometry.coordinates[0]),
            travelMode: TravelMode.driving,
            wayPoints: [PolylineWayPoint(location: clinic.address)]);
        polylineCoordinates.clear();

        if (result.points.isNotEmpty) {
          result.points.forEach((PointLatLng point) {
            polylineCoordinates.add(LatLng(point.latitude, point.longitude));
          });
        }
        _addPolyLine();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          physics: NeverScrollableScrollPhysics(),
          children: [
            loading
                ? CircularProgressIndicator()
                : searchTextField = AutoCompleteTextField<Clinic>(
                    controller: _editingController,
                    suggestionsAmount: 5,
                    onFocusChanged: (hasFocus) {
                      searchTextField.clear();
                    },
                    clearOnSubmit: true,
                    key: key,
                    suggestions: _clinics,
                    decoration: InputDecoration(
                      fillColor: Colors.white,
                      filled: true,
                      contentPadding: EdgeInsets.all(8),
                      hintText: 'Search clinic\'s name',
                      suffixIcon: Icon(Icons.search_outlined),
                      border: new OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                    ),
                    itemFilter: (suggestion, query) => suggestion.name
                        .toLowerCase()
                        .contains(query.toLowerCase()),
                    itemSorter: (a, b) => a.name.compareTo(b.name),
                    itemSubmitted: (data) {
                      setState(() {
                        searchTextField.textField.controller.text = data.name;
                      });
                    },
                    itemBuilder: (context, suggestion) => row(suggestion),
                  ),
            Container(
              height: MediaQuery.of(context).size.height - 128,
              child: GoogleMap(
                mapType: MapType.normal,
                initialCameraPosition:
                    CameraPosition(target: LatLng(10.03711, 105.78825)),
                onMapCreated: _onMapCreated,
                markers: _markers.values.toSet(),
                myLocationButtonEnabled: true,
                myLocationEnabled: true,
                mapToolbarEnabled: true,
                zoomGesturesEnabled: true,
                buildingsEnabled: true,
                polylines: Set<Polyline>.of(polylines.values),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
