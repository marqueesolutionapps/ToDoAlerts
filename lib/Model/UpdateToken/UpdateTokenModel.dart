part of '../ModelLibrary.dart';

class UpdateTokenModel {
  int? status;
  String? messages;
  UpdateTokenData? data;

  UpdateTokenModel({this.status, this.messages, this.data});

  UpdateTokenModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    messages = json['messages'];
    data = json['data'] != null ? new UpdateTokenData.fromJson(json['data']) : null;
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

class UpdateTokenData {
  String? id;
  String? deviceId;
  String? username;
  String? email;
  String? phoneNo;
  String? token;

  UpdateTokenData({this.id,
    this.deviceId,
    this.username,
    this.email,
    this.phoneNo,
    this.token});

  UpdateTokenData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    deviceId = json['device_id'];
    username = json['username'];
    email = json['email'];
    phoneNo = json['phone_no'];
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['device_id'] = this.deviceId;
    data['username'] = this.username;
    data['email'] = this.email;
    data['phone_no'] = this.phoneNo;
    data['token'] = this.token;
    return data;
  }
}