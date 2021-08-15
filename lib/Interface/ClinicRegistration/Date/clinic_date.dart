import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:swp409/Components/default_button.dart';
import 'package:swp409/Interface/ClinicRegistration/Specialist/clinic_specialist.dart';
import 'package:swp409/Models/clinic.dart';
import 'package:swp409/Services/ApiService/clinic_service.dart';
import 'package:swp409/Services/Authentication/sign_in/sign_in_screen.dart';
import '../../../size_config.dart';
import '../../../constants.dart';

class ClinicDateScreen extends StatefulWidget {
  Clinic clinic;
  PickedFile imageFile;
  ClinicDateScreen({Key key, this.clinic, this.imageFile}) : super(key: key);
  @override
  _ClinicDateScreenState createState() => _ClinicDateScreenState();
}

class _ClinicDateScreenState extends State<ClinicDateScreen> {
  List<bool> isSelected = [false, false, false, false, false, false, false];

  List<TimeWorking> listTime = [TimeWorking(open: 420, close: 600)];

  List<TimeWorking> listTimeMon = [];
  List<TimeWorking> listTimeTue = [];
  List<TimeWorking> listTimeWed = [];
  List<TimeWorking> listTimeThu = [];
  List<TimeWorking> listTimeFri = [];
  List<TimeWorking> listTimeSat = [];
  List<TimeWorking> listTimeSun = [];

  TimeOfDay close = TimeOfDay(hour: 17, minute: 00);

