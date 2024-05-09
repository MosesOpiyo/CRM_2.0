import 'dart:convert';

TokenClass tokenClassJson(String str) => TokenClass.fromJson(json.decode(str));

class TokenClass {
  String? accessToken;
  String? refreshToken;

  TokenClass({
    this.accessToken,
    this.refreshToken,
  });

  TokenClass.fromJson(Map<String, dynamic> json) {
    accessToken = json['tokens']['access'];
    refreshToken = json['tokens']['refresh'];
  }
}
