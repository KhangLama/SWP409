import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:swp409/Models/clinic.dart';
import 'package:swp409/Models/specialist.dart';
import 'package:swp409/Services/ApiService/specialist_service.dart';
import 'package:swp409/constants.dart';

class SpecialistChooseScreen extends StatefulWidget {
  //const SpecialistChooseScreen({ Key? key }) : super(key: key);

  @override
  _SpecialistChooseScreenState createState() => _SpecialistChooseScreenState();
}

class _SpecialistChooseScreenState extends State<SpecialistChooseScreen> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text(
            "Choose Specialist",
            style: TextStyle(color: kPrimaryLightColor),
          ),
          backgroundColor: kPrimaryColor,
        ),
        body: SafeArea(child: buildListSpecialist()),
      ),
    );
  }

  List<bool> listIsSelected = [];
  List<Specialists> listSpecialist = <Specialists>[];

  @override
  void initState() {
    fetchSpecialists().then((value) {
      setState(() {
        listSpecialist = value;
      });
    });
    super.initState();
  }

  Widget buildListSpecialist() {
    return ListView.builder(
        itemCount: listSpecialist.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(
              listSpecialist[index].name,
              style: TextStyle(
                color:
                    listIsSelected[index] ? kPrimaryLightColor : Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            tileColor: listIsSelected[index] ? kPrimaryColorLight : null,
            trailing: listIsSelected[index]
                ? Icon(
                    Icons.check_outlined,
                    color: Colors.white,
                  )
                : Icon(Icons.check_box_outline_blank, color: Colors.black),
            onTap: () {
              setState(() {
                listIsSelected[index] = !listIsSelected[index];
                print(listIsSelected[index]);
              });
            },
          );
        });
  }

  String urlGetAllSpecialist = "$ServerIP/api/v1/specialists";
  SpecialistService specialistService = new SpecialistService();
  Future<List<Specialists>> fetchSpecialists() async {
    var fetchdata =
        await specialistService.getAllSpecialist(urlGetAllSpecialist);
    var list = <Specialists>[];
    var specjson = fetchdata.data['data']['data'] as List;

    for (var spec in specjson) {
      list.add(new Specialists.fromJson(spec));
    }

    for (int i = 0; i < list.length; i++) {
      listIsSelected.add(false);
    }
    return list;
  }
}
