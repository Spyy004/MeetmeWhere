import 'package:demo1/DestinationDetailsFetcher.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'variablesFunctions.dart';
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
        body: Column(
      children: [
        Expanded(
          child: FutureBuilder(
            future: Future.wait([destination, distancegetter]),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.data[0].result.businessStatus.toString() ==
                    'CLOSED_PERMANENTLY') {
                  return Center(
                      child: Text("The Place is not Operational anymore"));
                } else if (snapshot.hasData) {
                  return Container(
                    width: double.infinity,
                    height: double.infinity,
                    child: Padding(
                      padding: EdgeInsets.all(12.0.w),
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(top: 4.0.h),
                            child: Text(snapshot.data[0].result.name,
                                style: TextStyle(
                                    color: Colors.red[400],
                                    fontWeight: FontWeight.bold,
                                    fontSize: 9.0.w)),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.05,
                          ),
                          Row(
                            children: [
                              Expanded(
                                  child:snapshot.data[0].result.rating.toString()!='null'? Text(
                                      'Average Rating: ${snapshot.data[0].result.rating.toString()}',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold)):Text(
                                      'Average Rating: 0',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold))),
                              Expanded(
                                  child: snapshot.data[0].result.businessStatus
                                              .toString() ==
                                          'OPERATIONAL'
                                      ? Text('Working now: Yes',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold))
                                      : Text('Working Now: No',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold))),
                            ],
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.05,
                          ),
                          Row(
                            children: [
                              Expanded(
                                  child: SelectableText(
                                      'Contact No: ${snapshot.data[0].result.formattedPhoneNumber.toString()}',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold))),
                              Expanded(
                                  child: SelectableText(
                                      'Address: ${snapshot.data[0].result.formattedAddress
                                          .toString()}',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,wordSpacing: 1.5))),
                            ],
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.07,
                          ),
                          Text(
                            "Featured Reviews",
                            style: TextStyle(
                                color: Colors.yellow[800],
                                fontWeight: FontWeight.bold,
                                fontSize: 15.0.sp),
                          ),
                          Expanded(
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
                                  return Card(
                                    color: Colors.grey[900],
                                   shape: RoundedRectangleBorder(
                                     borderRadius: BorderRadius.only(topRight:Radius.circular(10),topLeft:Radius.circular(10) ),
                                   ),
                                    child: Column(
                                      children: [
                                        Text(
                                          '${snapshot.data[0].result.reviews[index].authorName.toString().toUpperCase()}',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 14.0.sp),
                                        ),
                                        Text(
                                          snapshot.data[0].result.reviews[index]
                                              .text,
                                          style: TextStyle(fontSize: 10.0.sp,wordSpacing: 2.0),
                                        ),
                                      ],
                                    ),
                                  );
                                }),
                          ),
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 1.0.h, horizontal: 1.0.w),
                              child: snapshot.data[1].rows[0].elements[0].status.toString()=="ZERO_RESULTS"?
                              Padding(
                                padding:  EdgeInsets.all(11.0),
                                child: Text(
                                  "Sorry,couldn't fetch your location!",
                                  style: TextStyle(
                                      color: Colors.yellow[700],
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12.0.sp),
                                ),
                              ):Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Text(
                                      "Distance:${snapshot.data[1].rows[0].elements[0].distance.text.toString()}",
                                      style: TextStyle(
                                          color: Colors.yellow[700],
                                          fontWeight: FontWeight.bold,
                                          fontSize: 11.0.sp),
                                    ),
                                    SizedBox(
                                      width: 2.0.w,
                                    ),
                                    Text(
                                        "Estimated time:${snapshot.data[1].rows[0].elements[0].duration.text.toString()}",
                                        style: TextStyle(
                                            color: Colors.yellow[700],
                                            fontWeight: FontWeight.bold,
                                            fontSize: 11.0.sp))
                                  ]
                              ),
                            ),
                          ),
                          FlatButton(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(Radius.circular(15))),
                              child: Text(
                                "Open in Maps",
                                style: TextStyle(
                                    color: Colors.yellow[800],
                                    fontWeight: FontWeight.bold),
                              ),
                              color: Colors.black38,
                              onPressed: () {
                                MapsLauncher.launchQuery(
                                    '${snapshot.data[0].result.name} ${snapshot.data[0].result.formattedAddress}');
                              })
                        ],
                      ),
                    ),
                  );
                }
              } else if (snapshot.hasError) {
                return Text(snapshot.error.toString());
              } else {
                return Center(child: CircularProgressIndicator());
              }
              return Center(
                child: CircularProgressIndicator(),
              );
            },
          ),
        ),
      ],
    ));
  }
}
