import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:swp409/Components/default_button.dart';
import 'package:swp409/Interface/Home/mainScreen.dart';
import '../../constants.dart';
import '../../size_config.dart';
import 'components/img_multiple_picker.dart';

class Registration extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          leading: BackButton(
            onPressed: () => Navigator.pop(context),
          ),
          title: Text('Register as a doctor'),
          backgroundColor: kPrimaryAppbar,
        ),
        body: Body(),
      ),
    );
  }
}

class Body extends StatelessWidget {
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
                BuildGridView(),
                DefaultButton(
                  text: "Save change",
                  press: () {
                    //if (_formKey.currentState.validate()) {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => MainScreen()));
                    //}
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
