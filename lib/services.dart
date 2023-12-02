import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:w_app/model.dart';


String api='c9b62d87f2a74f169c071814232811';
String base='api.weatherapi.com';


class Model1 {


  Future getData(String q) async {
    final par = {
      'key': '$api',
      'q': '$q'
    };
    final url = Uri.https(base, '/v1/current.json', par);
    final resp = await http.get(url);
    if (resp.statusCode == 200) {
      print(resp.body);
       final mod = welcomeFromJson(resp.body);


      print('country : ${mod.location.country}');
      return mod;
    } else {
      print('failed');
    }
  }

}
