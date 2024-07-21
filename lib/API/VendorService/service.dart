import 'dart:convert';

import 'package:admin/API/Constants/constants.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:http/http.dart' as http;
import 'dart:io';

class VendorService {
  final storage = const FlutterSecureStorage();

  Future<List<dynamic>> getVendors() async {
    final accessToken = await storage.read(key: 'access_token');
    var url = Uri.parse(ApiConstants.baseUrl + ApiConstants.allInStockVendors);
    var response = await http.get(
      url,
      headers: {HttpHeaders.authorizationHeader: "Bearer $accessToken"},
    );
    if (response.statusCode == 200) {
      final List<dynamic> suppliers = jsonDecode(response.body);
      return suppliers;
    } else {
      throw Exception('Failed to load album');
    }
  }
}
