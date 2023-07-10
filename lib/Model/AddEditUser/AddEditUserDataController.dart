// ignore_for_file: file_names

part of '../ModelLibrary.dart';

abstract class AddEditUserDataController {
  void onLoadAddEditUserSuccess(AddEditUserModel item);
  void onLoadAddEditUserError(CommonMessageModel items);
  void onLoadAddEditUserConnection(var connection) {}
}