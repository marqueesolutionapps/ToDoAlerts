// ignore_for_file: file_names

part of '../ModelLibrary.dart';

abstract class GetAllCategoryDataController {
  void onLoadGetAllCategorySuccess(GetAllCategoryModel item);
  void onLoadGetAllCategoryError(CommonMessageModel items);
  void onLoadGetAllCategoryConnection(var connection) {}
}