import 'dart:async';
import 'dart:ui' as ui;
import 'dart:convert';
import 'dart:typed_data';
import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:swp409/Interface/Home/clinicdetailView.dart';
import 'package:swp409/Models/clinic.dart';

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
    var position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.bestForNavigation);

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
                })));
      }
    } catch (e) {
      rethrow;
    }
  }

  Widget row(Clinic clinic) {
    var flag = -2;
    return ListTile(
      title: Text(clinic.name, style: TextStyle(fontSize: 16)),
      onTap: () async {
        _markers.forEach((element) {
          for (var i = 0; i < _clinics.length; i++) {
            flag = element.infoWindow.title
                .toLowerCase()
                .compareTo(_clinics[i].name.toLowerCase());
          }
        });
        if (flag == 0) {
          var latLngPosition =
              LatLng(double.parse(clinic.lat), double.parse(clinic.lng));

          var cameraPosition = CameraPosition(target: latLngPosition, zoom: 13);
          await newGoogleMapController
              .animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
        }
        print(flag);
        setState(() {
          searchTextField.textField.controller.text = clinic.name;
          searchTextField.clear();
        });
      },
    );
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
                    decoration: InputDecoration(hintText: 'Search clinic'),
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
                zoomControlsEnabled: true,
                zoomGesturesEnabled: true,
                buildingsEnabled: true,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
