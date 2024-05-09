import 'dart:convert';

UserResponseModel usernameResponseJson(String str) =>
    UserResponseModel.fromJson(json.decode(str));

class UserResponseModel {
  String? username;
  String? email;

  UserResponseModel({this.username, this.email});

  UserResponseModel.fromJson(Map<String, dynamic> json) {
    username = json['user']['username'];
    email = json['user']['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["user"]["username"] = this.username;
    data["user"]["email"] = this.email;
    return data;
  }
}
