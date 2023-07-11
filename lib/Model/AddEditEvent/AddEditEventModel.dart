part of '../ModelLibrary.dart';

class AddEditEventModel {
  int? status;
  String? messages;
  AddEditEventData? data;

  AddEditEventModel({this.status, this.messages, this.data});

  AddEditEventModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    messages = json['messages'];
    data = json['data'] != null ? new AddEditEventData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['messages'] = this.messages;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class AddEditEventData {
  String? id;
  String? deviceId;
  String? eventName;
  String? note;
  String? date;
  String? startTime;
  String? endTime;
  String? remindMe;
  String? categoryId;
  String? userId;
  String? categoryName;
  String? startUTCTime;

  AddEditEventData({this.id, this.deviceId, this.userId, this.categoryName, this.date, this.startTime, this.endTime, this.categoryId, this.eventName, this.note, this.remindMe, this.startUTCTime});

  AddEditEventData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    deviceId = json['device_id'];
    eventName = json['event_name'];
    note = json['note'];
    date = json['date'];
    startTime = json['start_time'];
    endTime = json['end_time'];
    remindMe = json['remind_me'];
    categoryId = json['category_id'];
    userId = json['user_id'];
    categoryName = json['category_name'];
    startUTCTime = json['start_utc_time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['device_id'] = this.deviceId;
    data['event_name'] = this.eventName;
    data['note'] = this.note;
    data['date'] = this.date;
    data['start_time'] = this.startTime;
    data['end_time'] = this.endTime;
    data['remind_me'] = this.remindMe;
    data['category_id'] = this.categoryId;
    data['user_id'] = this.userId;
    data['category_name'] = this.categoryName;
    data['start_utc_time'] = this.startUTCTime;
    return data;
  }
}