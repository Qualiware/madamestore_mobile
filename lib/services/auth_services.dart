import 'dart:convert';
import 'dart:io';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart';

class AuthService {
  late SharedPreferences sharedPreference;

  Future<bool> verifyToken() async {
    sharedPreference = await SharedPreferences.getInstance();

    if (sharedPreference.getString('accessToken') == null) {
      return false;
    }

    return true;
  }

  Future<bool> login(String email, String password) async {
    sharedPreference = await SharedPreferences.getInstance();

    var apiUrl =
        Uri.parse('http://192.168.77.34:8081/modelo-api/api/v1/auth/login');

    var body = jsonEncode({'email': email, 'senha': password});
    var response = await post(apiUrl, body: body, headers: {
      'Accept': 'application/json',
      'Content-Type': 'application/json'
    });

    if (response.statusCode == 200) {
      await sharedPreference.setString(
          'accessToken', "Token ${jsonDecode(response.body)['accessToken']}");

      return true;
    } else {
      //print(response.body);
      return false;
    }
  }

  Future<bool> logout() async {
    sharedPreference = await SharedPreferences.getInstance();

    await sharedPreference.clear();
    return true;
  }
}
