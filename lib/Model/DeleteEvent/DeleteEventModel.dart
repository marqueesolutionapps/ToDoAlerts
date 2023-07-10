part of '../ModelLibrary.dart';

class DeleteEventModel {
  int? status;
  String? messages;

  DeleteEventModel({this.status, this.messages});

  DeleteEventModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    messages = json['messages'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['messages'] = this.messages;
    return data;
  }
}