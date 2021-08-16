import 'package:demo1/Screens/SecondPage.dart';
import 'package:demo1/Screens/SplashScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'Screens/HomePage.dart';
import 'Screens/SplashScreen.dart';
import 'Constants/variablesFunctions.dart';
import 'package:sizer/sizer.dart';

//People Selector Page

void main() async {
  await DotEnv().load('.env');
  runApp(MaterialApp(
    home: Myhome(),
    debugShowCheckedModeBanner: false,
  ));
}

class Myhome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Future.delayed(Duration(seconds: 3)),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return MaterialApp(
              debugShowCheckedModeBanner: false,
              home: Splash());
        } /// Splash Screen
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          home: MeetMeWhere(),
        );    /// HomeScreen
      },
    );
  }
}
