import 'dart:collection';
import 'package:demo1/destDetailsAPI.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'DestAPIData.dart';
import 'DistanceFetcherAPIData.dart';
import 'Location Fetcher.dart';
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
getCentroid()
{
  print(locationStorage.entries);
  locationStorage.forEach((key, value) {
    latsum=latsum+key;
    longsum=longsum+value;
    updatedLatitude.add(key);
    updatedLongitude.add(value);
  });
  print(latsum);
  print(longsum);
  latsum=latsum/locationStorage.length;
  longsum=longsum/locationStorage.length;
  finalLatSum=latsum;
  finalLongSum=longsum;
  print(latsum);
  print(longsum);
  print(locationStorage.length);
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

getSinglePerson()
{
  locationStorage.forEach((key, value) {
    latsum=latsum+key;
    longsum=longsum+value;
  });
}
getDoublePerson()
{
  print(locationStorage.entries);
  locationStorage.forEach((key, value) {
    latsum=latsum+key;
    longsum=longsum+value;
  });
  latsum=latsum/locationStorage.length;
  longsum=longsum/locationStorage.length;
  locationStorage.clear();
}