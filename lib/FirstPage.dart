import 'package:demo1/SecondPage.dart';
import 'package:demo1/SplashScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'SplashScreen.dart';
import 'variablesFunctions.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

void main() async {
  await DotEnv().load('.env');
  runApp(MaterialApp(home: Myhome()));
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
              theme: ThemeData.dark(),
              home: Splash());
        }
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData.dark(),
          home: MeetMeWhere(),
        );
      },
    );
  }
}

class MeetMeWhere extends StatefulWidget {
  @override
  _MeetMeWhereState createState() => _MeetMeWhereState();
}

class _MeetMeWhereState extends State<MeetMeWhere> {
  Keys formKey = Keys();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return OrientationBuilder(
          builder: (context, orientation) {
            SizerUtil().init(constraints, orientation);
            return MaterialApp(
                debugShowCheckedModeBanner: false,
                theme: ThemeData.dark(),
                home: Scaffold(
                  body: Padding(
                    padding: EdgeInsets.symmetric(
                        vertical: 25.0.h, horizontal: 2.0.h),
                    child: Center(
                      child: Container(
                        child: Form(
                          key: formKey.k1,
                          child: Column(
                            children: [
                              Expanded(
                                child: TextFormField(
                                  decoration: InputDecoration(
                                      labelText:
                                          "Enter number of people including you",
                                      fillColor: Colors.white),
                                  validator: (value) {
                                    if (int.parse(value) <= 0) {
                                      return 'Enter a valid number';
                                    }
                                    return null;
                                  },
                                  onSaved: (value) {
                                    NoOfPeople = int.parse(value);
                                  },
                                  keyboardType: TextInputType.number,
                                ),
                              ),
                              SizedBox(
                                height: 3.0.h,
                              ),
                              ElevatedButton(
                                  onPressed: () {
                                    if (formKey.k1.currentState.validate()) {
                                      formKey.k1.currentState.save();
                                      print(locationStorage.entries);
                                    }
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                SecondPage()));
                                  },
                                  child: Text("Save and Next"))
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ));
          },
        );
      },
    );
  }
}
