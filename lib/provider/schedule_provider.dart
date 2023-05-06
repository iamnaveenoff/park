import 'dart:convert';

import 'package:exp_parking/model/schedule_model.dart';
import 'package:exp_parking/services/api.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class ScheduleProvider extends ChangeNotifier {
  bool isBack = false;
  Future<String> scheduleData(ScheduleModel body) async {
    notifyListeners();
    http.Response response = (await saveSchedule(body))!;
    var data = json.decode(response.body);
    if (response.statusCode == 200) {
      isBack = true;
      var data = json.decode(response.body);
      notifyListeners();
      return data['message'];
    } else {
      notifyListeners();
      return data['message'];
    }
  }
}
