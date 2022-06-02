import 'dart:convert';

import 'package:api_users/models/user.dart';
import 'package:http/http.dart' as http;

Future<List<User>> getUserData() async {
  List<User> userList = [];

  var url = Uri.https("jsonplaceholder.typicode.com", "/users");
  var response = await http.get(url);
  if (response.statusCode == 200) {
    var jsonResponse = jsonDecode(response.body);
    for (var data in jsonResponse) {
      User user = User(data["name"], data["email"], data["username"]);
      userList.add(user);
    }
  } else {
    print('Request failed : ${response.statusCode}');
  }
  return userList;
}
