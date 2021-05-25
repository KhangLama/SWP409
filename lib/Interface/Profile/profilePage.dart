import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:swp409/constants.dart';
import 'components/body.dart';

// ignore: must_be_immutable
class ProfilePage extends StatefulWidget {
  FlutterSecureStorage storage;
  ProfilePage(this.storage);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
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
        body: new Body(widget.storage),
      ),
    );
  }
}
