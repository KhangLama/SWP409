import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:swp409/Models/clinic.dart';
import 'package:swp409/Services/ApiService/clinic_service.dart';

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
  List<Clinic> _clinics = <Clinic>[];
  List<Clinic> _filteredclinic = <Clinic>[];
  String urlGet = "$ServerIP/api/v1/clinics/approved-clinics";
  ClinicService _clinicService = new ClinicService();

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

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
    _completer.complete(controller);
    location.onLocationChanged.listen((event) {
      print(event.latitude);
      print(event.longitude);
      mapController.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
          target: LatLng(event.latitude, event.longitude), zoom: 18)));
    });
    setState(() {
      _markers.clear();
      for (final clinic in _clinics) {
        final marker = Marker(
            markerId: MarkerId(clinic.name),
            position: LatLng(
                clinic.geometry.coordinates[1], clinic.geometry.coordinates[0]),
            infoWindow: InfoWindow(
                title: clinic.name,
                anchor: Offset(0.5, 0.0),
                snippet: clinic.address));
        _markers[clinic.name] = marker;
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchClinics().then((value) {
      _clinics = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            TextField(),
            Container(
              height: MediaQuery.of(context).size.height - 153.143,
              width: MediaQuery.of(context).size.width,
              child: GoogleMap(
                onMapCreated: _onMapCreated,
                myLocationButtonEnabled: false,
                myLocationEnabled: true,
                mapType: MapType.normal,
                initialCameraPosition: CameraPosition(
                  target: LatLng(37.4219999, -122.0862462),
                ),
                markers: _markers.values.toSet(),
              ),
            )
          ],
        ),
      ),
    );
  }
}
