import 'package:flutter/material.dart';
import 'package:swp409/Models/user.dart';
import 'package:swp409/Services/ApiService/clinic_service.dart';
import 'package:swp409/constants.dart';
import 'package:swp409/size_config.dart';
import '../../constants.dart';
import 'listClinicSearchBySymp.dart';

class searchBySymptomScreen extends StatefulWidget {
  List<String> cookies;
  User user;
  searchBySymptomScreen({Key key, this.cookies, this.user}) : super(key: key);

  @override
  _searchBySymptomScreenState createState() => _searchBySymptomScreenState();
}

class _searchBySymptomScreenState extends State<searchBySymptomScreen> {
  List<bool> listIsSelected = [];
  List listSymptoms = [];
  List filter = [];
  ClinicService _clinicService = new ClinicService();
  User _user;
  List<String> _cookies;
  String searchController;
  String urlGetAllSymptoms = "$ServerIP/api/v1/specialists/symptoms";

  @override
  void initState() {
    fetchSymptoms().then((value) {
      setState(() {
        listSymptoms = value;
        filter = listSymptoms;
      });
    });
    super.initState();
    _cookies = widget.cookies;
    _user = widget.user;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: kPrimaryBackground,
        appBar: AppBar(
          leading: BackButton(
            onPressed: () => Navigator.pop(context),
            color: kPrimaryLightColor,
          ),
          title: Text(
            'Choose your symptoms',
            style: TextStyle(
                color: kPrimaryLightColor,
                fontWeight: FontWeight.bold,
                fontSize: 20),
          ),
          centerTitle: true,
          backgroundColor: kPrimaryAppbar,
        ),
        body: SafeArea(
            child: Column(
          children: [
            SizedBox(height: SizeConfig.screenHeight * 0.02),
            Text(
              "Symptoms",
              style: TextStyle(
                color: Colors.black,
                fontSize: getProportionateScreenWidth(28),
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              "Choose symptoms to find clinic",
            ),
            SizedBox(height: SizeConfig.screenHeight * 0.02),
            Container(
              margin: const EdgeInsets.only(left: 1, right: 1),
              child: TextField(
                decoration: InputDecoration(
                  fillColor: Colors.white,
                  filled: true,
                  contentPadding: EdgeInsets.all(8),
                  hintText: 'Search symptoms',
                  suffixIcon: Icon(
                    Icons.search_outlined,
                    color: kPrimaryAppbar,
                  ),
                  enabledBorder: new OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    borderSide: BorderSide(color: kPrimaryColor, width: 2),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: kPrimaryColor, width: 2),
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  // focusedBorder: OutlineInputBorder(
                  //   borderSide: BorderSide(color: kPrimaryColor),
                  // ),
                ),
                onChanged: (text) {
                  setState(() {
                    filter = listSymptoms
                        .where((val) =>
                            (val.toLowerCase().contains(text.toLowerCase())))
                        .toList();
                  });
                },
              ),
            ),
            Expanded(child: buildListSymptoms()),
            Container(
              padding: EdgeInsets.fromLTRB(24, 16, 24, 16),
              color: kPrimaryColorLight,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: StadiumBorder(),
                  minimumSize: Size.fromHeight(40),
                  primary: kPrimaryLightColor,
                ),
                child: Text(
                  "Submit",
                  style: TextStyle(
                      color: kPrimaryColor,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
                onPressed: () {
                  String urlSymptoms = "";
                  bool check = true;
                  for (int i = 0; i < listIsSelected.length; i++) {
                    if (listIsSelected[i]) {
                      if (check) {
                        urlSymptoms += listSymptoms[i];
                        check = false;
                      } else {
                        urlSymptoms += ",";
                        urlSymptoms += listSymptoms[i];
                      }
                    }
                  }
                  print("check: $urlSymptoms");
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => ListClinicSearchBySymp(
                            user: _user,
                            cookies: _cookies,
                            urlSymptoms: urlSymptoms,
                          )));
                },
              ),
            ),
          ],
        )),
      ),
    );
  }

  Widget buildListSymptoms() {
    return ListView.builder(
        itemCount: filter.length ?? "",
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(
              filter[index],
              style: TextStyle(
                color: listIsSelected[index] ? kPrimaryColor : Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            tileColor: null,
            trailing: listIsSelected[index]
                ? Icon(
                    Icons.check_outlined,
                    color: kPrimaryColor,
                  )
                : Icon(Icons.check_box_outline_blank, color: Colors.black),
            onTap: () {
              setState(() {
                listIsSelected[index] = !listIsSelected[index];
              });
            },
          );
        });
  }

  Future<List> fetchSymptoms() async {
    var fetchdata = await _clinicService.getAllSymptom(urlGetAllSymptoms);
    List list = <String>[];
    list = fetchdata.data['data']['data'] as List;
    for (int i = 0; i < list.length; i++) {
      listIsSelected.add(false);
    }
    return list;
  }
}
