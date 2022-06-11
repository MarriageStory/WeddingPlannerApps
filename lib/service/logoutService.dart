import 'dart:convert';
import 'package:wedding_planner/model/logoutAuth.dart';
import 'package:http/http.dart' as http;

class LogoutService {
  // static const String _baseUrl =
  //     'https://immense-cliffs-78720.herokuapp.com/api/';
  static const String _baseUrl = 'http://192.168.1.2:8000/api/';
  
  Future<Logout> getLogout() async {
    final response = await http.get(Uri.parse(_baseUrl + "logout"));

    if (response.statusCode == 200) {
      return Logout.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load data');
    }
  }
}
