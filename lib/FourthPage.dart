import 'package:demo1/DestinationFetcher.dart';
import 'package:demo1/DistanceFetcher.dart';
import 'package:demo1/FifthPage.dart';
import 'package:demo1/variablesFunctions.dart';
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
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 8.0.w),
              ),
              Expanded(
                child: FutureBuilder(
                  future: meetPoint,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      if (snapshot.data.status.toString() == 'ZERO_RESULTS') {
                        return Center(
                          child: Text("Sorry, no places found in that region",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 4.0.w)),
                        );
                      }
                      if (snapshot.data.status.toString() ==
                          'INVALID_REQUEST') {
                        return Center(
                          child: Text(
                              "Location missing, close app and start again",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 4.0.w)),
                        );
                      } else if (snapshot.hasData) {
                        return ListView.builder(
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
                                      color: Colors.yellow[800],
                                      fontSize: 4.0.w),
                                ),
                                selectedTileColor: Colors.green,
                                trailing: Text(
                                  'Total no of Ratings: ${snapshot.data.results[index].userRatingsTotal}',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 3.0.w,
                                      color: Colors.green[400]),
                                ),
                                subtitle: RatingBarIndicator(
                                  rating: snapshot.data.results[index].rating
                                      .toDouble(),
                                  itemCount: 5,
                                  itemSize: 5.0.w,
                                  itemBuilder: (context, index) => Icon(
                                    Icons.star,
                                    color: Colors.yellow[400],
                                  ),
                                ));
                          },
                        );
                      } else if (snapshot.hasError) {
                        return Text(snapshot.error.toString());
                      } else {
                        return Center(child: CircularProgressIndicator());
                      }
                    }
                    return Center(
                      child:
                      CircularProgressIndicator(),
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
