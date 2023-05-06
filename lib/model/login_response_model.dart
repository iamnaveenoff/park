import 'dart:convert';

LoginResponseModel loginResponseModel(String str) =>
    LoginResponseModel.fromJson(json.decode(str));

class LoginResponseModel {
  String? firstName;
  String? lastName;
  String? username;
  String? createdDate;
  String? id;
  String? token;

  LoginResponseModel(String body, 
      {this.firstName,
      this.lastName,
      this.username,
      this.createdDate,
      this.id,
      this.token});

  LoginResponseModel.fromJson(Map<String, dynamic> json) {
    firstName = json['firstName'];
    lastName = json['lastName'];
    username = json['username'];
    createdDate = json['createdDate'];
    id = json['id'];
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['firstName'] = firstName;
    data['lastName'] = lastName;
    data['username'] = username;
    data['createdDate'] = createdDate;
    data['id'] = id;
    data['token'] = token;
    return data;
  }
}
