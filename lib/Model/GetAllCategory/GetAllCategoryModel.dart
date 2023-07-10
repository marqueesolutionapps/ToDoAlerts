part of '../ModelLibrary.dart';

class GetAllCategoryModel {
  int? status;
  String? messages;
  List<AllCategoryData>? data;

  GetAllCategoryModel({this.status, this.messages, this.data});

  GetAllCategoryModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    messages = json['messages'];
    if (json['data'] != null) {
      data = <AllCategoryData>[];
      try{
        json['data'].forEach((v){
          data!.add(AllCategoryData.fromJson(v));
        });
      }catch(e){
        if(e.toString().contains('(dynamic) => Null')){
          data!.add(AllCategoryData.fromJson(json['data']));
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

class AllCategoryData {
  String? id;
  String? deviceId;
  String? userId;
  String? categoryName;
  String? categoryColor;

  AllCategoryData({this.id, this.deviceId, this.userId, this.categoryName, this.categoryColor});

  AllCategoryData.fromJson(Map<String, dynamic> json) {
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