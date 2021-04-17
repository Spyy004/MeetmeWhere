import 'package:demo1/DestinationDetailsFetcher.dart';
import 'package:flutter/material.dart';
import 'variables.dart';
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
    return Scaffold(body:
    Container(
        child: FutureBuilder(
          future: destination,
          builder: (context, snapshot){
            if(snapshot.hasData){
              return Container(
                 width: double.infinity,
                height: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.all(35.0),
                  child: Column(
                    children: [
                      Text(snapshot.data.result.name,style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 25)),
                      SizedBox(height: MediaQuery.of(context).size.height*0.05,),
                      Row(
                        children: [
                          Expanded(child: Text('Average Rating: ${snapshot.data.result.rating.toString()}',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold))),
                          Expanded(child: snapshot.data.result.openingHours.openNow!=null?Text('Open Now:${snapshot.data.result.openingHours.openNow.toString()}',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold)):
                          Text('Open Now: No Status Available',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold))
                          ),
                        ],
                      ),
                      SizedBox(height: MediaQuery.of(context).size.height*0.05,),
                      Row(
                        children: [
                          Expanded(child: Text(snapshot.data.result.formattedPhoneNumber.toString(),style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold))),
                          Expanded(child: Text(snapshot.data.result.formattedAddress.toString(),style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold))),
                        ],
                      ),
                      SizedBox(height: MediaQuery.of(context).size.height*0.05,),
                      Text("Reviews by Visitors",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
                      SizedBox(height: MediaQuery.of(context).size.height*0.01,),
                      Expanded(
                        child: ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          itemCount: snapshot.data.result.reviews.length,
                            itemBuilder: (BuildContext context , int index){
                          return Card(
                            elevation: 5.0,
                            color: Colors.grey[300],
                            child: Column(
                              children: [
                                Text('${snapshot.data.result.reviews[index].authorName.toString().toUpperCase()}',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
                                Text(snapshot.data.result.reviews[index].text,style: TextStyle(fontSize: 12),),
                              ],
                            ),
                          );
                        }),
                      )
                    ],
                  ),
                ),
              );
            }
            else if(snapshot.hasError){
              return Text(snapshot.error.toString());
            }
            else
              {
                return CircularProgressIndicator();
              }
          },
        ),
    ));
  }
}
