// ignore_for_file: file_names

part of '../ModelLibrary.dart';

abstract class GetUserDataController {
  void onLoadGetUserSuccess(GetUserModel item);
  void onLoadGetUserError(CommonMessageModel items);
  void onLoadGetUserConnection(var connection) {}
}