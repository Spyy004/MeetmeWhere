import 'package:demo1/DestinationDetailsFetcher.dart';
import 'package:flutter/material.dart';
import 'variables.dart';
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
    destination=destinationDetails();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body:
    Column(
      children: [
        Expanded(
          child: FutureBuilder(
            future: Future.wait([destination,distancegetter]),
            builder: (context, snapshot){
              if(snapshot.connectionState==ConnectionState.done)
                {
                  if(snapshot.data[0].result.businessStatus.toString()=='CLOSED_PERMANENTLY'){
                    return Center(child: Text("The Place is not Operational anymore"));
                  }
                 else if(snapshot.hasData){
                    return Container(
                      width: double.infinity,
                      height: double.infinity,
                      child: Padding(
                        padding:  EdgeInsets.all(12.0.w),
                        child: Column(
                          children: [
                            Padding(
                              padding:  EdgeInsets.only(top:4.0.h),
                              child: Text(snapshot.data[0].result.name,style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 9.0.w)),
                            ),
                            SizedBox(height: MediaQuery.of(context).size.height*0.05,),
                            Row(
                              children: [
                                Expanded(child: Text('Average Rating: ${snapshot.data[0].result.rating.toString()}',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold))),
                                Expanded(child: snapshot.data[0].result.businessStatus.toString()=='OPERATIONAL'?Text('Working now: Yes',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold)):
                                Text('Working Now: No',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold))
                                ),
                              ],
                            ),
                            SizedBox(height: MediaQuery.of(context).size.height*0.05,),
                            Row(
                              children: [
                                Expanded(child: Text('Contact No: ${snapshot.data[0].result.formattedPhoneNumber.toString()}',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold))),
                                Expanded(child: Text(snapshot.data[0].result.formattedAddress.toString(),style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold))),
                              ],
                            ),
                            SizedBox(height: MediaQuery.of(context).size.height*0.07,),
                            Text("Reviews by Visitors",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 5.0.w),),

                            Expanded(
                              child: ListView.builder(
                                  shrinkWrap: true,
                                  scrollDirection: Axis.vertical,
                                  itemCount: snapshot.data[0].result.reviews.length,
                                  itemBuilder: (BuildContext context , int index){

                                    return Card(
                                      elevation: 10.0,
                                      color: Colors.black26,
                                      child: Column(
                                        children: [
                                          Text('${snapshot.data[0].result.reviews[index].authorName.toString().toUpperCase()}',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 4.5.w),),
                                          Text(snapshot.data[0].result.reviews[index].text,style: TextStyle(fontSize: 3.5.w),),
                                        ],
                                      ),
                                    );
                                  }),
                            ),
                            Expanded(
                              child: Padding(
                                padding: EdgeInsets.symmetric(vertical:1.0.h,horizontal: 1.0.w),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Text("Distance:${snapshot.data[1].rows[0].elements[0].distance
                                        .text.toString()}",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 11.0.sp),),
                                    SizedBox(width: 2.0.w,),
                                    Text("Estimated time:${snapshot.data[1].rows[0].elements[0].duration
                                        .text.toString()}",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 11.0.sp)),
                                  ],
                                ),
                              ),
                            ),
                            FlatButton(
                                child: Text("Open in Maps",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
                                color: Colors.white,
                                onPressed: (){
                                  MapsLauncher.launchQuery(snapshot.data[0].result.formattedAddress.toString());
                                }
                            )
                          ],
                        ),
                      ),
                    );
                  }
                }
              else if(snapshot.hasError){
                return Text(snapshot.error.toString());
              }
              else
                {
                  return Center(child: CircularProgressIndicator());
                }
              return Center(child: CircularProgressIndicator(),);
            },
          ),
        ),
      ],
    ));
  }
}