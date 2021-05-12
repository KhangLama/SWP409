import 'package:flutter/material.dart';
import 'package:swp409/constants.dart';
import 'components/body.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          leading: BackButton(
            onPressed: () => Navigator.pop(context),
          ),
          title: Text('Profile'),
          centerTitle: true,
          backgroundColor: kPrimaryAppbar,
        ),
        body: Body(),
      ),
    );
  }
}
