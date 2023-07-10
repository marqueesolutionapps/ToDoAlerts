// ignore_for_file: file_names

part of 'ModelLibrary.dart';

class CommonMessageModel {
  int? status;
  String? messages;

  CommonMessageModel({this.status, this.messages});

  CommonMessageModel.fromJson(Map<String, dynamic> json) {
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