import 'dart:convert';
import 'dart:io';

import 'package:mobile_madamestore/constants/Constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

class AuthService {
  late SharedPreferences sharedPreference;

  Future<bool> verifyToken() async {
    sharedPreference = await SharedPreferences.getInstance();


    if (sharedPreference.getString('accessToken') == null) {
      return false;
    }

    print(sharedPreference.getString('accessToken'));

    return true;
  }

  Future<bool> login(String email, String password) async {
    sharedPreference = await SharedPreferences.getInstance();

    var apiUrl =
        Uri.parse(Constants.apiURL+'/auth/login');

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
      print(response.body);
      return false;
    }
  }

  Future<bool> logout() async {
    sharedPreference = await SharedPreferences.getInstance();

    await sharedPreference.clear();
    return true;
  }

  Future<String> getAccessToken() async {
    sharedPreference = await SharedPreferences.getInstance();

    String? accessToken = sharedPreference.getString('accessToken');

    if (accessToken != null) return accessToken;

    return '';
  }

  Future<Map> getUserInformation() async {
    sharedPreference = await SharedPreferences.getInstance();

    return JwtDecoder.decode(sharedPreference.getString('accessToken')!);
  }

  Future<void> clearAccesToken() async {
    sharedPreference = await SharedPreferences.getInstance();

    sharedPreference.clear();
  }

}
