import 'dart:collection';
import 'dart:convert';

import 'package:http/http.dart';

import 'package:mobile_madamestore/constants/Constants.dart';
import 'package:mobile_madamestore/models/Venda.dart';
import 'package:mobile_madamestore/services/auth_services.dart';

class VendasService {

  AuthService authService = AuthService();
  
  Future<HashMap<String, dynamic>> getVendaById(int vendaId) async {
    
    var apiURL = Uri.parse(Constants.apiURL+'/venda/$vendaId');
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

    var apiURL = Uri.parse(Constants.apiURL+'/venda/all');
    
    // var body = jsonEncode()


    String accessToken = await authService.getAccessToken();

    // print(accessToken);


    var response = await get(apiURL, headers: {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'accessToken': accessToken
    });


    return jsonDecode(response.body);
  }
}