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
  List<Symptom> listSymptoms = <Symptom>[];
  List temp = [];
  List<Symptom> filter = <Symptom>[];
  ClinicService _clinicService = new ClinicService();
  User _user;
  List<String> _cookies;
  String searchController;
  String urlGetAllSymptoms = "$ServerIP/api/v1/specialists/symptoms";

  @override
  void initState() {
    fetchSymptoms().then((value) {
      setState(() {
        temp = value;
      });
    });
    super.initState();
    _cookies = widget.cookies;
    _user = widget.user;
    setState(() {
      filter = listSymptoms;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
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
                      String urlSymptoms = "";
                      bool check = true;
                      for (int i = 0; i < listSymptoms.length; i++) {
                        if (listSymptoms[i].status) {
                          if (check) {
                            urlSymptoms += listSymptoms[i].name;
                            check = false;
                          } else {
                            urlSymptoms += ",";
                            urlSymptoms += listSymptoms[i].name;
                          }
                        }
                      }
                      if (urlSymptoms == "") {
                        toastFail("Please choose at least 1");
                      } else {
                        print("check: $urlSymptoms");
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => ListClinicSearchBySymp(
                                  user: _user,
                                  cookies: _cookies,
                                  urlSymptoms: urlSymptoms,
                                )));
                      }
                    },
                    child: Text('Submit')),
              ],
            ),
          ),
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
                        .where((val) => (val.name
                            .toLowerCase()
                            .contains(text.toLowerCase())))
                        .toList();
                  });
                },
              ),
            ),
            Expanded(child: buildListSymptoms()),
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
              filter[index].name,
              style: TextStyle(
                color: filter[index].status ? kPrimaryColor : Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            tileColor: null,
            trailing: filter[index].status
                ? Icon(
                    Icons.check_outlined,
                    color: kPrimaryColor,
                  )
                : Icon(Icons.check_box_outline_blank, color: Colors.black),
            onTap: () {
              setState(() {
                filter[index].status = !filter[index].status;
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
      listSymptoms.add(Symptom(list[i], false));
    }
    return list;
  }
}

class Symptom {
  String name;
  bool status = false;
  Symptom(this.name, this.status);
}
