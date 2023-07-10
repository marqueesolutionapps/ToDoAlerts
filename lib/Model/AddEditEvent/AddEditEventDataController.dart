// ignore_for_file: file_names

part of '../ModelLibrary.dart';

abstract class AddEditEventDataController {
  void onLoadAddEditEventSuccess(AddEditEventModel item);
  void onLoadAddEditEventError(CommonMessageModel items);
  void onLoadAddEditEventConnection(var connection) {}
}