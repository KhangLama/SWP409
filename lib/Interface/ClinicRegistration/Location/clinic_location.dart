import 'dart:async';
import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:swp409/Components/default_button.dart';
import 'package:swp409/Interface/ClinicRegistration/Date/clinic_date.dart';
import '../../../constants.dart';
import '../../../size_config.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart' as DotEnv;

// ignore: must_be_immutable
class ClinicLocationScreen extends StatefulWidget {
  String email, name, phone, description;
  ClinicLocationScreen(this.email, this.name, this.phone, this.description);

  @override
  _ClinicLocationScreenState createState() => _ClinicLocationScreenState();
}

class _ClinicLocationScreenState extends State<ClinicLocationScreen> {
  TextEditingController _searchController = new TextEditingController();
  Timer _timer;
  bool loading;
  final Completer<GoogleMapController> _controllerGoogleMap = Completer();
  GoogleMapController newGoogleMapController;
  final Set<Marker> _markers = {};
  GlobalKey<AutoCompleteTextFieldState> key = GlobalKey();
  List _suggest;
  @override
  void initState() {
    super.initState();
    print(widget.name);
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
    _timer = Timer(const Duration(milliseconds: 500), () {
      getLocationResult(_searchController.text);
    });
  }

  void getLocationResult(String txt) async {
    await DotEnv.load(fileName: ".env");
    if (txt.isEmpty) {
      return null;
    }
    var ggmapkey = DotEnv.env['GOOGLE_MAP_KEY'];
    String url = 'https://maps.googleapis.com/maps/api/place/autocomplete/json';
    String url2 = 'https://maps.googleapis.com/maps/api/place/details/json';
    String types = 'address';
    String request =
        '$url?input=$txt&key=$ggmapkey&type=$types&components=country:vn&language:vi';

    Response response = await Dio().get(request);
    print(response);
    final predictions = response.data['predictions'];
    // setState(() {
    //   _suggest = predictions.;
    // });
    for (int i = 0; i < predictions.length; i++) {}
    String request2 =
        '$url2?place_id=${predictions.last['place_id']}&key=$ggmapkey';
    Response response2 = await Dio().get(request2);
    print(response2);
  }

  Future<void> _onMapCreated(GoogleMapController controller) async {
    setState(() {
      newGoogleMapController = controller;
      _controllerGoogleMap.complete(controller);
    });
  }

  Future<void> markerCreate() async {
    try {} catch (e) {
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
          child: SingleChildScrollView(
            child: Container(
              child: ListBody(
                // mainAxisAlignment: MainAxisAlignment.center,
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
                  Container(
                    margin: const EdgeInsets.only(left: 1, right: 1),
                    child: TextField(
                      controller: _searchController,
                      //suggestionsAmount: 5,
                      decoration: InputDecoration(
                        fillColor: Colors.white,
                        filled: true,
                        contentPadding: EdgeInsets.all(8),
                        hintText: 'Enter clinic\'s address',
                        suffixIcon: Icon(
                          Icons.search_outlined,
                          color: kPrimaryColor,
                        ),
                        enabledBorder: new OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          //borderSide: BorderSide(color: kPrimaryColor, width: 2),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: kPrimaryColor, width: 2),
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                      ),
                      // suggestions: _suggest,
                      // itemFilter: (suggestion, String query) =>
                      //     suggestion['description']
                      //         .toString()
                      //         .toLowerCase()
                      //         .contains(query.toLowerCase()),
                      // itemBuilder: (context, suggestion) => row(suggestion),
                      // itemSorter: (a, b) =>
                      //     a['description'].toString().compareTo(b),
                      // itemSubmitted: (data) {
                      //   setState(() {
                      //     _searchController.text = data[0]['description'];
                      //   });
                      // },
                      // key: key,
                    ),
                  ),
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
                    ),
                  ),
                  Align(
                    alignment: FractionalOffset.bottomCenter,
                    child: Container(
                      margin:
                          const EdgeInsets.only(left: 1, right: 1, bottom: 5),
                      child: DefaultButton(
                        text: "Continue",
                        press: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ClinicDateScreen()));
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget row(List<Map<String, String>> suggestion) {
    return ListTile(
      title: Text(suggestion[0]['description']),
    );
  }
}
