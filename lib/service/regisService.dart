import 'package:wedding_planner/model/regisAuth.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:wedding_planner/screens/other/components/body.dart';

class regisService {
  // static final String _baseUrl =
  //     'https://immense-cliffs-78720.herokuapp.com/api/';
  static const String _baseUrl = 'http://192.168.1.2:8000/api/';

  Future register(Map<String, dynamic> body) async {
    final response = await http.post(Uri.parse(_baseUrl + "register"),
        headers: {
          'content-Type': 'aplication/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{
          'name': body["name"]!,
          'email': body["email"]!,
          'password': body["password"]!,
          'password_confirmation': body["password"]!,
        }));

    if (response.statusCode == 201) {
      return true;
    } else {
      return false;
    }
  }
}
