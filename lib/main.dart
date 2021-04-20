import 'package:flutter/material.dart';
import 'package:flutter_config/flutter_config.dart';
import 'package:swp409/Services/Authentication/splash/splash_screen.dart';
import 'package:swp409/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FlutterConfig.loadEnvVariables();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print(FlutterConfig.get('GOOGLE_MAP_KEY'));
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Clinic booking',
      theme: theme(),
      home: SplashScreen(),
    );
  }
}
