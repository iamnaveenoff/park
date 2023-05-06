import 'package:exp_parking/model/available_slot_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../services/api.dart';

class AvailableSlotCountProvider extends ChangeNotifier {
  late AvailableSlotCountModel dataModel;
  fetchData(context) async {
    dataModel = (await getAvailableSlotCount())!;
    final prefs = await SharedPreferences.getInstance();
    prefs.setString("availableSlot", dataModel.availableSlotCount!);
    notifyListeners();
  }
}
