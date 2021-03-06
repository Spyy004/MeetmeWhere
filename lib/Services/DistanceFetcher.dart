import 'dart:convert';
import 'package:demo1/Models/DistanceFetcherAPIData.dart';
import '../Constants/variablesFunctions.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

Future<Distances> fetchDistance(double finalLat, double finalLong)async /// to fetch the distance between selected place and users' current location
{
  String url = 'https://maps.googleapis.com/maps/api/distancematrix/json?origins=$myLat,$myLong&destinations=$finalLat,$finalLong&mode=driving,bicycling,walking&key=${DotEnv().env['ApiKey'].toString()}';
  final response = await http.get(Uri.parse(url));
  if(response.statusCode==200)
  {
    print(response.body);
    return Distances.fromJson(json.decode(response.body));
  }
  else{
    throw Exception('Failed to fetch destination');
  }
}