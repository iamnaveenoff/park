import 'dart:convert';

import 'package:exp_parking/model/schedule_model.dart';
import 'package:exp_parking/services/api.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class ScheduleById extends ChangeNotifier {
  ScheduleModel scheduleData = ScheduleModel();
  Future getScheduleById(int id) async {
    http.Response response = (await getScheduleDetailsById(id))!;
    if (response.statusCode == 200) {
      scheduleData = ScheduleModel.fromJson(jsonDecode(response.body));
      notifyListeners();

      return scheduleData;
    }
  }
}
