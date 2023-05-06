import 'dart:convert';

import 'package:exp_parking/model/available_slot_model.dart';
import 'package:exp_parking/model/schedule_model.dart';
import 'package:exp_parking/services/api.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class UpdateAvailableSloutCountProvider extends ChangeNotifier {
  Future updateAvailableSlotCount(
      AvailableSlotCountModel availableSlotCountModel) async {
    http.Response response =
        (await updateParkingSlot(availableSlotCountModel))!;
    var data = json.decode(response.body);
    if (response.statusCode == 200) {
      notifyListeners();
      return data['message'];
    } else {
      notifyListeners();
      return data['message'];
    }
  }
}
