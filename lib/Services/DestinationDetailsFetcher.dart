import 'package:demo1/Models/destDetailsAPI.dart';
import 'package:demo1/Constants/variablesFunctions.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<destDetails> destinationDetails()async /// To fetch details of a single place
{
  String url= 'https://maps.googleapis.com/maps/api/place/details/json?place_id=$placeID&name,url,rating,formatted_address,formatted_phone_number&key=${DotEnv().env['ApiKey'].toString()}';
  var details= await http.get(Uri.parse(url));
  if(details.statusCode==200)
    {
      return destDetails.fromJson(json.decode(details.body));
    }
  else
    {
      throw Exception('Failedd');
    }
}