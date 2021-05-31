import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:swp409/Models/user.dart';
import 'package:swp409/constants.dart';
import 'components/body.dart';

// ignore: must_be_immutable
class ProfilePage extends StatefulWidget {
  final User user;
  String token;
  ProfilePage.user({Key key, this.user, this.token}) : super(key: key);
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  User _user;
  String _token;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(widget.user.toJson());
    setState(() {
      print('profile');
      _user = widget.user;
      _token = widget.token;
      print(_user.toJson());
    });
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
          title: Text('Profile'),
          centerTitle: true,
          backgroundColor: kPrimaryAppbar,
        ),
        body: Body.user(user: _user, token: _token),
      ),
    );
  }
}
