import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:swp409/Models/clinic.dart';
import 'package:swp409/Services/ApiService/clinic_service.dart';
import 'package:delayed_display/delayed_display.dart';
import '../../constants.dart';

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
  ClinicService _clinicService = new ClinicService();
  // Object for PolylinePoints
  PolylinePoints polylinePoints;
  // List of coordinates to join
  List<LatLng> polylineCoordinates = [];
  // Map storing polylines created by connecting two points
  Map<PolylineId, Polyline> polylines = {};

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
      print('Fetch clinic ... is done');
      setState(() {
        _clinics = value;
        _markers.clear();
        polylines.clear();
        for (final clinic in _clinics) {
          final marker = Marker(
              markerId: MarkerId(clinic.name),
              position: LatLng(clinic.geometry.coordinates[1],
                  clinic.geometry.coordinates[0]),
              infoWindow: InfoWindow(
                  title: clinic.name,
                  anchor: Offset(0.5, 0.0),
                  snippet: clinic.address),
              onTap: () {
                _createPolylines(
                    _locationData.latitude,
                    _locationData.longitude,
                    clinic.geometry.coordinates[1],
                    clinic.geometry.coordinates[0]);
              });
          _markers[clinic.name] = marker;
        }
      });
    });
    mapController = controller;
    _completer.complete(controller);
    location.onLocationChanged.listen((event) {
      mapController.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
          target: LatLng(event.latitude, event.longitude), zoom: 18)));
    });
  }

  _createPolylines(
      double startLat, double startLng, double destLat, double destLng) async {
    polylinePoints = PolylinePoints();
    // drawing the polylines
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
        dotenv.env['GOOGLE_MAP_KEY'], // Google Maps API Key
        PointLatLng(startLat, startLng),
        PointLatLng(destLat, destLng),
        travelMode: TravelMode.driving,
        optimizeWaypoints: true);
    print(result.points);
    // Adding the coordinates to the list
    if (result.points.isNotEmpty) {
      result.points.forEach((PointLatLng point) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      });
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
    // print(polylines[id].toJson());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            DelayedDisplay(
              delay: Duration(seconds: 1),
              child: Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: GoogleMap(
                  onMapCreated: _onMapCreated,
                  myLocationButtonEnabled: false,
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
            TextField(),
          ],
        ),
      ),
    );
  }
}
