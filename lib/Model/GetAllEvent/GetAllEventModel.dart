part of '../ModelLibrary.dart';

class GetAllEventModel {
  int? status;
  String? messages;
  List<AllEventData>? data;

  GetAllEventModel({this.status, this.messages, this.data});

  GetAllEventModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    messages = json['messages'];
    if (json['data'] != null) {
      data = <AllEventData>[];
      try{
        json['data'].forEach((v){
          data!.add(AllEventData.fromJson(v));
        });
      }catch(e){
        if(e.toString().contains('(dynamic) => Null')){
          data!.add(AllEventData.fromJson(json['data']));
        }
      }
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['messages'] = this.messages;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class AllEventData {
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
  String? categoryColor;

  AllEventData({this.id,
    this.deviceId,
    this.eventName,
    this.note,
    this.date,
    this.startTime,
    this.endTime,
    this.remindMe,
    this.categoryId,
    this.userId,
    this.categoryName,
    this.categoryColor});

  AllEventData.fromJson(Map<String, dynamic> json) {
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
    categoryColor = json['category_color'];
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
    data['category_color'] = this.categoryColor;
    return data;
  }
}