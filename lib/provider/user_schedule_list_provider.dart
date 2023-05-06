import 'dart:convert';

import 'package:exp_parking/model/schedule_list_model.dart';
import 'package:exp_parking/services/api.dart';
import 'package:flutter/cupertino.dart';

class UserScheduleListProvider extends ChangeNotifier {
  List<ScheduleListModel> scheduleList = [];

  Future getAllUserScheduleListData(String username) async {
    getAllUserSchedule(username).then((response) => {
          if (response!.statusCode == 200)
            {
              scheduleList = [],
              json.decode(response.body).forEach((element) {
                scheduleList.add(ScheduleListModel.fromJson(element));
              }),
              notifyListeners(),
            }
        });
    return scheduleList;
  }
}