  Clinic _clinic = new Clinic();
  ClinicService _clinicService = new ClinicService();
  String url = "$ServerIP/api/v1/clinics";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _clinic = widget.clinic;
  }

  void _showDialog() {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return StatefulBuilder(builder: (context, setState) {
          void _selectOpen(int index) async {
            int hourInit = listTime[index].open ~/ 60;
            int minInit = listTime[index].open % 60;
            TimeOfDay openInit = TimeOfDay(hour: hourInit, minute: minInit);
            final TimeOfDay newTime = await showTimePicker(
              context: context,
              initialTime: openInit,
              initialEntryMode: TimePickerEntryMode.input,
            );
            if (newTime != null) {
              setState(() {
                openInit = newTime;
                listTime[index].open = newTime.hour * 60 + newTime.minute;
              });
            }
          }

          void _selectClose(int index) async {
            int hourInit = listTime[index].close ~/ 60;
            int minInit = listTime[index].close % 60;
            TimeOfDay closeInit = TimeOfDay(hour: hourInit, minute: minInit);
            final TimeOfDay newTime = await showTimePicker(
              context: context,
              initialTime: closeInit,
              initialEntryMode: TimePickerEntryMode.input,
            );
            if (newTime != null) {
              setState(() {
                closeInit = newTime;
                listTime[index].close = newTime.hour * 60 + newTime.minute;
              });
            }
          }

          return AlertDialog(
            shape: RoundedRectangleBorder(
                side: BorderSide(color: kPrimaryColor, width: 2)),
            content: Container(
              height: 365,
              width: 300,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                      Text(
                        "OPEN HOUR",
                        style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: kPrimaryColor),
                      ),
                    ]),
                    SizedBox(height: 25),
                    Row(
                      children: [
                        SizedBox(
                          width: 5,
                        ),
                        Text('Choose day',
                            style:
                                TextStyle(color: kPrimaryColor, fontSize: 20)),
                      ],
                    ),
                    SizedBox(height: 20),
                    Container(
                      //color: Colors.white,
                      child: ToggleButtons(
                        constraints:
                            BoxConstraints(minHeight: 35, minWidth: 35),

                        isSelected: isSelected,

                        color: kPrimaryColor,
                        // mau cua chu khi k chon

                        selectedColor: kPrimaryLightColor,
                        // mau trang cua chu khi chon

                        borderWidth: 2,

                        borderColor: kPrimaryColorLight,

                        selectedBorderColor: kPrimaryColor,

                        fillColor: kPrimaryColorLight,

                        children: <Widget>[
                          Text('MO', style: TextStyle(fontSize: 18)),
                          Text('TU', style: TextStyle(fontSize: 18)),
                          Text('WE', style: TextStyle(fontSize: 18)),
                          Text('TH', style: TextStyle(fontSize: 18)),
                          Text('FR', style: TextStyle(fontSize: 18)),
                          Text('SA', style: TextStyle(fontSize: 18)),
                          Text('SU', style: TextStyle(fontSize: 18)),
                        ],
                        onPressed: (int idx) {
                          setState(() {
                            isSelected[idx] = !isSelected[idx];
                          });
                        },
                      ),
                    ),
                    SizedBox(height: 20),
                    Row(
                      children: [
                        TextButton(
                          style: TextButton.styleFrom(
                            textStyle: const TextStyle(fontSize: 20),
                          ),
                          onPressed: () {
                            setState(() {
                              int openTemp =
                                  (420 + 240 * listTime.length) < 1200
                                      ? (420 + 240 * listTime.length)
                                      : 1140;
                              int closeTemp =
                                  (600 + 240 * listTime.length) < 1440
                                      ? (600 + 240 * listTime.length)
                                      : 1380;
                              listTime.add(TimeWorking(
                                  open: openTemp, close: closeTemp));
                            });
                          },
                          child: const Text(
                            'Click here to add hours',
                            style: TextStyle(color: kPrimaryColor),
                          ),
                        ),
                      ],
                    ),
                    Container(
                      height: 60 * listTime.length.toDouble(),
                      width: 250,
                      child: ListView.builder(
                          itemCount: listTime.length,
                          itemBuilder: (context, index) {
                            return Container(
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            0, 5, 10, 5),
                                        child: ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            primary:
                                                kPrimaryColorLight, // background
                                            onPrimary:
                                                kPrimaryLightColor, // foreground
                                          ),
                                          onPressed: () {
                                            _selectOpen(index);
                                          },
                                          child: Text(
                                            '${(listTime[index].open ~/ 60).toString().padLeft(2, '0')}:${(listTime[index].open % 60).toString().padLeft(2, '0')}',
                                            style: TextStyle(fontSize: 18),
                                          ),
                                        ),
                                      ),
                                      Text(
                                        "-",
                                        style: TextStyle(
                                            fontSize: 30, color: kPrimaryColor),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            10, 5, 10, 5),
                                        child: ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            primary:
                                                kPrimaryColorLight, // background
                                            onPrimary:
                                                kPrimaryLightColor, //// foreground
                                          ),
                                          onPressed: () {
                                            _selectClose(index);
                                          },
                                          child: Text(
                                            '${(listTime[index].close ~/ 60).toString().padLeft(2, '0')}:${(listTime[index].close % 60).toString().padLeft(2, '0')}',
                                            style: TextStyle(fontSize: 18),
                                          ),
                                        ),
                                      ),
                                      IconButton(
                                        icon: const Icon(Icons.close),
                                        color: kPrimaryColor,
                                        onPressed: () {
                                          setState(() {
                                            listTime.removeAt(index);
                                          });
                                        },
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            );
                          }),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                      TextButton(
                        style: TextButton.styleFrom(
                          textStyle: const TextStyle(fontSize: 20),
                        ),
                        onPressed: () {
                          Navigator.of(context).pop(false);
                        },
                        child: const Text(
                          'Cancel',
                          style: TextStyle(color: kPrimaryColor),
                        ),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      // ignore: deprecated_member_use
                      FlatButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        color: kPrimaryColorLight,
                        child: Text(
                          "Add",
                          style: TextStyle(
                            fontSize: getProportionateScreenWidth(18),
                            color: Colors.white,
                          ),
                        ),
                        onPressed: () {
                          Navigator.of(context).pop(true);
                        },
                      ),
                    ]),
                  ],
                ),
              ),
            ),
          );
        });
      },
    ).then((value) {
      if (value) {
        List<TimeWorking> listTemp = [];

        if (isSelected[0]) {
          setState(() {
            listTimeMon = listTime;
          });
        } else {
          setState(() {
            listTimeMon = listTemp;
          });
        }

        if (isSelected[1]) {
          setState(() {
            listTimeTue = listTime;
          });
        } else {
          setState(() {
            listTimeTue = listTemp;
          });
        }

        if (isSelected[2]) {
          setState(() {
            listTimeWed = listTime;
          });
        } else {
          setState(() {
            listTimeWed = listTemp;
          });
        }

        if (isSelected[3]) {
          setState(() {
            listTimeThu = listTime;
          });
        } else {
          setState(() {
            listTimeThu = listTemp;
          });
        }

        if (isSelected[4]) {
          setState(() {
            listTimeFri = listTime;
          });
        } else {
          setState(() {
            listTimeFri = listTemp;
          });
        }

        if (isSelected[5]) {
          setState(() {
            listTimeSat = listTime;
          });
        } else {
          setState(() {
            listTimeSat = listTemp;
          });
        }

        if (isSelected[6]) {
          setState(() {
            listTimeSun = listTime;
          });
        } else {
          setState(() {
            listTimeSun = listTemp;
          });
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          leading: BackButton(
            onPressed: () => Navigator.pop(context),
          ),
          title: Text('Clinic Registration'),
          centerTitle: true,
          backgroundColor: kPrimaryAppbar,
        ),
        floatingActionButton: FloatingActionButton(
          child: Container(
            width: 60,
            height: 60,
            child: Icon(
              Icons.edit,
              size: 30,
            ),
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                    colors: [Color(0xFFFF9966), Color(0xFFFF5E62)])),
          ),
          onPressed: () {
            _showDialog();
          },
        ),
        body: SafeArea(
          child: SizedBox(
            width: double.infinity,
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: getProportionateScreenWidth(20)),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(height: SizeConfig.screenHeight * 0.02),
                    Text(
                      "Clinic Open Time",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: getProportionateScreenWidth(28),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "Fill in your clinic working time",
                    ),
                    SizedBox(height: SizeConfig.screenHeight * 0.04),
                    buildForm(),
                    SizedBox(height: SizeConfig.screenHeight * 0.06),
                    DefaultButton(
                      text: "Countinue",
                      press: () {
                        List<Schedule> _schedule = <Schedule>[];
                        //add monday working hour
                        List<WorkingHours> _workingHoursMon = <WorkingHours>[];
                        for (int i = 0; i < listTimeMon.length; i++) {
                          _workingHoursMon.add(WorkingHours(
                            startTime: listTimeMon[i].open,
                            endTime: listTimeMon[i].close,
                          ));
                        }
                        //add tuesday working hour
                        List<WorkingHours> _workingHoursTue = <WorkingHours>[];
                        for (int i = 0; i < listTimeTue.length; i++) {
                          _workingHoursTue.add(WorkingHours(
                            startTime: listTimeTue[i].open,
                            endTime: listTimeTue[i].close,
                          ));
                        }
                        //add wednesday working hour
                        List<WorkingHours> _workingHoursWed = <WorkingHours>[];
                        for (int i = 0; i < listTimeWed.length; i++) {
                          _workingHoursWed.add(WorkingHours(
                            startTime: listTimeWed[i].open,
                            endTime: listTimeWed[i].close,
                          ));
                        }
                        //add thursday working hour
                        List<WorkingHours> _workingHoursThu = <WorkingHours>[];
                        for (int i = 0; i < listTimeThu.length; i++) {
                          _workingHoursThu.add(WorkingHours(
                            startTime: listTimeThu[i].open,
                            endTime: listTimeThu[i].close,
                          ));
                        }
                        //add friday working hour
                        List<WorkingHours> _workingHoursFri = <WorkingHours>[];
                        for (int i = 0; i < listTimeFri.length; i++) {
                          _workingHoursFri.add(WorkingHours(
                            startTime: listTimeFri[i].open,
                            endTime: listTimeFri[i].close,
                          ));
                        }
                        //add saturday working hour
                        List<WorkingHours> _workingHoursSat = <WorkingHours>[];
                        for (int i = 0; i < listTimeSat.length; i++) {
                          _workingHoursSat.add(WorkingHours(
                            startTime: listTimeSat[i].open,
                            endTime: listTimeSat[i].close,
                          ));
                        }
                        //add sunday working hour
                        List<WorkingHours> _workingHoursSun = <WorkingHours>[];
                        for (int i = 0; i < listTimeSun.length; i++) {
                          _workingHoursSun.add(WorkingHours(
                            startTime: listTimeSun[i].open,
                            endTime: listTimeSun[i].close,
                          ));
                        }

                        _schedule.add(Schedule(
                          workingHours: _workingHoursSun,
                          dayOfWeek: 0,
                        ));
                        _schedule.add(Schedule(
                          workingHours: _workingHoursMon,
                          dayOfWeek: 1,
                        ));
                        _schedule.add(Schedule(
                          workingHours: _workingHoursTue,
                          dayOfWeek: 2,
                        ));
                        _schedule.add(Schedule(
                          workingHours: _workingHoursWed,
                          dayOfWeek: 3,
                        ));
                        _schedule.add(Schedule(
                          workingHours: _workingHoursThu,
                          dayOfWeek: 4,
                        ));
                        _schedule.add(Schedule(
                          workingHours: _workingHoursFri,
                          dayOfWeek: 5,
                        ));
                        _schedule.add(Schedule(
                          workingHours: _workingHoursSat,
                          dayOfWeek: 6,
                        ));

                        _clinic.schedule = _schedule;

                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => SpecialistChooseScreen(
                                clinic: _clinic, imageFile: widget.imageFile)));
                      },
                    ),
                    SizedBox(height: getProportionateScreenHeight(5)),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildForm() {
    return Container(
      alignment: Alignment.center,
      child: Column(
        children: [
          Row(
            children: [
              SizedBox(
                width: 150,
                child: Text(
                  'DAY',
                  style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                ),
              ),
              Text(
                'TIME',
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          //Monday
          Row(
            children: [
              Container(
                height: 30,
                width: 150,
                child: Text(
                  'Monday',
                  style: TextStyle(fontSize: 20.0),
                ),
              ),
              Container(
                width: 150,
                height: listTimeMon.length == 0
                    ? 30
                    : (listTimeMon.length * 30).toDouble(),
                child: listTimeMon.length == 0
                    ? Text(
                        "Closed",
                        style: TextStyle(fontSize: 20.0),
                      )
                    : ListView.builder(
                        itemCount: listTimeMon.length,
                        itemBuilder: (context, index) {
                          return Container(
                            padding: EdgeInsets.fromLTRB(2, 0, 0, 10),
                            child: Text(
                              '${(listTimeMon[index].open ~/ 60).toString().padLeft(2, '0')}:'
                              '${(listTimeMon[index].open % 60).toString().padLeft(2, '0')} - '
                              '${(listTimeMon[index].close ~/ 60).toString().padLeft(2, '0')}:'
                              '${(listTimeMon[index].close % 60).toString().padLeft(2, '0')}',
                              style: TextStyle(fontSize: 20),
                            ),
                          );
                        }),
              ),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          //Tuesday
          Row(
            children: [
              Container(
                height: 30,
                width: 150,
                child: Text(
                  'Tuesday',
                  style: TextStyle(fontSize: 20.0),
                ),
              ),
              Container(
                width: 150,
                height: listTimeTue.length == 0
                    ? 30
                    : (listTimeTue.length * 30).toDouble(),
                child: listTimeTue.length == 0
                    ? Text(
                        "Closed",
                        style: TextStyle(fontSize: 20.0),
                      )
                    : ListView.builder(
                        itemCount: listTimeTue.length,
                        itemBuilder: (context, index) {
                          return Container(
                            padding: EdgeInsets.fromLTRB(2, 0, 0, 10),
                            child: Text(
                              '${(listTimeTue[index].open ~/ 60).toString().padLeft(2, '0')}:'
                              '${(listTimeTue[index].open % 60).toString().padLeft(2, '0')} - '
                              '${(listTimeTue[index].close ~/ 60).toString().padLeft(2, '0')}:'
                              '${(listTimeTue[index].close % 60).toString().padLeft(2, '0')}',
                              style: TextStyle(fontSize: 20),
                            ),
                          );
                        }),
              ),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          //Wednesday
          Row(
            children: [
              Container(
                height: 30,
                width: 150,
                child: Text(
                  'Wednesday',
                  style: TextStyle(fontSize: 20.0),
                ),
              ),
              Container(
                width: 150,
                height: listTimeWed.length == 0
                    ? 30
                    : (listTimeWed.length * 30).toDouble(),
                child: listTimeWed.length == 0
                    ? Text(
                        "Closed",
                        style: TextStyle(fontSize: 20.0),
                      )
                    : ListView.builder(
                        itemCount: listTimeWed.length,
                        itemBuilder: (context, index) {
                          return Container(
                            padding: EdgeInsets.fromLTRB(2, 0, 0, 10),
                            child: Text(
                              '${(listTimeWed[index].open ~/ 60).toString().padLeft(2, '0')}:'
                              '${(listTimeWed[index].open % 60).toString().padLeft(2, '0')} - '
                              '${(listTimeWed[index].close ~/ 60).toString().padLeft(2, '0')}:'
                              '${(listTimeWed[index].close % 60).toString().padLeft(2, '0')}',
                              style: TextStyle(fontSize: 20),
                            ),
                          );
                        }),
              ),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          //Thursday
          Row(
            children: [
              Container(
                height: 30,
                width: 150,
                child: Text(
                  'Thursday',
                  style: TextStyle(fontSize: 20.0),
                ),
              ),
              Container(
                width: 150,
                height: listTimeThu.length == 0
                    ? 30
                    : (listTimeThu.length * 30).toDouble(),
                child: listTimeThu.length == 0
                    ? Text(
                        "Closed",
                        style: TextStyle(fontSize: 20.0),
                      )
                    : ListView.builder(
                        itemCount: listTimeThu.length,
                        itemBuilder: (context, index) {
                          return Container(
                            padding: EdgeInsets.fromLTRB(2, 0, 0, 10),
                            child: Text(
                              '${(listTimeThu[index].open ~/ 60).toString().padLeft(2, '0')}:'
                              '${(listTimeThu[index].open % 60).toString().padLeft(2, '0')} - '
                              '${(listTimeThu[index].close ~/ 60).toString().padLeft(2, '0')}:'
                              '${(listTimeThu[index].close % 60).toString().padLeft(2, '0')}',
                              style: TextStyle(fontSize: 20),
                            ),
                          );
                        }),
              ),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          //Friday
          Row(
            children: [
              Container(
                height: 30,
                width: 150,
                child: Text(
                  'Friday',
                  style: TextStyle(fontSize: 20.0),
                ),
              ),
              Container(
                width: 150,
                height: listTimeFri.length == 0
                    ? 30
                    : (listTimeFri.length * 30).toDouble(),
                child: listTimeFri.length == 0
                    ? Text(
                        "Closed",
                        style: TextStyle(fontSize: 20.0),
                      )
                    : ListView.builder(
                        itemCount: listTimeFri.length,
                        itemBuilder: (context, index) {
                          return Container(
                            padding: EdgeInsets.fromLTRB(2, 0, 0, 10),
                            child: Text(
                              '${(listTimeFri[index].open ~/ 60).toString().padLeft(2, '0')}:'
                              '${(listTimeFri[index].open % 60).toString().padLeft(2, '0')} - '
                              '${(listTimeFri[index].close ~/ 60).toString().padLeft(2, '0')}:'
                              '${(listTimeFri[index].close % 60).toString().padLeft(2, '0')}',
                              style: TextStyle(fontSize: 20),
                            ),
                          );
                        }),
              ),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          //Saturday
          Row(
            children: [
              Container(
                height: 30,
                width: 150,
                child: Text(
                  'Saturday',
                  style: TextStyle(fontSize: 20.0),
                ),
              ),
              Container(
                width: 150,
                height: listTimeSat.length == 0
                    ? 30
                    : (listTimeSat.length * 30).toDouble(),
                child: listTimeSat.length == 0
                    ? Text(
                        "Closed",
                        style: TextStyle(fontSize: 20.0),
                      )
                    : ListView.builder(
                        itemCount: listTimeSat.length,
                        itemBuilder: (context, index) {
                          return Container(
                            padding: EdgeInsets.fromLTRB(2, 0, 0, 10),
                            child: Text(
                              '${(listTimeSat[index].open ~/ 60).toString().padLeft(2, '0')}:'
                              '${(listTimeSat[index].open % 60).toString().padLeft(2, '0')} - '
                              '${(listTimeSat[index].close ~/ 60).toString().padLeft(2, '0')}:'
                              '${(listTimeSat[index].close % 60).toString().padLeft(2, '0')}',
                              style: TextStyle(fontSize: 20),
                            ),
                          );
                        }),
              ),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          //Sunday
          Row(
            children: [
              Container(
                height: 30,
                width: 150,
                child: Text(
                  'Sunday',
                  style: TextStyle(fontSize: 20.0),
                ),
              ),
              Container(
                width: 150,
                height: listTimeSun.length == 0
                    ? 30
                    : (listTimeSun.length * 30).toDouble(),
                child: listTimeSun.length == 0
                    ? Text(
                        "Closed",
                        style: TextStyle(fontSize: 20.0),
                      )
                    : ListView.builder(
                        itemCount: listTimeSun.length,
                        itemBuilder: (context, index) {
                          return Container(
                            padding: EdgeInsets.fromLTRB(2, 0, 0, 10),
                            child: Text(
                              '${(listTimeSun[index].open ~/ 60).toString().padLeft(2, '0')}:'
                              '${(listTimeSun[index].open % 60).toString().padLeft(2, '0')} - '
                              '${(listTimeSun[index].close ~/ 60).toString().padLeft(2, '0')}:'
                              '${(listTimeSun[index].close % 60).toString().padLeft(2, '0')}',
                              style: TextStyle(fontSize: 20),
                            ),
                          );
                        }),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class TimeWidget extends StatefulWidget {
  @override
  _TimeWidgetState createState() => _TimeWidgetState();
}

class _TimeWidgetState extends State<TimeWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: kPrimaryColorLight, // background
                    onPrimary: kPrimaryLightColor, // foreground
                  ),
                  onPressed: _selectOpen,
                  child: Text(
                    open.format(context),
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ),
              Text(
                "-",
                style: TextStyle(fontSize: 30),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: kPrimaryColorLight, // background
                    onPrimary: kPrimaryLightColor, //// foreground
                  ),
                  onPressed: _selectClose,
                  child: Text(
                    close.format(context),
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  TimeOfDay open = TimeOfDay(hour: 8, minute: 00);
  TimeOfDay close = TimeOfDay(hour: 17, minute: 00);

  void _selectOpen() async {
    final TimeOfDay newTime = await showTimePicker(
      context: context,
      initialTime: open,
      initialEntryMode: TimePickerEntryMode.input,
    );
    if (newTime != null) {
      setState(() {
        open = newTime;
      });
    }
  }

  void _selectClose() async {
    final TimeOfDay newTime = await showTimePicker(
      context: context,
      initialTime: close,
      initialEntryMode: TimePickerEntryMode.input,
    );
    if (newTime != null) {
      setState(() {
        close = newTime;
      });
    }
  }
}

class TimeWorking {
  int open;
  int close;

  TimeWorking({this.open, this.close});
}
