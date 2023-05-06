import 'dart:convert';

import 'package:exp_parking/model/schedule_model.dart';
import 'package:exp_parking/services/api.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class UpdateScheduleProvider extends ChangeNotifier {
  bool isBack = false;
  Future<String> updateScheduleById(
      int? id, ScheduleModel scheduleModel) async {
    http.Response response =
        (await updateScheduleDetailsById(id!, scheduleModel))!;
    var data = json.decode(response.body);
    if (response.statusCode == 200) {
      isBack = true;
      notifyListeners();
      return data['message'];
    } else {
      notifyListeners();
      return data['message'];
    }
  }
}
