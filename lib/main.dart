import 'package:demo1/SecondPage.dart';
import 'package:demo1/SplashScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'SplashScreen.dart';
import 'variablesFunctions.dart';
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
        }
        return MaterialApp(
          debugShowCheckedModeBanner: false,
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
                home: Scaffold(
                  backgroundColor: Color(0xffEDC7B7),
                  body: Padding(
                    padding: EdgeInsets.symmetric(
                        vertical: 25.0.h, horizontal: 5.0.w),
                    child: Center(
                      child: Container(
                        child: Form(
                          key: formKey.k1,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Expanded(
                                child: TextFormField(
                                  decoration: InputDecoration(
                                      icon: Icon(
                                        Icons.group,
                                        color: Color(0xff123c69),
                                      ),
                                      border: OutlineInputBorder(),
                                      labelText:
                                          "Enter number of people including you",
                                      labelStyle: TextStyle(color: Colors.white),
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
                              RaisedButton(
                                color: Color(0xffedc7b9),
                                elevation: 5,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0)),
                                  onPressed: () {
                                    if (formKey.k1.currentState.validate()) {
                                      formKey.k1.currentState.save();
                                      zeroCheck();
                                    }
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                SecondPage()));
                                  },
                                  child: Text("Save and Next",style:TextStyle(color: Color(0xffac3b61)),))
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

zeroCheck() {
  latsum = 0;
  k = 0;
  longsum = 0;
}
