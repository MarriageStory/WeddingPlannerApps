import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wedding_planner/model/loginAuth.dart';
import 'package:http/http.dart' as http;

class loginService {
  // static final String _baseUrl =
  //     'https://immense-cliffs-78720.herokuapp.com/api/';
  static const String _baseUrl = 'http://192.168.1.2:8000/api/';
  
  Future<Login> logins(Map<String, dynamic> data) async {
    final prefs = await SharedPreferences.getInstance();

    var dataLogin = <String, dynamic>{
      'email': data['email'],
      'password': data['password'],
    };

    var response = await http.post(Uri.parse(_baseUrl + "login"),
        body: jsonEncode(dataLogin),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json'
        });
    if (response.statusCode == 200) {
      Map<dynamic, dynamic> temp = jsonDecode(response.body);
      await prefs.setString('token', temp['token']);
      print("Hallo ");
      return Login.fromJson(jsonDecode(response.body));
    } else {
      return Login.fromJson(jsonDecode(response.body));
    }
  }
}
