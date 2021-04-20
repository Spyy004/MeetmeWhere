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
class Keys
{
  final k1= GlobalKey<FormState>();
  final k2= GlobalKey<FormState>();
}
getCentroid()
{
  locationStorage.forEach((key, value) {
    updatedLatitude.add(key);
    updatedLongitude.add(value);
  });
  centroidCalculator();
  finalLatSum=latsum;
  finalLongSum=longsum;
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

void centroidCalculator()
{

  int i=0;
  double signedArea=0.0;
  locationStorage.forEach((lat, lng) {
    latList.add(lat);
    longList.add(lng);
    i++;
  });
  for(int i=0;i<latList.length;i++)
    {
      double x0=latList[i],y0=longList[i];
      double x1=latList[(i+1)%latList.length],y1=longList[(i+1)%longList.length];
      double area= (x0*y1)-(x1-y0);
      signedArea=signedArea +area;
      latsum=latsum+(x0+x1)*area;
      longsum=longsum+(y0+y1)*area;
    }
  signedArea = signedArea*0.5;
  latsum=latsum/(6*signedArea);
  longsum=longsum/(6*signedArea);
}
getSinglePerson()
{
  locationStorage.forEach((key, value) {
    latsum=key;
    longsum=value;
  });
}
getDoublePerson()
{
  locationStorage.forEach((key, value) {
    latsum=latsum+key;
    longsum=longsum+value;
  });
  latsum=latsum/locationStorage.length;
  longsum=longsum/locationStorage.length;
}