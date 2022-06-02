import 'dart:convert';

import 'package:flutter_user_api/models/genderize.dart';
import 'package:http/http.dart' as http;

Future<Gender> getAllTodos(String firstName) async {
  if (firstName.isEmpty) return Gender("Error", "Error", "0");

  final queryParameters = {'name': firstName};

  var url = Uri.https("api.genderize.io", "", queryParameters);
  var response = await http.get(url);

  if (response.statusCode == 200) {
    var jsonResponse = jsonDecode(response.body);
    String gender = jsonResponse["gender"] == "male" ? "Masculin" : "Féminin";
    return Gender(jsonResponse["name"], gender,
        (jsonResponse["probability"] * 100).toString() + "%");
  } else {
    // ignore: avoid_print
    print('Request failed with status: ${response.statusCode}.');
  }
  return Gender("Error", "Error", "0");
}
