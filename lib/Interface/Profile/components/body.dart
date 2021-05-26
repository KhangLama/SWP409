import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:swp409/Models/user.dart';
import '../../../size_config.dart';
import 'profile_menu.dart';
import 'profile_pic.dart';

// ignore: must_be_immutable
class Body extends StatefulWidget {
  User user;
  Body.user({Key key, this.user}) : super(key: key);
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  User _user;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      _user = widget.user;
      print('body');
      print(widget.user.toJson());
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        width: double.infinity,
        child: Padding(
          padding:
              EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: SizeConfig.screenHeight * 0.02),
                ProfilePic(),
                SizedBox(height: SizeConfig.screenHeight * 0.03),
                CompleteProfileForm.user(_user),
                SizedBox(height: getProportionateScreenHeight(30)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
