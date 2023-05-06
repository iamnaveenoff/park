class ScheduleModel {
  String? username;
  String? email;
  String? scheduledDate;
  String? status;
  String? createdBy;
  String? updatedBy;
  String? phoneNumber;
  String? remarks;

  ScheduleModel(
      {this.username,
      this.email,
      this.scheduledDate,
      this.createdBy,
      this.updatedBy,
      this.status,
      this.phoneNumber,
      this.remarks});

  ScheduleModel.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    email = json['email'];
    scheduledDate = json['scheduledDate'];
    status = json['status'];
    createdBy = json['createdBy'];
    phoneNumber = json['phoneNumber'];
    updatedBy = json['updatedBy'];
    remarks = json['remarks'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['username'] = username;
    data['email'] = email;
    data['scheduledDate'] = scheduledDate;
    data['status'] = status;
    data['createdBy'] = createdBy;
    data['phoneNumber'] = phoneNumber;
    data['updatedBy'] = updatedBy;
    data['remarks'] = remarks;
    return data;
  }
}
