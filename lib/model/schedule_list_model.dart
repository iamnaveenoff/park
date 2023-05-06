class ScheduleListModel {
  int? id;
  String? username;
  String? name;
  String? email;
  String? scheduledDate;
  String? remarks;
  String? status;
  String? createdAt;
  String? createdBy;
  String? updatedBy;
  String? updatedAt;

  ScheduleListModel(
      {this.id,
      this.username,
      this.name,
      this.email,
      this.scheduledDate,
      this.remarks,
      this.status,
      this.createdAt,
      this.createdBy,
      this.updatedBy,
      this.updatedAt});

  ScheduleListModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    name = json['name'];
    email = json['email'];
    scheduledDate = json['scheduledDate'];
    remarks = json['remarks'];
    status = json['status'];
    createdAt = json['createdAt'];
    createdBy = json['createdBy'];
    updatedBy = json['updatedBy'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['username'] = username;
    data['name'] = name;
    data['email'] = email;
    data['scheduledDate'] = scheduledDate;
    data['remarks'] = remarks;
    data['status'] = status;
    data['createdAt'] = createdAt;
    data['createdBy'] = createdBy;
    data['updatedBy'] = updatedBy;
    data['updatedAt'] = updatedAt;
    return data;
  }
}
