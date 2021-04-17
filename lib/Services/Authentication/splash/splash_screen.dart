import 'package:flutter/material.dart';
import 'package:swp409/Services/Authentication/splash/components/body.dart';
import '../../../size_config.dart';

// class SplashScreen extends StatelessWidget {
//   //static String routeName = "/splash";
//   @override
//   Widget build(BuildContext context) {
//     // You have to call it on your starting screen
//     SizeConfig().init(context);
//     return Scaffold(
//       body: Body(),
//     );
//   }
// }

class SplashScreen extends StatelessWidget {
  static String routeName = "/splash";
  @override
  Widget build(BuildContext context) {
    // You have to call it on your starting screen
    SizeConfig().init(context);
    return MaterialApp(
      home: Scaffold(
        body: Body(),
      ),
    );
  }
}