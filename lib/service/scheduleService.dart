import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:wedding_planner/model/scheduleModel.dart';

class ScheduleService {
  // static const String _baseUrl = 'http://10.0.2.2:8000/api/';
  // static const String _baseUrl = 'http://192.168.1.2:8000/api/';
  static const String _baseUrl = 'http://192.168.1.2:8000/api/';

  var tokenData = {
    'Content-Type': 'application/x-www-form-urlencoded',
    'Accept': "application/json"
  };

  Future<Schedule> getAllSchedule() async {
    final response = await http.get(Uri.parse(_baseUrl + "scedule"));
    if (response.statusCode == 200) {
      return Schedule.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future createSchedule(Map<String, dynamic> body) async {
    final response = await http.post(Uri.parse(_baseUrl + "scedule"),
        body: body, headers: tokenData);

    try {
      if (response.statusCode == 201) {
        return true;
      }
    } catch (e) {
      print(e);
    }
  }

  Future<bool> deleteSchedule(int id) async {
    final response = await http.delete(
        Uri.parse(_baseUrl + "scedule/" + id.toString()),
        headers: tokenData);

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> updateSchedule(Map<String, dynamic> body, int id) async {
    final response = await http.put(
        Uri.parse(_baseUrl + "scedule/" + id.toString()),
        body: body,
        headers: tokenData);

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }
}
