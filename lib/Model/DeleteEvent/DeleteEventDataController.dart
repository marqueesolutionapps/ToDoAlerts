// ignore_for_file: file_names

part of '../ModelLibrary.dart';

abstract class DeleteEventDataController {
  void onLoadDeleteEventSuccess(DeleteEventModel item);
  void onLoadDeleteEventError(CommonMessageModel items);
  void onLoadDeleteEventConnection(var connection) {}
}