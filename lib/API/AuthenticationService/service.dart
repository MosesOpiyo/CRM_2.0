import 'package:admin/API/Constants/constants.dart';
import 'package:admin/ResponseModels/token_model.dart';
import 'package:admin/ResponseModels/user_model.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';

class AuthService {
  final storage = const FlutterSecureStorage();

  final str = "";
  Future<TokenClass> login(String email, String password) async {
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
    };
    var url = Uri.parse(ApiConstants.baseUrl + ApiConstants.userLogin);
    var response = await http.post(
      url,
      headers: requestHeaders,
      body: jsonEncode({"email": email, "password": password}),
    );
    if (response.statusCode == 200) {
      return tokenClassJson(response.body);
    } else {
      return tokenClassJson(str);
    }
  }

  Future<UserResponseModel> getProfile() async {
    final accessToken = await storage.read(key: 'access_token');
    var url = Uri.parse(ApiConstants.baseUrl + ApiConstants.userProfile);
    var response = await http.get(
      url,
      headers: {HttpHeaders.authorizationHeader: "Bearer $accessToken"},
    );
    if (response.statusCode == 200) {
      return UserResponseModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load album');
    }
  }
}
