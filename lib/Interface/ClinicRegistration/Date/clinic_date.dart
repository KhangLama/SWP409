import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:swp409/Components/default_button.dart';
import 'package:swp409/Services/Authentication/sign_in/sign_in_screen.dart';
import '../../../size_config.dart';
import '../../../constants.dart';

class ClinicDateScreen extends StatefulWidget {
  @override
  _ClinicDateScreenState createState() => _ClinicDateScreenState();
}

class _ClinicDateScreenState extends State<ClinicDateScreen> {
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
                      "Clinic Working day",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: getProportionateScreenWidth(28),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "Fill in your clinic working date",
                      textAlign: TextAlign.left,
                    ),
                    SizedBox(height: SizeConfig.screenHeight * 0.04),
                    titleHeaderBuild(),
                    SizedBox(height: getProportionateScreenHeight(30)),
                    mondayBuild(),
                    SizedBox(height: getProportionateScreenHeight(25)),
                    tuesdayBuild(),
                    SizedBox(height: getProportionateScreenHeight(25)),
                    wednesdayBuild(),
                    SizedBox(height: getProportionateScreenHeight(25)),
                    thursdayBuild(),
                    SizedBox(height: getProportionateScreenHeight(25)),
                    fridayBuild(),
                    SizedBox(height: getProportionateScreenHeight(25)),
                    saturdayBuild(),
                    SizedBox(height: getProportionateScreenHeight(25)),
                    sundayBuild(),
                    SizedBox(height: SizeConfig.screenHeight * 0.04),
                    DefaultButton(
                      text: "Continue",
                      press: () {
                        print("MON open: ${openMon.format(context)} close: ${closeMon.format(context)}");
                        print("TUE open: ${openTue.format(context)} close: ${closeTue.format(context)}");
                        print("WED open: ${openWed.format(context)} close: ${closeWed.format(context)}");
                        print("THU open: ${openThu.format(context)} close: ${closeThu.format(context)}");
                        print("FRI open: ${openFri.format(context)} close: ${closeFri.format(context)}");
                        print("SAT open: ${openSat.format(context)} close: ${closeSat.format(context)}");
                        print("SUN open: ${openSun.format(context)} close: ${closeSun.format(context)}");
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SignInScreen()));
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

  Widget mondayBuild() {
    return Row(
      children: [
        new Container(
          //padding: const EdgeInsets.all(5.0),
          margin: const EdgeInsets.only(left: 5.0),
          child: Text(
            'Monday',
            style: TextStyle(fontSize: 18.0),
          ),
        ),
        SizedBox(width: SizeConfig.screenWidth * 0.21),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: kPrimaryColorLight, // background
            onPrimary: kPrimaryLightColor, // foreground
          ),
          onPressed: _selectOpenMon,
          child: Text(openMon.format(context)),
        ),
        SizedBox(width: SizeConfig.screenWidth * 0.14),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: kPrimaryColorLight, // background
            onPrimary: kPrimaryLightColor, // foreground
          ),
          onPressed: _selectCloseMon,
          child: Text(closeMon.format(context)),
        ),
      ],
    );
  }

  Widget tuesdayBuild() {
    return Row(
      children: [
        new Container(
          //padding: const EdgeInsets.all(5.0),
          margin: const EdgeInsets.only(left: 5.0),
          child: Text(
            'Tuesday',
            style: TextStyle(fontSize: 18.0),
          ),
        ),
        SizedBox(width: SizeConfig.screenWidth * 0.205),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: kPrimaryColorLight, // background
            onPrimary: kPrimaryLightColor, // foreground
          ),
          onPressed: _selectOpenTue,
          child: Text(openTue.format(context)),
        ),
        SizedBox(width: SizeConfig.screenWidth * 0.14),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: kPrimaryColorLight, // background
            onPrimary: kPrimaryLightColor, // foreground
          ),
          onPressed: _selectCloseTue,
          child: Text(closeTue.format(context)),
        ),
      ],
    );
  }

  Widget wednesdayBuild() {
    return Row(
      children: [
        new Container(
          //padding: const EdgeInsets.all(5.0),
          margin: const EdgeInsets.only(left: 5.0),
          child: Text(
            'Wednesday',
            style: TextStyle(fontSize: 18.0),
          ),
        ),
        SizedBox(width: SizeConfig.screenWidth * 0.15),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: kPrimaryColorLight, // background
            onPrimary: kPrimaryLightColor, // foreground
          ),
          onPressed: _selectOpenWed,
          child: Text(openWed.format(context)),
        ),
        SizedBox(width: SizeConfig.screenWidth * 0.14),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: kPrimaryColorLight, // background
            onPrimary: kPrimaryLightColor, // foreground
          ),
          onPressed: _selectCloseWed,
          child: Text(closeWed.format(context)),
        ),
      ],
    );
  }

  Widget thursdayBuild() {
    return Row(
      children: [
        new Container(
          //padding: const EdgeInsets.all(5.0),
          margin: const EdgeInsets.only(left: 5.0),
          child: Text(
            'Thursday',
            style: TextStyle(fontSize: 18.0),
          ),
        ),
        SizedBox(width: SizeConfig.screenWidth * 0.188),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: kPrimaryColorLight, // background
            onPrimary: kPrimaryLightColor, // foreground
          ),
          onPressed: _selectOpenThu,
          child: Text(openThu.format(context)),
        ),
        SizedBox(width: SizeConfig.screenWidth * 0.14),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: kPrimaryColorLight, // background
            onPrimary: kPrimaryLightColor, // foreground
          ),
          onPressed: _selectCloseThu,
          child: Text(closeThu.format(context)),
        ),
      ],
    );
  }

  Widget fridayBuild() {
    return Row(
      children: [
        new Container(
          //padding: const EdgeInsets.all(5.0),
          margin: const EdgeInsets.only(left: 5.0),
          child: Text(
            'Friday',
            style: TextStyle(fontSize: 18.0),
          ),
        ),
        SizedBox(width: SizeConfig.screenWidth * 0.242),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: kPrimaryColorLight, // background
            onPrimary: kPrimaryLightColor, // foreground
          ),
          onPressed: _selectOpenFri,
          child: Text(openFri.format(context)),
        ),
        SizedBox(width: SizeConfig.screenWidth * 0.14),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: kPrimaryColorLight, // background
            onPrimary: kPrimaryLightColor, // foreground
          ),
          onPressed: _selectCloseFri,
          child: Text(closeFri.format(context)),
        ),
      ],
    );
  }

  Widget saturdayBuild() {
    return Row(
      children: [
        new Container(
          //padding: const EdgeInsets.all(5.0),
          margin: const EdgeInsets.only(left: 5.0),
          child: Text(
            'Saturday',
            style: TextStyle(fontSize: 18.0),
          ),
        ),
        SizedBox(width: SizeConfig.screenWidth * 0.196),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: kPrimaryColorLight, // background
            onPrimary: kPrimaryLightColor, // foreground
          ),
          onPressed: _selectOpenSat,
          child: Text(openSat.format(context)),
        ),
        SizedBox(width: SizeConfig.screenWidth * 0.14),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: kPrimaryColorLight, // background
            onPrimary: kPrimaryLightColor, // foreground
          ),
          onPressed: _selectCloseSat,
          child: Text(closeSat.format(context)),
        ),
      ],
    );
  }

  Widget sundayBuild() {
    return Row(
      children: [
        new Container(
          //padding: const EdgeInsets.all(5.0),
          margin: const EdgeInsets.only(left: 5.0),
          child: Text(
            'Sunday',
            style: TextStyle(fontSize: 18.0),
          ),
        ),
        SizedBox(width: SizeConfig.screenWidth * 0.222),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: kPrimaryColorLight, // background
            onPrimary: kPrimaryLightColor, // foreground
          ),
          onPressed: _selectOpenSun,
          child: Text(openSun.format(context)),
        ),
        SizedBox(width: SizeConfig.screenWidth * 0.14),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: kPrimaryColorLight, // background
            onPrimary: kPrimaryLightColor, // foreground
          ),
          onPressed: _selectCloseSun,
          child: Text(closeSun.format(context)),
        ),
      ],
    );
  }

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
      initialTime: openThu  ,
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
      initialTime: openFri  ,
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
      initialTime: openSat  ,
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
      initialTime: openSun  ,
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
