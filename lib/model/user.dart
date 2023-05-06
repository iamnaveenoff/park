import 'dart:convert';

UserModel userModel(String str) => UserModel.fromJson(json.decode(str));

class UserModel {
  int? id;
  String? username;
  String? name;
  String? email;
  String? phone;
  List<String>? roles;
  String? accessToken;

  UserModel(
      {this.id,
      this.username,
      this.name,
      this.email,
      this.phone,
      this.roles,
      this.accessToken});

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    roles = json['roles'].cast<String>();
    accessToken = json['accessToken'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['username'] = username;
    data['name'] = name;
    data['email'] = email;
    data['phone'] = phone;
    data['roles'] = roles;
    data['accessToken'] = accessToken;
    return data;
  }
}
