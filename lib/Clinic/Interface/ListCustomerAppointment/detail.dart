import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../constants.dart';

class UserAppointDetailScreen extends StatefulWidget {
  @override
  _UserAppointDetailScreenState createState() => _UserAppointDetailScreenState();
}

class _UserAppointDetailScreenState extends State<UserAppointDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text(
            'Find Clinic You Want',
            style: TextStyle(color: kPrimaryLightColor),
          ),
          backgroundColor: kPrimaryAppbar,
        ),
        body: SafeArea(),
      ),
    );
  }
}
