import 'package:demo1/Constants/variablesFunctions.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'package:demo1/Models/DestAPIData.dart';
 Future <MeetUp> fetchDestination()async  /// to fetch all the places around the centroid
{
   String url= "https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=$latsum,$longsum&radius=3000&krequest_count=$request_count&keyword=${selectedInterestPoint.toLowerCase()}&key=${DotEnv().env['ApiKey'].toString()}";
   final response = await http.get(
       Uri.parse(url),
   );
   if(response.statusCode==200)
     {
       print(response.body);
       return MeetUp.fromJson(json.decode(response.body));
     }
     else{
       throw Exception('Failed to fetch destination');
   }
}
