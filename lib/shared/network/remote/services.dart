import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:waddy_app/models/user/Waddy_app_model.dart';

class ApiServices {
  Future<LoginResponseModel> login(LoginRequestModel loginRequestModel) async {
    var url = Uri.parse('http://localhost:8080/auth/login');
    var response = await http.post(url, body: loginRequestModel.toJson());

    if (response.statusCode == 200) {
      return LoginResponseModel.fromJason(json.decode(response.body));
    } else {
      debugPrint(response.statusCode.toString());
      throw Exception('failed to load data');
    }
  }
}
