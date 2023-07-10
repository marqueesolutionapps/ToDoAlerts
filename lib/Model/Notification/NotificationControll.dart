part of '../ModelLibrary.dart';

class NotificationHistory {
  final int? id;
  final String? timestamp;
  final String? actionType;
  final String? body;
  final String? title;
  final int? status;

  NotificationHistory(
      {this.id,
        this.timestamp,
        this.actionType,
        this.body,
        this.title,
        this.status});

  factory NotificationHistory.fromJson(Map<String, dynamic> json) {
    return NotificationHistory(
      id: json['id'],
      timestamp: json['timestamp'],
      actionType: json['action_type'],
      body: json['body'],
      title: json['title'],
      status: json['status'],
    );
  }
}