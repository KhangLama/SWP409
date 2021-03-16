import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:swp409/Models/clinic.dart';

class MapViewPage extends StatefulWidget {
  @override
  _MapViewPageState createState() => _MapViewPageState();
}

class _MapViewPageState extends State<MapViewPage> {
  final Completer<GoogleMapController> _controllerGoogleMap = Completer();
  GoogleMapController newGoogleMapController;

  Position currentPosition;
  var geoLocator = Geolocator();


  Future<String>_loadFromAsset() async {
    return await rootBundle.loadString("assets/json/clinic.mock.json");
  }

  Future parseJson() async {

    // String jsonString = await _loadFromAsset();
    Map<String, dynamic> clinicMap = jsonDecode('assets/json/clinic.mock.json');
    var clinic = Clinic.fromJson(clinicMap);
    print(clinic.name);
  }

  @override
  void initState() {
    super.initState();
    this.parseJson();
  }

  void locatePosition() async {
    var position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.bestForNavigation);
    currentPosition = position;

    var latLngPosition = LatLng(position.latitude, position.longitude);

    var cameraPosition = CameraPosition(target: latLngPosition, zoom: 13);
    await newGoogleMapController
        .animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
  }

  Future<void> _onMapCreated(GoogleMapController controller) async {
    newGoogleMapController = controller;
    _controllerGoogleMap.complete(controller);
    locatePosition();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            GoogleMap(
              mapType: MapType.normal,
              initialCameraPosition:
                  CameraPosition(target: const LatLng(37.7786, -122.4375)),
              onMapCreated: _onMapCreated,
              myLocationEnabled: true,
              mapToolbarEnabled: true,
              indoorViewEnabled: true,
              zoomControlsEnabled: true,
              zoomGesturesEnabled: true,
              buildingsEnabled: true,
            ),
            ElevatedButton(onPressed: parseJson)
          ],
        ),
      ),
    );
  }
}
