import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:wedding_planner/model/paymentModel.dart';

class PaymentService {
  // static const String _baseUrl = 'http://10.0.2.2:8000/api/';
  // static const String _baseUrl = 'http://192.168.1.2:8000/api/';
  static const String _baseUrl = 'http://192.168.1.2:8000/api/';

  var tokenData = {
    'Content-Type': 'application/x-www-form-urlencoded',
    'Accept': "application/json"
  };

  Future<Payment> getAllPayment() async {
    final response = await http.get(Uri.parse(_baseUrl + "payment"));
    if (response.statusCode == 200) {
      return Payment.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future createPayment(Map<String, dynamic> body) async {
    final response = await http.post(Uri.parse(_baseUrl + "payment"),
        body: body, headers: tokenData);

    try {
      if (response.statusCode == 201) {
        return true;
      }
    } catch (e) {
      print(e);
    }
  }

  Future<bool> deletePayment(int id) async {
    final response = await http.delete(
        Uri.parse(_baseUrl + "payment/" + id.toString()),
        headers: tokenData);

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> updatePayment(Map<String, dynamic> body, int id) async {
    final response = await http.put(
        Uri.parse(_baseUrl + "payment/" + id.toString()),
        body: body,
        headers: tokenData);

    if (response.statusCode == 200) {
      return true;
    } else {
      // return false;
      throw ("false");
    }
  }
}
