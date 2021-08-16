import 'package:demo1/Services/DestinationDetailsFetcher.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../Constants/variablesFunctions.dart';
import 'package:sizer/sizer.dart';
import 'package:maps_launcher/maps_launcher.dart';

class placeDetails extends StatefulWidget {
  @override
  _placeDetailsState createState() => _placeDetailsState();
}

class _placeDetailsState extends State<placeDetails> {
  @override
  void initState() {
    // TODO: implement initState
    destination = destinationDetails();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffedc7b7),
        body: Column(
          children: [
            Expanded(
              child: FutureBuilder(
                future: Future.wait([destination, distancegetter]),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done)
                  {
                    if (snapshot.data[0].result.businessStatus.toString() ==
                        'CLOSED_PERMANENTLY') {
                      return Center(
                          child: Text("The Place is not Operational anymore",style: TextStyle(color: Colors.black),));
                    }  /// if a place is closed permanently.
                    else if (snapshot.hasData) {
                      return
                        ListView(
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          children: [
                            SizedBox(
                              height: 100.0.h,
                              child: Container(
                                width: double.infinity,
                                height: double.infinity,
                                child: Padding(
                                  padding: EdgeInsets.symmetric(vertical:5.0.h,horizontal: 7.0.w),
                                  child: Column
                                    (
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.symmetric(vertical: 1.0.h,horizontal: 2.0.w),
                                        child: Text(snapshot.data[0].result.name,
                                            style: GoogleFonts.montserrat(
                                                color: Color(0xffac3b61),
                                                fontWeight: FontWeight.bold,
                                                fontSize: 25.0.sp
                                            )),
                                      ),
                                      SizedBox(
                                        height: MediaQuery.of(context).size.height * 0.05,
                                      ),
                                      Card(
                                        elevation: 20,
                                        color: Color(0xffedc7b7),
                                        shadowColor: Color(0xffeee2dc),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(20),
                                        ),
                                        child: Padding(
                                          padding:  EdgeInsets.symmetric(vertical:4.0.h,horizontal: 7.0.w),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                            children: [
                                              Expanded(
                                                child: snapshot.data[0].result.rating.toString()!='null'? Text(
                                                    'Average Rating: ${snapshot.data[0].result.rating.toString()}',
                                                    style: TextStyle(
                                                        color: Color(0xff123c69),
                                                        fontWeight: FontWeight.bold)):Text(
                                                    'Average Rating: 0',
                                                    style: TextStyle(
                                                        color: Color(0xff123c69),
                                                        fontWeight: FontWeight.bold)),
                                              ),
                                              Expanded(
                                                child:
                                                snapshot.data[0].result.businessStatus
                                                    .toString() ==
                                                    'OPERATIONAL'
                                                    ? Text('Working now: Yes',
                                                    style: TextStyle(
                                                        color: Color(0xff123c69),
                                                        fontWeight: FontWeight.bold))
                                                    : Text('Working Now: No',
                                                    style: TextStyle(
                                                        color: Color(0xff123c69),
                                                        fontWeight: FontWeight.bold)),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 3.0.h,
                                      ),
                                      Card(
                                        elevation: 20,
                                        color: Color(0xffedc7b7),
                                        shadowColor: Color(0xffeee2dc),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(20),
                                        ),
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(vertical:4.0.h,horizontal: 5.0.w),
                                          child: Row(
                                            children: [
                                              Expanded(
                                                  child: SelectableText(
                                                      'Contact No: ${snapshot.data[0].result.formattedPhoneNumber.toString()}',
                                                      style: TextStyle(
                                                          color: Color(0xff123c69),
                                                          fontWeight: FontWeight.bold))),
                                              Expanded(
                                                  child: SelectableText(
                                                      'Address: ${snapshot.data[0].result.formattedAddress
                                                          .toString()}',
                                                      style: TextStyle(
                                                          color: Color(0xff123c69),
                                                          fontWeight: FontWeight.bold,wordSpacing: 1.5))),
                                            ],
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 2.0.h,
                                      ),
                                      Text(
                                        'Featured Reviews',
                                        style: TextStyle(
                                            color: Color(0xffac3b61),
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18.0.sp),
                                      ),
                                      Expanded(
                                        child: Card(
                                          elevation: 20,
                                          color: Color(0xffedc7b7),
                                          shadowColor: Color(0xffeee2dc),
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(20),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.only(top:8.0,left: 8.0,right: 8.0),
                                            child: ListView.builder(
                                                shrinkWrap: true,
                                                scrollDirection: Axis.vertical,
                                                itemCount:
                                                snapshot.data[0].result.reviews==null?1:snapshot.data[0].result.reviews.length,
                                                itemBuilder: (BuildContext context, int index) {
                                                  if(snapshot.data[0].result.reviews==null)
                                                  {
                                                    return Center(child: Text("No Reviews for this Place",style: TextStyle(color: Colors.red,fontWeight: FontWeight.bold,fontSize: 13.0.sp),));
                                                  }
                                                  return Column(
                                                    children: [
                                                      Text(
                                                        '${snapshot.data[0].result.reviews[index].authorName.toString().toUpperCase()}',
                                                        style: TextStyle(
                                                            color: Color(0xff123c69),
                                                            fontWeight: FontWeight.bold,
                                                            fontSize: 14.0.sp),
                                                      ),
                                                      SizedBox(height: 0.5.h,),
                                                      Text(
                                                        snapshot.data[0].result.reviews[index]
                                                            .text,
                                                        style: TextStyle(fontSize: 10.0.sp,wordSpacing: 2.0,color: Color(0xff123c69)),
                                                      ),
                                                      SizedBox(height: 1.0.h,)
                                                    ],
                                                  );
                                                }),
                                          ),
                                        ),
                                      ),
                                    RaisedButton(
                                          shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.all(Radius.circular(15))),
                                          child: Text(
                                            "Open in Maps",
                                            style: TextStyle(
                                                color: Color(0xffac3b61),
                                                fontWeight: FontWeight.bold),
                                          ),
                                          color: Color(0xffedc7b7),
                                          onPressed: () {
                                            MapsLauncher.launchQuery(
                                                '${snapshot.data[0].result.name} ${snapshot.data[0].result.formattedAddress}');
                                          }) /// If you want to see the current plae in Google Maps.
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                      );
                    }/// if everything is fine
                  }
                  else if (snapshot.hasError) {
                    return Text(snapshot.error.toString());
                  }  /// to handle API error
                  return Center(
                    child: CircularProgressIndicator(),
                  ); /// to handle internet issue
                },
              ),
            ),
          ],
        ));
  }
}
