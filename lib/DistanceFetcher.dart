import 'dart:convert';
import 'package:demo1/DistanceFetcherAPIData.dart';
import 'variablesFunctions.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

Future<Distances> fetchDistance(double finalLat, double finalLong)async
{
  String url = 'https://maps.googleapis.com/maps/api/distancematrix/json?origins=$myLat,$myLong&destinations=$finalLat,$finalLong&mode=driving,bicycling,walking&key=AIzaSyCB0dyf_RMaRhaUUNb_KK8aQKPu45fclUI';
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