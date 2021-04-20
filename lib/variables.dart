import 'dart:collection';
import 'package:demo1/destDetailsAPI.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'DestAPIData.dart';
import 'DistanceFetcherAPIData.dart';
import 'Location Fetcher.dart';
int NoOfPeople;
String placeID;
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
class Keys
{
  final k1= GlobalKey<FormState>();
  final k2= GlobalKey<FormState>();
}
getCentroid()
{

  locationStorage.forEach((key, value) {
    latsum=latsum+key;
    longsum=longsum+value;
    updatedLatitude.add(key);
    updatedLongitude.add(value);

  });
  finalLatSum=latsum;
  finalLongSum=longsum;
  latsum=latsum/locationStorage.length;
  longsum=longsum/locationStorage.length;
  print(latsum);
  print(longsum);
  locationStorage.clear();
}
updateLatLong()async
{
  int i=0;
  if(locationStorage.isNotEmpty)
    {
      locationStorage.forEach((key, value) {
        latsum=latsum-(key-updatedLatitude[i]);
        longsum=longsum-(value-updatedLongitude[i]);
        updatedLatitude[i]=key;
        updatedLongitude[i]=value;
        i++;
      });
    }
  locationStorage.clear();
}
