// ignore_for_file: file_names

part of '../ModelLibrary.dart';

abstract class UpdateTokenDataController {
  void onLoadUpdateTokenSuccess(UpdateTokenModel item);
  void onLoadUpdateTokenError(CommonMessageModel items);
  void onLoadUpdateTokenConnection(var connection) {}
}