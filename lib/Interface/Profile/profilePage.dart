import 'package:flutter/material.dart';
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
          title: Text('Choose a medical record'),
        ),
        body: Body(),
      ),
    );
  }
}
