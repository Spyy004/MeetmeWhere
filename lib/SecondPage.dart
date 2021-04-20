import 'package:demo1/ThirdPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter/services.dart';
import 'variablesFunctions.dart';
import 'package:sizer/sizer.dart';

class SecondPage extends StatefulWidget {
  @override
  _SecondPageState createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
  final _key = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  List<TextEditingController> _editingControllerList = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    myLat = 0;
    myLong = 0;
    k = 0;
  }

  Future<void> myLocation() async {
    Position l1 = await gl.determinePosition();
    myLat = l1.latitude;
    myLong = l1.longitude;
    locationStorage.putIfAbsent(
        l1.latitude.toDouble(), () => l1.longitude.toDouble());
    print(locationStorage.entries);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Form(
                key: _key,
                child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: NoOfPeople - 1,
                    itemBuilder: (BuildContext context, int index) {
                      return Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.all(3.0.h),
                            child: TextFormField(
                              decoration: InputDecoration(
                                labelText:
                                    "Enter latitude and longitude of person no ${index + 1}",
                              ),
                              keyboardType: TextInputType.numberWithOptions(
                                  signed: false, decimal: true),
                              onSaved: (value) {
                                print(value);
                                var z = value.toString().split(' ').first;
                                var y = value.toString().split(' ').last;
                                locationStorage.putIfAbsent(
                                    double.parse(z), () => double.parse(y));
                                // locationAdder();
                              },
                              validator: (value) {
                                if (value.isEmpty) {
                                  return "Enter something";
                                }
                                return null;
                              },
                            ),
                          ),
                        ],
                      );
                    }),
              ),
            ),
            Text("Wait for a pop-up after pressing the below button"),
            Padding(
              padding: EdgeInsets.only(bottom: 5.0.h),
              child: ElevatedButton(
                  onPressed: () async {
                    if (myLat == 0 && myLong == 0) {
                      await myLocation();
                      print("location fetch called");
                      _scaffoldKey.currentState.showSnackBar(SnackBar(
                        content: Text("Location Fetched successfully "),
                        duration: Duration(seconds: 2),
                      ));
                    } else {
                      _scaffoldKey.currentState.showSnackBar(SnackBar(
                        content: Text("Location already fetched"),
                        duration: x,
                      ));
                    }
                    buttonOn = true;
                  },
                  child: Text("Get My Location")),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 5.5.h),
              child: ElevatedButton(
                  onPressed: () {
                    if (_key.currentState.validate()) {
                      _key.currentState.save();
                      if (k == 0) {
                        if (NoOfPeople == 1) {
                          getSinglePerson();
                          print("single called");
                        } else if (NoOfPeople == 2) {
                          getDoublePerson();
                          print("double called");
                        } else {
                          getCentroid();
                          print("centroid called");
                        }
                      } else {
                        updateLatLong();
                        print(locationStorage.entries);
                        print("update called");
                      }
                      k++;
                      // meetPoint= MeetUpPage();
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SecondPages()));
                    }
                  },
                  child: Text("Save and Next")),
            ),
          ],
        ),
      ),
    );
  }
}
