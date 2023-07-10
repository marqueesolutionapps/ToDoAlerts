part of '../ModelLibrary.dart';

class AddCategoryModel {
  int? status;
  String? messages;
  AddCategoryData? data;

  AddCategoryModel({this.status, this.messages, this.data});

  AddCategoryModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    messages = json['messages'];
    data = json['data'] != null ? new AddCategoryData.fromJson(json['data']) : null;
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

class AddCategoryData {
  String? id;
  String? deviceId;
  String? userId;
  String? categoryName;
  String? categoryColor;

  AddCategoryData({this.id, this.deviceId, this.userId, this.categoryName, this.categoryColor});

  AddCategoryData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    deviceId = json['device_id'];
    userId = json['user_id'];
    categoryName = json['category_name'];
    categoryColor = json['category_color'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['device_id'] = this.deviceId;
    data['user_id'] = this.userId;
    data['category_name'] = this.categoryName;
    data['category_color'] = this.categoryColor;
    return data;
  }
}