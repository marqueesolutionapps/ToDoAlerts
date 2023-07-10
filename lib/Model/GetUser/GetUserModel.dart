part of '../ModelLibrary.dart';

class GetUserModel {
  int? status;
  String? messages;
  GetUserData? data;

  GetUserModel({this.status, this.messages, this.data});

  GetUserModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    messages = json['messages'];
    data = json['data'] != null ? new GetUserData.fromJson(json['data']) : null;
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

class GetUserData {
  String? id;
  String? deviceId;
  String? userId;
  String? username;
  String? email;
  String? phoneNo;
  String? token;

  GetUserData({this.id,
    this.deviceId,
    this.userId,
    this.username,
    this.email,
    this.phoneNo,
    this.token});

  GetUserData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    deviceId = json['device_id'];
    userId = json['user_id'];
    username = json['username'];
    email = json['email'];
    phoneNo = json['phone_no'];
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['device_id'] = this.deviceId;
    data['user_id'] = this.userId;
    data['username'] = this.username;
    data['email'] = this.email;
    data['phone_no'] = this.phoneNo;
    data['token'] = this.token;
    return data;
  }
}