import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapViewPage extends StatefulWidget {
  @override
  _MapViewPageState createState() => _MapViewPageState();
}

class _MapViewPageState extends State<MapViewPage> {
  final Completer<GoogleMapController> _controllerGoogleMap = Completer();
  GoogleMapController newGoogleMapController;
  final Set<Marker> _markers = {};
  Position currentPosition;
  var geoLocator = Geolocator();
  var clinicList = [];
  void getClinic() async {
    var data = await rootBundle.loadString('assets/json/clinic.mock.json');
    clinicList = json.decode(data)['Clinic'] as List;
  }

  @override
  void initState() {
    super.initState();
    getClinic();
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
    setState(() {
      newGoogleMapController = controller;
      _controllerGoogleMap.complete(controller);
      markerCreate();
    });
    locatePosition();
  }

  Future<void> markerCreate() async {
    try {
      for (var i = 0; i < clinicList.length; i++) {
        _markers.add(Marker(
          markerId: MarkerId(clinicList[i]['id']),
          draggable: false,
          position: LatLng(double.parse(clinicList[i]['lat']),
              double.parse(clinicList[i]['lng'])),
          infoWindow: InfoWindow(
            title: clinicList[i]['name'],
          ),
        ));
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            GoogleMap(
              mapType: MapType.normal,
              initialCameraPosition: CameraPosition(target: LatLng(-37, 128)),
              onMapCreated: _onMapCreated,
              markers: _markers,
              myLocationButtonEnabled: true,
              myLocationEnabled: true,
              mapToolbarEnabled: true,
              indoorViewEnabled: true,
              zoomControlsEnabled: true,
              zoomGesturesEnabled: true,
              buildingsEnabled: true,
            ),

            // ElevatedButton(onPressed: getClinic, child: null)
          ],
        ),
      ),
    );
  }
}
