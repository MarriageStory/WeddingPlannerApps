import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wedding_planner/model/getUserAuth.dart';
import 'package:http/http.dart' as http;

class getUsers {
  // static final String _baseUrl =
  //     'https://immense-cliffs-78720.herokuapp.com/api/';
  static const String _baseUrl = 'http://192.168.1.2:8000/api/';
  
  Future<User> GetUser() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString("token");

    var response = await http.get(Uri.parse(_baseUrl + "profile"), headers: {
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': "bearer $token",
    });

    if (response.statusCode == 200) {
      return User.fromJson(jsonDecode(response.body)['data']);
    } else {
      throw Exception(response);
    }
  }
}
