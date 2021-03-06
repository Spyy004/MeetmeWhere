import 'package:demo1/Services/DestinationFetcher.dart';
import 'package:demo1/Services/DistanceFetcher.dart';
import 'package:demo1/Screens/FifthPage.dart';
import 'package:demo1/Constants/variablesFunctions.dart';
import 'package:flutter/cupertino.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class Fourth extends StatefulWidget {
  @override
  _FourthState createState() => _FourthState();
}

class _FourthState extends State<Fourth> {
  @override
  void initState() {
    // TODO: implement initState
    meetPoint = fetchDestination();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xffEDC7B7),
        body: Padding(
      padding: EdgeInsets.only(top: 9.0.h, left: 3.0.w, right: 3.0.w),
      child: Center(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          child: Column(
            children: [
              Text(
                'You can visit...',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 8.0.w,color: Color(0xff123c69)),
              ),
              Expanded(
                child: FutureBuilder(
                  future: meetPoint,  /// a function which gives all the places where you can meet.
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      if (snapshot.data.status.toString() == 'ZERO_RESULTS') {
                        return Center(
                          child: Text("Sorry, no places found in that region (If you get same message twice, restart the app and fill details correctly",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 9.0.sp,color: Colors.black)),
                        );
                      }  /// To handle zero places found
                      if (snapshot.data.status.toString() ==
                          'INVALID_REQUEST') {
                        return Center(
                          child: Text(
                              "Location missing, close app and start again",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 9.0.sp)),
                        );
                      } /// To handle invalid request
                      else if (snapshot.hasData) {
                        return Card(
                          elevation: 20,
                          color: Color(0xffedc7b7),
                          shadowColor: Color(0xffeee2dc),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(topLeft: Radius.circular(20),topRight: Radius.circular(20)),
                          ),
                          child: ListView.builder(
                            itemCount: snapshot.data.results.length,
                            itemBuilder: (BuildContext context, int index) {
                              return ListTile(
                                  autofocus: true,
                                  onTap: () {
                                    placeID =
                                        snapshot.data.results[index].placeId;
                                    fetchDestination();
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                placeDetails()));
                                    distancegetter = fetchDistance(
                                        snapshot.data.results[index].geometry
                                            .location.lat,
                                        snapshot.data.results[index].geometry
                                            .location.lng);
                                  },
                                  title: Text(
                                    snapshot.data.results[index].name,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xffac3b61),
                                        fontSize: 14.0.sp),
                                  ),
                                  selectedTileColor: Colors.green,
                                  trailing: Icon(
                                    Icons.navigate_next_outlined,
                                    color: Color(0xffac3b61),
                                  ),
                                  subtitle: RatingBarIndicator(
                                    rating: snapshot.data.results[index].rating
                                        .toDouble(),
                                    itemCount: 5,
                                    itemSize: 5.0.w,
                                    itemBuilder: (context, index) => Icon(
                                      Icons.star,
                                      color: Color(0xff123c69),
                                    ),
                                  ));
                            },
                          ),
                        );
                      }
                      else if (snapshot.hasError) {
                        return Text(snapshot.error.toString());
                      } /// To handle API errors.
                    } /// if the connection is complete
                    return Center(
                      child:
                      CircularProgressIndicator(), /// if there are internet issues
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
