class Config {
  static const String appName = "Exp Parking";
  static const String apiBaseUrl = 'http://192.168.1.68:5000/api'; //PROD_URL
  static const loginAPI = "$apiBaseUrl/auth/signin";
  static const signUpAPI = "$apiBaseUrl/auth/signup";
  static const scheduleAPI = "$apiBaseUrl/saveSchedule";
  static const getAllScheduleAPI = "$apiBaseUrl/allSchedules";
  static const getAllApprovedScheduleAPI = "$apiBaseUrl/allApprovedSchedules";
  static const getScheduleByIdAPI = "$apiBaseUrl/Schedule/";
  static const updateScheduleByIdAPI = "$apiBaseUrl/updateSchedule/";
  static const getAllUserScheduleAPI = "$apiBaseUrl/allSchedulesByUser/";
  static const getAvailableSlotCountAPI = "$apiBaseUrl/availableSlots";
  static const getUpdateAvailableSlotCountAPI = "$apiBaseUrl/updateParkingSlot";
}
