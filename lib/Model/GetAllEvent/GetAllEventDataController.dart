// ignore_for_file: file_names

part of '../ModelLibrary.dart';

abstract class GetAllEventDataController {
  void onLoadGetAllEventSuccess(GetAllEventModel item);
  void onLoadGetAllEventError(CommonMessageModel items);
  void onLoadGetAllEventConnection(var connection) {}
}