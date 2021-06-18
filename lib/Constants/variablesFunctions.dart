import 'dart:collection';
import 'package:demo1/Models/destDetailsAPI.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';
import '../Models/DestAPIData.dart';
import '../Models/DistanceFetcherAPIData.dart';
import '../Services/Location Fetcher.dart';
int NoOfPeople;
String placeID;
List<double>latList=[],longList=[];
int editingControllerCounter=0;
Color placeButton= Colors.grey;
double latitude,longitude;
double latsum=0,longsum=0;
List<String> interestPoints=['Restaurants','Malls','Museums','Parks','Cafes','Gaming'];
String selectedInterestPoint;
Future<MeetUp> meetPoint;
Future<Distances>distancegetter;
Future<destDetails> destination;
String next_page_token='';
double finalLatSum, finalLongSum;
double myLat=0,myLong=0;
int request_count=0;
bool buttonOn=false;
Duration x=Duration(seconds: 2);
HashMap locationStorage= HashMap<double,double>();
List<double>updatedLatitude=[];
List<double>updatedLongitude=[];
int k=0;
GetLocation gl= GetLocation();
List<IconData> placesIcon =[Icons.restaurant,Icons.local_mall,Icons.museum,Icons.park,Icons.restaurant_menu,Icons.gamepad_outlined];
class Keys
{
  final k1= GlobalKey<FormState>();
  final k2= GlobalKey<FormState>();
}

//centroid calculator
getCentroid(int callTime)
{
  latsum=0;longsum=0;
  print('Centroid Call: latsum:$latsum longsum:$longsum');
  if(locationStorage.isNotEmpty && callTime==0) {
    print(locationStorage.entries);
    locationStorage.forEach((key, value) {
      latsum = latsum + key;
      longsum = longsum + value;
    });
    latsum = latsum / locationStorage.length;
    longsum = longsum / locationStorage.length;
    locationStorage.clear();
    print('First Call: latsum:$latsum longsum:$longsum');
    print('First Call: ${locationStorage.entries}');
  }
  else if (locationStorage.isNotEmpty && callTime>0) {
    print(locationStorage.entries);
    locationStorage.putIfAbsent(myLat, () => myLong);
    locationStorage.forEach((key, value) {
          latsum = latsum + key;
          longsum = longsum + value;

    });
    latsum = latsum / locationStorage.length;
    longsum = longsum / locationStorage.length;
    print(locationStorage.entries);
    locationStorage.clear();
    print('Update Call: latsum:$latsum longsum:$longsum');
    print('Update Call: ${locationStorage.entries}');
  }
}
