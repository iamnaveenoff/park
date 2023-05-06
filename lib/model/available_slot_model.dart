class AvailableSlotCountModel {
  int? id;
  String? vehichleType;
  String? providedSlotCount;
  String? availableSlotCount;

  AvailableSlotCountModel(
      {this.id,
      this.vehichleType,
      this.providedSlotCount,
      this.availableSlotCount});

  AvailableSlotCountModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    vehichleType = json['vehichleType'];
    providedSlotCount = json['providedSlotCount'];
    availableSlotCount = json['availableSlotCount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['vehichleType'] = vehichleType;
    data['providedSlotCount'] = providedSlotCount;
    data['availableSlotCount'] = availableSlotCount;
    return data;
  }
}
