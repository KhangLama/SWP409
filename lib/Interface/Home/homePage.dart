import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.tealAccent,
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Text(
              'Aiya',
              style: TextStyle(fontSize: 30),
            )
          ],
        ),
      ),
    );
  }
}
