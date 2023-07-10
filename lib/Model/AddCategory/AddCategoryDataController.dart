// ignore_for_file: file_names

part of '../ModelLibrary.dart';

abstract class AddCategoryDataController {
  void onLoadAddCategorySuccess(AddCategoryModel item);
  void onLoadAddCategoryError(CommonMessageModel items);
  void onLoadAddCategoryConnection(var connection) {}
}