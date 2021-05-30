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
import '../../../constants.dart';
import '../../../size_config.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart' as DotEnv;
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
  List<Clinic> _suggest = <Clinic>[];
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
    _timer = Timer(const Duration(milliseconds: 600), () {
      getLocationResult(_searchController.text);
    });
  }

  Future<List<String>> getSuggest(String query) async {
    List<String> matches = [];
    for (int i = 0; i < _suggest.length; i++) {
      matches.add(_suggest[i].address);
    }
    return matches;
  }

  Future<List<Clinic>> getLocationResult(String txt) async {
    await DotEnv.load(fileName: ".env");
    if (txt.isEmpty) {
      return null;
    }
    var ggmapkey = DotEnv.env['GOOGLE_MAP_KEY'];

    String types = 'address';
    String request =
        '$url?input=$txt&key=$ggmapkey&type=$types&components=country:vn&language:vi';

    Response response = await Dio().get(request);
    final predictions = response.data['predictions'] as List;
    List<Clinic> addresses = [];
    for (var p = 0; p < predictions.length; p++) {
      String addr = predictions[p]['description'];
      addresses.add(Clinic(address: addr));
    }
    setState(() {
      _suggest = addresses;
    });
    getCoor(predictions, ggmapkey);

    return addresses;
  }

  Future<void> getCoor(var predictions, String ggmapkey) async {
    String request2 =
        '$url2?place_id=${predictions.last['place_id']}&key=$ggmapkey';

    Response response2 = await Dio().get(request2);
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
      setState(() async {
        _markers.add(Marker(
          markerId: MarkerId('position'),
          draggable: false,
          position: LatLng(lat, lang),
        ));
        var latLngPosition = LatLng(lat, lang);

        var cameraPosition = CameraPosition(target: latLngPosition, zoom: 18);
        await newGoogleMapController
            .animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
      });
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
                    return ListTile(
                      title: Text(suggestion),
                    );
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
              Align(
                alignment: FractionalOffset.bottomCenter,
                child: Container(
                  margin: const EdgeInsets.only(left: 1, right: 1, bottom: 5),
                  child: DefaultButton(
                    text: "Continue",
                    press: () {
                      _clinic.address = _searchController.text;
                      print(lat);
                      print(lng);
                      List<Geometry> list = <Geometry>[];
                      list.add(
                          Geometry(coordinates: [lng, lat], type: "Point"));
                      print(list.length);
                      _clinic.geometry = list[0];

                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => ClinicDateScreen(
                              clinic: _clinic, imageFile: widget._imageFile)));
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget row(Clinic suggestion) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(suggestion.address, style: TextStyle(fontSize: 16))
      ],
    );
  }
}
