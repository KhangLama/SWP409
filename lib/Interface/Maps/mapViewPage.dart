import 'dart:async';
import 'dart:convert';
import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:swp409/Interface/Home/clinicdetailView.dart';
import 'package:swp409/Models/clinic.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:flutter_config/flutter_config.dart';

class MapViewPage extends StatefulWidget {
  @override
  _MapViewPageState createState() => _MapViewPageState();
}

class _MapViewPageState extends State<MapViewPage> {
  final Completer<GoogleMapController> _controllerGoogleMap = Completer();
  GoogleMapController newGoogleMapController;
  final Set<Marker> _markers = {};
  var geoLocator = Geolocator();
  List<Clinic> _clinics = <Clinic>[];
  AutoCompleteTextField searchTextField;
  GlobalKey<AutoCompleteTextFieldState<Clinic>> key = GlobalKey();
  Map<PolylineId, Polyline> polylines = {};
  List<LatLng> polylineCoordinates = [];
  PolylinePoints polylinePoints = PolylinePoints();
  bool loading = true;
  Future<List<Clinic>> fetchClinics() async {
    var fetchdata = await rootBundle.loadString('assets/json/clinic.mock.json');
    var clinics = <Clinic>[];
    var clinicsjson = json.decode(fetchdata)['Clinic'] as List;
    for (var clinic in clinicsjson) {
      clinics.add(Clinic.fromJson(clinic));
    }
    return clinics;
  }

  @override
  void initState() {
    fetchClinics().then((value) {
      setState(() {
        _clinics = value;
        loading = false;
      });
    });
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
  }

  Future<void> _onMapCreated(GoogleMapController controller) async {
    setState(() {
      newGoogleMapController = controller;
      _controllerGoogleMap.complete(controller);
      markerCreate();
    });
    locatePosition();
  }

  Future<void> markerCreate() async {
    try {
      for (var i = 0; i < _clinics.length; i++) {
        _markers.add(Marker(
            markerId: MarkerId(_clinics[i].id),
            draggable: false,
            position: LatLng(
                double.parse(_clinics[i].lat), double.parse(_clinics[i].lng)),
            infoWindow: InfoWindow(
                title: _clinics[i].name,
                onTap: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => ClinicPage()));
                }),
            onTap: () {}));
      }
    } catch (e) {
      rethrow;
    }
  }

  Widget row(Clinic clinic) {
    var flag = -2;
    return ListTile(
      title: Text(clinic.name, style: TextStyle(fontSize: 16)),
      subtitle: Text(clinic.address, style: TextStyle(fontSize: 14)),
      onTap: () async {
        _markers.forEach((element) async {
          var _currentPosition = await Geolocator.getCurrentPosition(
              desiredAccuracy: LocationAccuracy.bestForNavigation);
          _addPolyLine() {
            PolylineId id = PolylineId("poly");
            Polyline polyline = Polyline(
                visible: true,
                polylineId: id,
                color: Colors.blue,
                width: 4,
                points: polylineCoordinates,
                geodesic: true,
                zIndex: 1);
            polylines[id] = polyline;
            setState(() {});
          }

          flag = await _buildWayPoint(
              flag, element, clinic, _currentPosition, _addPolyLine);
        });

        print(flag);

        setState(() {
          searchTextField.textField.controller.text = clinic.name;
          searchTextField.clear();
        });
      },
    );
  }

  Future<int> _buildWayPoint(int flag, Marker element, Clinic clinic,
      Position _currentPosition, _addPolyLine()) async {
    for (var i = 0; i < _clinics.length; i++) {
      flag = element.infoWindow.title
          .toLowerCase()
          .compareTo(_clinics[i].name.toLowerCase());
      if (flag == 0) {
        var latLngPosition =
            LatLng(double.parse(clinic.lat), double.parse(clinic.lng));
        var cameraPosition = CameraPosition(target: latLngPosition, zoom: 18);
        await newGoogleMapController
            .animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
        PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
            FlutterConfig.get('GOOGLE_MAP_KEY'),
            PointLatLng(_currentPosition.latitude, _currentPosition.longitude),
            PointLatLng(double.parse(clinic.lat), double.parse(clinic.lng)),
            travelMode: TravelMode.driving,
            wayPoints: [PolylineWayPoint(location: clinic.address)]);
        polylineCoordinates.clear();

        if (result.points.isNotEmpty) {
          result.points.forEach((PointLatLng point) {
            polylineCoordinates.add(LatLng(point.latitude, point.longitude));
          });
        }
        _addPolyLine();
        print(result);
      }
    }
    return flag;
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
                    suggestionsAmount: 5,
                    onFocusChanged: (hasFocus) {},
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
                markers: _markers,
                myLocationButtonEnabled: true,
                myLocationEnabled: true,
                mapToolbarEnabled: true,
                indoorViewEnabled: true,
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
