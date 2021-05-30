import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:swp409/Components/default_button.dart';
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
  TimeOfDay openMon = TimeOfDay(hour: 7, minute: 00);
  TimeOfDay openTue = TimeOfDay(hour: 7, minute: 00);
  TimeOfDay openWed = TimeOfDay(hour: 7, minute: 00);
  TimeOfDay openThu = TimeOfDay(hour: 7, minute: 00);
  TimeOfDay openFri = TimeOfDay(hour: 7, minute: 00);
  TimeOfDay openSat = TimeOfDay(hour: 7, minute: 00);
  TimeOfDay openSun = TimeOfDay(hour: 7, minute: 00);

  TimeOfDay closeMon = TimeOfDay(hour: 7, minute: 00);
  TimeOfDay closeTue = TimeOfDay(hour: 7, minute: 00);
  TimeOfDay closeWed = TimeOfDay(hour: 7, minute: 00);
  TimeOfDay closeThu = TimeOfDay(hour: 7, minute: 00);
  TimeOfDay closeFri = TimeOfDay(hour: 7, minute: 00);
  TimeOfDay closeSat = TimeOfDay(hour: 7, minute: 00);
  TimeOfDay closeSun = TimeOfDay(hour: 7, minute: 00);

  Clinic _clinic = new Clinic();
  ClinicService _clinicService = new ClinicService();
  String url = "$ServerIP/api/v1/clinics";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _clinic = widget.clinic;
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
                    SizedBox(height: SizeConfig.screenHeight * 0.04),
                    DefaultButton(
                      text: "Submit",
                      press: () {
                        List<Schedule> _schedule = <Schedule>[];
                        _schedule.add(Schedule(
                            dayOfWeek: 1,
                            startTime: openMon.hour * 60 + openMon.minute,
                            endTime: closeMon.hour * 60 + closeMon.minute));
                        _schedule.add(Schedule(
                            dayOfWeek: 2,
                            startTime: openTue.hour * 60 + openTue.minute,
                            endTime: closeTue.hour * 60 + closeTue.minute));
                        _schedule.add(Schedule(
                            dayOfWeek: 3,
                            startTime: openWed.hour * 60 + openWed.minute,
                            endTime: closeWed.hour * 60 + closeWed.minute));
                        _schedule.add(Schedule(
                            dayOfWeek: 4,
                            startTime: openThu.hour * 60 + openThu.minute,
                            endTime: closeThu.hour * 60 + closeThu.minute));
                        _schedule.add(Schedule(
                            dayOfWeek: 5,
                            startTime: openFri.hour * 60 + openFri.minute,
                            endTime: closeFri.hour * 60 + closeFri.minute));
                        _schedule.add(Schedule(
                            dayOfWeek: 6,
                            startTime: openSat.hour * 60 + openSat.minute,
                            endTime: closeSat.hour * 60 + closeSat.minute));
                        _schedule.add(Schedule(
                            dayOfWeek: 0,
                            startTime: openSun.hour * 60 + openSun.minute,
                            endTime: closeSun.hour * 60 + closeSun.minute));
                        _clinic.schedule = _schedule;
                        print(_clinic.toJson());
                        _clinicService
                            .register(
                                url: url,
                                clinic: _clinic,
                                path: widget.imageFile)
                            .then((value) {
                          print(value.data);
                          if (value.data['status'] == 'success') {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => SignInScreen()));
                          } else {
                            print(value.data);
                          }
                        });
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

  Widget titleHeaderBuild() {
    return Row(
      children: [
        new Container(
          //padding: const EdgeInsets.all(5.0),
          margin: const EdgeInsets.only(left: 5.0),
          child: Text(
            'DAY',
            style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(width: SizeConfig.screenWidth * 0.25),
        new Container(
          //padding: const EdgeInsets.all(5.0),
          margin: const EdgeInsets.only(left: 5.0),
          child: Text(
            'OPEN',
            style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(width: 100),
        new Container(
          //padding: const EdgeInsets.all(5.0),
          margin: const EdgeInsets.only(left: 5.0),
          child: Text(
            'CLOSE',
            style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }

  Widget buildForm() {
    return Container(
      alignment: Alignment.center,
      child: Table(
        children: [
          TableRow(children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 8, 8, 15),
              child: Text(
                'DAY',
                style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 8, 8, 15),
              child: Text(
                'OPEN',
                style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 8, 8, 15),
              child: Text(
                'CLOSE',
                style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold),
              ),
            ),
          ]),
          //Monday
          TableRow(children: [
            Text(""),
            Text(""),
            Text(""),
          ]),
          TableRow(children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 10, 8, 6),
              child: Text(
                'Monday',
                style: TextStyle(fontSize: 20.0),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 0, 30, 6),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: kPrimaryColorLight, // background
                  onPrimary: kPrimaryLightColor, // foreground
                ),
                onPressed: _selectOpenMon,
                child: Text(openMon.format(context)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 0, 30, 6),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: kPrimaryColorLight, // background
                  onPrimary: kPrimaryLightColor, // foreground
                ),
                onPressed: _selectCloseMon,
                child: Text(closeMon.format(context)),
              ),
            ),
          ]),
          TableRow(children: [
            Text(""),
            Text(""),
            Text(""),
          ]),
          //Tuesday
          TableRow(children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 10, 8, 6),
              child: Text(
                'Tuesday',
                style: TextStyle(fontSize: 20.0),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 0, 30, 6),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: kPrimaryColorLight, // background
                  onPrimary: kPrimaryLightColor, // foreground
                ),
                onPressed: _selectOpenTue,
                child: Text(openTue.format(context)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 0, 30, 6),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: kPrimaryColorLight, // background
                  onPrimary: kPrimaryLightColor, // foreground
                ),
                onPressed: _selectCloseTue,
                child: Text(closeTue.format(context)),
              ),
            ),
          ]),
          TableRow(children: [
            Text(""),
            Text(""),
            Text(""),
          ]),
          //Wednesday
          TableRow(children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 10, 8, 6),
              child: Text(
                'Wednesday',
                style: TextStyle(fontSize: 20.0),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 0, 30, 6),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: kPrimaryColorLight, // background
                  onPrimary: kPrimaryLightColor, // foreground
                ),
                onPressed: _selectOpenWed,
                child: Text(openWed.format(context)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 0, 30, 6),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: kPrimaryColorLight, // background
                  onPrimary: kPrimaryLightColor, // foreground
                ),
                onPressed: _selectCloseWed,
                child: Text(closeWed.format(context)),
              ),
            ),
          ]),
          TableRow(children: [
            Text(""),
            Text(""),
            Text(""),
          ]),
          //Thursday
          TableRow(children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 10, 8, 6),
              child: Text(
                'Thursday',
                style: TextStyle(fontSize: 20.0),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 0, 30, 6),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: kPrimaryColorLight, // background
                  onPrimary: kPrimaryLightColor, // foreground
                ),
                onPressed: _selectOpenThu,
                child: Text(openThu.format(context)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 0, 30, 6),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: kPrimaryColorLight, // background
                  onPrimary: kPrimaryLightColor, // foreground
                ),
                onPressed: _selectCloseThu,
                child: Text(closeThu.format(context)),
              ),
            ),
          ]),
          TableRow(children: [
            Text(""),
            Text(""),
            Text(""),
          ]),
          //Friday
          TableRow(children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 10, 8, 6),
              child: Text(
                'Friday',
                style: TextStyle(fontSize: 20.0),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 0, 30, 6),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: kPrimaryColorLight, // background
                  onPrimary: kPrimaryLightColor, // foreground
                ),
                onPressed: _selectOpenFri,
                child: Text(openFri.format(context)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 0, 30, 6),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: kPrimaryColorLight, // background
                  onPrimary: kPrimaryLightColor, // foreground
                ),
                onPressed: _selectCloseFri,
                child: Text(closeFri.format(context)),
              ),
            ),
          ]),
          TableRow(children: [
            Text(""),
            Text(""),
            Text(""),
          ]),
          //Saturday
          TableRow(children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 10, 8, 6),
              child: Text(
                'Saturday',
                style: TextStyle(fontSize: 20.0),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 0, 30, 6),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: kPrimaryColorLight, // background
                  onPrimary: kPrimaryLightColor, // foreground
                ),
                onPressed: _selectOpenSat,
                child: Text(openSat.format(context)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 0, 30, 6),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: kPrimaryColorLight, // background
                  onPrimary: kPrimaryLightColor, // foreground
                ),
                onPressed: _selectCloseSat,
                child: Text(closeSat.format(context)),
              ),
            ),
          ]),
          TableRow(children: [
            Text(""),
            Text(""),
            Text(""),
          ]),
          //Sunday
          TableRow(children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 10, 8, 6),
              child: Text(
                'Sunday',
                style: TextStyle(fontSize: 20.0),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 0, 30, 6),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: kPrimaryColorLight, // background
                  onPrimary: kPrimaryLightColor, // foreground
                ),
                onPressed: _selectOpenSun,
                child: Text(openSun.format(context)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 0, 30, 6),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: kPrimaryColorLight, // background
                  onPrimary: kPrimaryLightColor, // foreground
                ),
                onPressed: _selectCloseSun,
                child: Text(closeSun.format(context)),
              ),
            ),
          ]),
        ],
      ),
    );
  }

  void _selectOpenMon() async {
    final TimeOfDay newTime = await showTimePicker(
      context: context,
      initialTime: openMon,
      initialEntryMode: TimePickerEntryMode.input,
    );
    if (newTime != null) {
      setState(() {
        openMon = newTime;
      });
    }
  }

  void _selectCloseMon() async {
    final TimeOfDay newTime = await showTimePicker(
      context: context,
      initialTime: closeMon,
      initialEntryMode: TimePickerEntryMode.input,
    );
    if (newTime != null) {
      setState(() {
        closeMon = newTime;
      });
    }
  }

  void _selectOpenTue() async {
    final TimeOfDay newTime = await showTimePicker(
      context: context,
      initialTime: openTue,
      initialEntryMode: TimePickerEntryMode.input,
    );
    if (newTime != null) {
      setState(() {
        openTue = newTime;
      });
    }
  }

  void _selectCloseTue() async {
    final TimeOfDay newTime = await showTimePicker(
      context: context,
      initialTime: closeTue,
      initialEntryMode: TimePickerEntryMode.input,
    );
    if (newTime != null) {
      setState(() {
        closeTue = newTime;
      });
    }
  }

  void _selectOpenWed() async {
    final TimeOfDay newTime = await showTimePicker(
      context: context,
      initialTime: openWed,
      initialEntryMode: TimePickerEntryMode.input,
    );
    if (newTime != null) {
      setState(() {
        openWed = newTime;
      });
    }
  }

  void _selectCloseWed() async {
    final TimeOfDay newTime = await showTimePicker(
      context: context,
      initialTime: closeWed,
      initialEntryMode: TimePickerEntryMode.input,
    );
    if (newTime != null) {
      setState(() {
        closeWed = newTime;
      });
    }
  }

  void _selectOpenThu() async {
    final TimeOfDay newTime = await showTimePicker(
      context: context,
      initialTime: openThu,
      initialEntryMode: TimePickerEntryMode.input,
    );
    if (newTime != null) {
      setState(() {
        openThu = newTime;
      });
    }
  }

  void _selectCloseThu() async {
    final TimeOfDay newTime = await showTimePicker(
      context: context,
      initialTime: closeThu,
      initialEntryMode: TimePickerEntryMode.input,
    );
    if (newTime != null) {
      setState(() {
        closeThu = newTime;
      });
    }
  }

  void _selectOpenFri() async {
    final TimeOfDay newTime = await showTimePicker(
      context: context,
      initialTime: openFri,
      initialEntryMode: TimePickerEntryMode.input,
    );
    if (newTime != null) {
      setState(() {
        openFri = newTime;
      });
    }
  }

  void _selectCloseFri() async {
    final TimeOfDay newTime = await showTimePicker(
      context: context,
      initialTime: closeFri,
      initialEntryMode: TimePickerEntryMode.input,
    );
    if (newTime != null) {
      setState(() {
        closeFri = newTime;
      });
    }
  }

  void _selectOpenSat() async {
    final TimeOfDay newTime = await showTimePicker(
      context: context,
      initialTime: openSat,
      initialEntryMode: TimePickerEntryMode.input,
    );
    if (newTime != null) {
      setState(() {
        openSat = newTime;
      });
    }
  }

  void _selectCloseSat() async {
    final TimeOfDay newTime = await showTimePicker(
      context: context,
      initialTime: closeSat,
      initialEntryMode: TimePickerEntryMode.input,
    );
    if (newTime != null) {
      setState(() {
        closeSat = newTime;
      });
    }
  }

  void _selectOpenSun() async {
    final TimeOfDay newTime = await showTimePicker(
      context: context,
      initialTime: openSun,
      initialEntryMode: TimePickerEntryMode.input,
    );
    if (newTime != null) {
      setState(() {
        openSun = newTime;
      });
    }
  }

  void _selectCloseSun() async {
    final TimeOfDay newTime = await showTimePicker(
      context: context,
      initialTime: closeSun,
      initialEntryMode: TimePickerEntryMode.input,
    );
    if (newTime != null) {
      setState(() {
        closeSun = newTime;
      });
    }
  }
}
