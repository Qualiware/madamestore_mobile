import 'dart:collection';
import 'dart:convert';
import 'package:http/http.dart';
import 'package:mobile_madamestore/constants/Constants.dart';
import 'package:mobile_madamestore/services/auth_services.dart';

class ProductsService {

  AuthService authService = AuthService();

  Future<HashMap<String, dynamic>> getProductById(int productId) async {

    var apiURL = Uri.parse(Constants.apiURL+'/produto/$productId');
    String accessToken = await authService.getAccessToken();

    var response = await get(apiURL, headers:  {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'accessToken': accessToken
    });

    print(response.body);

    return jsonDecode(response.body);
  }

  Future<List> getAll() async {

    var apiURL = Uri.parse(Constants.apiURL+'/produto/all');

    // var body = jsonEncode()
    String accessToken = await authService.getAccessToken();

    // print(accessToken);


    var response = await get(apiURL, headers: {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'accessToken': accessToken
    });

    print(jsonDecode(response.body));

    return jsonDecode(response.body);
  }
}