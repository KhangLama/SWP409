import 'package:flutter/cupertino.dart';
import 'package:swp409/Models/user.dart';

class ChangePassClinicScreen extends StatefulWidget {
  User user;
  List<String> cookies;
  ChangePassClinicScreen({Key key, this.user, this.cookies}) : super(key: key);

  @override
  _ChangePassClinicScreenState createState() => _ChangePassClinicScreenState();
}

class _ChangePassClinicScreenState extends State<ChangePassClinicScreen> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
