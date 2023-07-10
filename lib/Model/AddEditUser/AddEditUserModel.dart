part of '../ModelLibrary.dart';

class AddEditUserModel {
  int? status;
  String? messages;
  AddEditUserData? data;

  AddEditUserModel({this.status, this.messages, this.data});

  AddEditUserModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    messages = json['messages'];
    data = json['data'] != null ? new AddEditUserData.fromJson(json['data']) : null;
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

class AddEditUserData {
  String? id;
  String? deviceId;
  String? username;
  String? email;
  String? phoneNo;

  AddEditUserData({this.id, this.deviceId, this.username, this.email, this.phoneNo});

  AddEditUserData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    deviceId = json['device_id'];
    username = json['username'];
    email = json['email'];
    phoneNo = json['phone_no'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['device_id'] = this.deviceId;
    data['username'] = this.username;
    data['email'] = this.email;
    data['phone_no'] = this.phoneNo;
    return data;
  }
}