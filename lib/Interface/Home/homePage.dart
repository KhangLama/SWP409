import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.tealAccent,
      appBar: AppBar(
        title: Text('Find Clinic You Want')
      ),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 50,
              child: Row(
              children: [
                Card(
                  child: Column(
                    children: [
                      Row(
                      children: [
                        
                      ],
                    )
                    ],
                  ),
                ),
              ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
