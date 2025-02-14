import 'dart:convert';

import 'package:cronavirus/Model/wholeworldModel.dart';
import 'package:cronavirus/Services/Utilities/app_url.dart';
import 'package:http/http.dart' as http;

class Statsapis {
  Future<WholeWorldModel> WorldStats() async {
    final response = await http.get(Uri.parse(AppUrl.worldStateApi));
    if (response.statusCode == 200) {
      return WholeWorldModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("ERROR WHILE FETCHING WORLD STATS");
    }
  }

  Future<List<dynamic>> fetchAffectedCountries() async {
    final response = await http.get(Uri.parse(AppUrl.countryStateApi));
    dynamic data = [];
    if (response.statusCode == 200) {
      data = jsonDecode(response.body);

      print('COUNTRIES DATA  ::: $data ');
      return data;
    } else {
      throw Exception("ERROR WHILE FETCHING WORLD STATS");
    }
  }
}
