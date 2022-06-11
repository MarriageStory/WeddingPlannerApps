import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:wedding_planner/model/paymentDetailModel.dart';

class PaymentDetailService {
  static const String _baseUrl = 'http://192.168.1.2:8000/api/';
  // static const String _baseUrl = 'http://192.168.1.2:8000/api/';
  // static const String _baseUrl = 'http://192.168.43.110:8000/api/';

  var tokenData = {
    'Content-Type': 'application/x-www-form-urlencoded',
    'Accept': "application/json"
  };

  Future<PaymentDetail> getAllPaymentDetail() async {
    final response = await http.get(Uri.parse(_baseUrl + "payment_detail"));
    if (response.statusCode == 200) {
      return PaymentDetail.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future createPaymentDetail(Map<String, dynamic> body) async {
    final response = await http.post(Uri.parse(_baseUrl + "payment_detail"),
        body: body, headers: tokenData);

    try {
      if (response.statusCode == 201) {
        return true;
      } else {
        throw ("fail");
      }
    } catch (e) {
      print(e);
    }
  }

  Future<bool> deletePaymentDetail(int id) async {
    final response = await http.delete(
        Uri.parse(_baseUrl + "payment_detail/" + id.toString()),
        headers: tokenData);

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> updatePaymentDetail(Map<String, dynamic> body, int id) async {
    final response = await http.put(
        Uri.parse(_baseUrl + "payment_detail/" + id.toString()),
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
