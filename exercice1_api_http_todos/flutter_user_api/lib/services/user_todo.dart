import 'dart:convert';

import 'package:flutter_user_api/models/todo.dart';
import 'package:http/http.dart' as http;

Future<List<Todo>> getAllTodos() async {  
  List<Todo> userList = [];
  var url = Uri.https("jsonplaceholder.typicode.com", "/todos");
  var response = await http.get(url);

  if (response.statusCode == 200) {
    var jsonResponse = jsonDecode(response.body);
    for (var data in jsonResponse) {
      Todo user = Todo(data["title"], data["completed"]);
      userList.add(user);
    }
  } else {
    // ignore: avoid_print
    print('Request failed with status: ${response.statusCode}.');
  }
  return userList;
}
