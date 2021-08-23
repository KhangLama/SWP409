import 'dart:async';
import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:swp409/Components/default_button.dart';
import 'package:swp409/Interface/ClinicRegistration/Date/clinic_date.dart';
import 'package:swp409/Models/clinic.dart';
import 'package:swp409/Models/suggestion.dart';
import '../../../constants.dart';
import '../../../size_config.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

// ignore: must_be_immutable
class ClinicLocationScreen extends StatefulWidget {
  String email, name, phone, description;
  PickedFile _imageFile;
  ClinicLocationScreen(
      this.email, this.name, this.phone, this.description, this._imageFile);

  @override
  _ClinicLocationScreenState createState() => _ClinicLocationScreenState();
}

class _ClinicLocationScreenState extends State<ClinicLocationScreen> {
  TextEditingController _searchController = new TextEditingController();
  Timer _timer;
  final Completer<GoogleMapController> _controllerGoogleMap = Completer();
  GoogleMapController newGoogleMapController;
  final Set<Marker> _markers = {};
  GlobalKey<AutoCompleteTextFieldState<Clinic>> key = GlobalKey();
  List<Suggestion> _suggest = <Suggestion>[];
  Clinic _clinic = new Clinic();
  Map<String, double> geo;
  double lat, lng;
  String url = 'https://maps.googleapis.com/maps/api/place/autocomplete/json';
  String url2 = 'https://maps.googleapis.com/maps/api/place/details/json';
  @override
  void initState() {
    super.initState();
    _clinic.email = widget.email;
    _clinic.name = widget.name;
    _clinic.phone = widget.phone;
    _clinic.description = widget.description;
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    super.dispose();
  }

  _onSearchChanged() {
    if (_timer?.isActive ?? false) _timer.cancel();
    _timer = Timer(const Duration(milliseconds: 2000), () {
      getLocationResult(_searchController.text);
    });
  }

  Future<List<String>> getSuggest(String query) async {
    List<String> matches = [];
    for (int i = 0; i < _suggest.length; i++) {
      matches.add(_suggest[i].description);
    }
    return matches;
  }

  Future<List<Suggestion>> getLocationResult(String txt) async {
    if (txt.isEmpty) {
      return null;
    }
    var ggmapkey = dotenv.env['GOOGLE_MAP_KEY'];

    String types = 'address';
    String request =
        '$url?input=$txt&key=$ggmapkey&type=$types&components=country:vn&language:vi';

    Response response = await Dio().get(request);
    print(response);
    List predictions = response.data['predictions'] as List;
    List<Suggestion> addresses = [];
    for (var p = 0; p < predictions.length; p++) {
      String addr = predictions[p]['description'];
      String placeId = predictions[p]['placeId'];

      addresses.add(Suggestion(description: addr, placeId: placeId));
    }
    print(predictions);
    setState(() {
      _suggest = addresses;
    });
    getCoor(predictions.first, ggmapkey);

    return addresses;
  }

  Future<void> getCoor(var predictions, String ggmapkey) async {
    String request2 = '$url2?place_id=${predictions['place_id']}&key=$ggmapkey';

    Response response2 = await Dio().get(request2);
    print(response2);
    lat = response2.data['result']['geometry']['location']['lat'];
    lng = response2.data['result']['geometry']['location']['lng'];
    markerCreate(lat, lng);
    return response2;
  }

  Future<void> _onMapCreated(GoogleMapController controller) async {
    setState(() {
      newGoogleMapController = controller;
      _controllerGoogleMap.complete(controller);
    });
  }

  Future<void> markerCreate(var lat, var lang) async {
    try {
      setState(() {
        _markers.add(Marker(
          markerId: MarkerId('position'),
          draggable: false,
          position: LatLng(lat, lang),
        ));
      });
      var latLngPosition = LatLng(lat, lang);

      var cameraPosition = CameraPosition(target: latLngPosition, zoom: 18);
      await newGoogleMapController
          .animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
    } catch (e) {
      rethrow;
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          leading: BackButton(
            onPressed: () => Navigator.pop(context),
          ),
          title: Text('Clinic Registration'),
          centerTitle: true,
          backgroundColor: kPrimaryAppbar,
        ),
        bottomNavigationBar: BottomAppBar(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: kPrimaryColor,
                      // background
                      onPrimary: Colors.white,
                      textStyle: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                      minimumSize: Size(SizeConfig.screenWidth - 40, 60),
                      shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.all(
                              Radius.circular(10))), // foreground
                    ),
                    onPressed: () {
                      _clinic.address = _searchController.text;
                      print(lat);
                      print(lng);
                      if (lat == null) {
                        toastFail("Please pick address");
                      } else {
                        List<Geometry> list = <Geometry>[];
                        list.add(
                            Geometry(coordinates: [lng, lat], type: "Point"));
                        print(list.length);
                        _clinic.geometry = list[0];

                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => ClinicDateScreen(
                                clinic: _clinic,
                                imageFile: widget._imageFile)));
                      }
                    },
                    child: Text('Continue')),
              ],
            ),
          ),
        ),
        body: SafeArea(
          child: ListView(
            physics: NeverScrollableScrollPhysics(),
            children: [
              SizedBox(height: SizeConfig.screenHeight * 0.02),
              Center(
                child: Text(
                  "Clinic Location",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: getProportionateScreenWidth(28),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Center(
                child: Text(
                  "Choose your clinic!",
                  textAlign: TextAlign.left,
                ),
              ),
              SizedBox(height: SizeConfig.screenHeight * 0.02),
              TypeAheadFormField(
                  textFieldConfiguration:
                      TextFieldConfiguration(controller: _searchController),
                  onSuggestionSelected: (pattern) {
                    _searchController.text = pattern;
                  },
                  itemBuilder: (context, suggestion) {
                    return row(suggestion);
                  },
                  transitionBuilder: (context, suggestionBox, builder) {
                    return suggestionBox;
                  },
                  suggestionsCallback: (pattern) {
                    return getSuggest(pattern);
                  }),
              SizedBox(height: SizeConfig.screenHeight * 0.02),
              Container(
                height: MediaQuery.of(context).size.height - 300,
                child: GoogleMap(
                  mapType: MapType.normal,
                  initialCameraPosition:
                      CameraPosition(target: LatLng(10.03711, 105.78825)),
                  onMapCreated: _onMapCreated,
                  myLocationButtonEnabled: true,
                  myLocationEnabled: true,
                  mapToolbarEnabled: true,
                  zoomGesturesEnabled: true,
                  buildingsEnabled: true,
                  markers: _markers,
                ),
              ),
              SizedBox(height: SizeConfig.screenHeight * 0.01),
            ],
          ),
        ),
      ),
    );
  }

  row(String suggestion) {
    return FutureBuilder(
      future: Future.delayed(Duration(seconds: 1)),
      builder: (c, s) => s.connectionState == ConnectionState.done
          ? Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(
                    child: Text(suggestion, style: TextStyle(fontSize: 16)))
              ],
            )
          : Center(child: CircularProgressIndicator()),
    );
  }
}
