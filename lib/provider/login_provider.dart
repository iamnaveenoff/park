import 'dart:convert';

import 'package:exp_parking/model/login_model.dart';
import 'package:exp_parking/model/user.dart';
import 'package:exp_parking/services/api.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class LoginProvider extends ChangeNotifier {
  bool isBack = false;
  bool isAdmin = false;
  bool isModerator = false;
  Future<String> loginData(LoginModel body) async {
    notifyListeners();
    http.Response response = (await login(body))!;
    if (response.statusCode == 200) {
      UserModel userData = UserModel.fromJson(jsonDecode(response.body));
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isLoggedIn', true);
      await prefs.setString('username', userData.username.toString());
      await prefs.setString('name', userData.name.toString());
      await prefs.setString('email', userData.email.toString());
      await prefs.setString('phone', userData.phone.toString());
      await prefs.setString('token', userData.accessToken.toString());
      await prefs.setStringList('roles', userData.roles!.toList());
      List<String> roles = userData.roles!.toList();
      if (roles.contains('ROLE_ADMIN') || roles.contains('ROLE_MODERATOR')) {
        if (roles.contains('ROLE_ADMIN') && roles.contains('ROLE_MODERATOR')) {
          isAdmin = await prefs.setBool('isAdmin', true);
          isModerator = await prefs.setBool('isModerator', true);
        } else if (roles.contains('ROLE_ADMIN')) {
          isModerator = await prefs.setBool('isModerator', false);
          isAdmin = await prefs.setBool('isAdmin', true);
        } else {
          isModerator = await prefs.setBool('isModerator', true);
          isAdmin = await prefs.setBool('isAdmin', false);
        }
      } else {
        isAdmin = await prefs.setBool('isAdmin', false);
        isModerator = await prefs.setBool('isModerator', false);
      }

      isBack = true;
      notifyListeners();
      return "Login successful.";
    }
    notifyListeners();
    return "User Not found.";
    // return UserModel(response.body);
  }
}
