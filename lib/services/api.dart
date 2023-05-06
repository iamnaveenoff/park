import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:exp_parking/config/config.dart';
import 'package:exp_parking/model/available_slot_model.dart';
import 'package:exp_parking/model/login_model.dart';
import 'package:exp_parking/model/schedule_model.dart';
import 'package:exp_parking/model/signup_model.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

Future<http.Response?> register(SignupModel data) async {
  http.Response? response;
  try {
    response = await http.post(Uri.parse(Config.signUpAPI),
        headers: {
          HttpHeaders.contentTypeHeader: "application/json",
        },
        body: jsonEncode(data.toJson()));
  } catch (e) {
    log(e.toString());
  }
  return response;
}

Future<http.Response?> login(LoginModel data) async {
  http.Response? response;
  try {
    response = await http.post(Uri.parse(Config.loginAPI),
        headers: {
          HttpHeaders.contentTypeHeader: "application/json",
        },
        body: jsonEncode(data.toJson()));
  } catch (e) {
    log(e.toString());
  }
  return response;
}

Future<http.Response?> saveSchedule(ScheduleModel data) async {
  late SharedPreferences logindata;
  logindata = await SharedPreferences.getInstance();
  late String? token = logindata.getString('token');
  http.Response? response;
  try {
    response = await http.post(Uri.parse(Config.scheduleAPI),
        headers: {
          HttpHeaders.contentTypeHeader: "application/json",
          'x-access-token': '$token',
        },
        body: jsonEncode(data.toJson()));
  } catch (e) {
    log(e.toString());
  }
  return response;
}

Future<http.Response?> getAllSchedule() async {
  late SharedPreferences logindata;
  logindata = await SharedPreferences.getInstance();
  late String? token = logindata.getString('token');
  http.Response? response;
  try {
    response = await http.get(Uri.parse(Config.getAllScheduleAPI), headers: {
      HttpHeaders.contentTypeHeader: "application/json",
      'x-access-token': '$token',
    });
  } catch (e) {
    log(e.toString());
  }
  return response;
}

Future<http.Response?> getAllApprovedSchedule() async {
  late SharedPreferences logindata;
  logindata = await SharedPreferences.getInstance();
  late String? token = logindata.getString('token');
  http.Response? response;
  try {
    response =
        await http.get(Uri.parse(Config.getAllApprovedScheduleAPI), headers: {
      HttpHeaders.contentTypeHeader: "application/json",
      'x-access-token': '$token',
    });
  } catch (e) {
    log(e.toString());
  }
  return response;
}

Future<http.Response?> getAllUserSchedule(String username) async {
  late SharedPreferences logindata;
  logindata = await SharedPreferences.getInstance();
  late String? token = logindata.getString('token');
  http.Response? response;
  try {
    response = await http
        .get(Uri.parse(Config.getAllUserScheduleAPI + username), headers: {
      HttpHeaders.contentTypeHeader: "application/json",
      'x-access-token': '$token',
    });
  } catch (e) {
    log(e.toString());
  }
  return response;
}

Future<http.Response?> getScheduleDetailsById(int id) async {
  late SharedPreferences logindata;
  logindata = await SharedPreferences.getInstance();
  late String? token = logindata.getString('token');
  http.Response? response;
  try {
    response = await http
        .get(Uri.parse(Config.getScheduleByIdAPI + id.toString()), headers: {
      HttpHeaders.contentTypeHeader: "application/json",
      'x-access-token': '$token',
    });
  } catch (e) {
    log(e.toString());
  }
  return response;
}

Future<http.Response?> updateScheduleDetailsById(
    int id, ScheduleModel scheduleModel) async {
  Map data = {
    'status': scheduleModel.status,
    'remarks': scheduleModel.remarks,
    'updatedBy': scheduleModel.updatedBy,
  };
  late SharedPreferences logindata;
  logindata = await SharedPreferences.getInstance();
  late String? token = logindata.getString('token');
  http.Response? response;
  try {
    response =
        await http.put(Uri.parse(Config.updateScheduleByIdAPI + id.toString()),
            headers: {
              HttpHeaders.contentTypeHeader: "application/json",
              'x-access-token': '$token',
            },
            body: jsonEncode(data));
  } catch (e) {
    log(e.toString());
  }
  return response;
}

Future<AvailableSlotCountModel?> getAvailableSlotCount() async {
  late SharedPreferences logindata;
  logindata = await SharedPreferences.getInstance();
  late String? token = logindata.getString('token');
  AvailableSlotCountModel? availableSlotCountResponse;
  try {
    final response =
        await http.get(Uri.parse(Config.getAvailableSlotCountAPI), headers: {
      HttpHeaders.contentTypeHeader: "application/json",
      'x-access-token': '$token',
    });

    if (response.statusCode == 200) {
      final item = json.decode(response.body);
      availableSlotCountResponse = AvailableSlotCountModel.fromJson(item);
    }
  } catch (e) {
    log(e.toString());
  }
  return availableSlotCountResponse;
}

Future<http.Response?> updateParkingSlot(
    AvailableSlotCountModel availableSlotCountModel) async {
  Map data = {'availableSlotCount': availableSlotCountModel.availableSlotCount};
  late SharedPreferences logindata;
  logindata = await SharedPreferences.getInstance();
  late String? token = logindata.getString('token');
  http.Response? response;
  try {
    response = await http.put(Uri.parse(Config.getUpdateAvailableSlotCountAPI),
        headers: {
          HttpHeaders.contentTypeHeader: "application/json",
          'x-access-token': '$token',
        },
        body: jsonEncode(data));
  } catch (e) {
    log(e.toString());
  }
  return response;
}
