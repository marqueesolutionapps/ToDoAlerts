// ignore_for_file: file_names, depend_on_referenced_packages

library model_library;

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:todoalerts/Utility/UtilityLibrary.dart';

part 'CommonMessageModel.dart';

part 'AddEditUser/AddEditUserDataController.dart';
part 'AddEditUser/AddEditUserParent.dart';
part 'AddEditUser/AddEditUserModel.dart';

part 'AddEditEvent/AddEditEventDataController.dart';
part 'AddEditEvent/AddEditEventParent.dart';
part 'AddEditEvent/AddEditEventModel.dart';

part 'AddCategory/AddCategoryDataController.dart';
part 'AddCategory/AddCategoryParent.dart';
part 'AddCategory/AddCategoryModel.dart';

part 'DeleteEvent/DeleteEventDataController.dart';
part 'DeleteEvent/DeleteEventParent.dart';
part 'DeleteEvent/DeleteEventModel.dart';

part 'GetAllCategory/GetAllCategoryDataController.dart';
part 'GetAllCategory/GetAllCategoryParent.dart';
part 'GetAllCategory/GetAllCategoryModel.dart';

part 'GetAllEvent/GetAllEventDataController.dart';
part 'GetAllEvent/GetAllEventParent.dart';
part 'GetAllEvent/GetAllEventModel.dart';

part 'UpdateToken/UpdateTokenDataController.dart';
part 'UpdateToken/UpdateTokenParent.dart';
part 'UpdateToken/UpdateTokenModel.dart';

part 'GetUser/GetUserDataController.dart';
part 'GetUser/GetUserParent.dart';
part 'GetUser/GetUserModel.dart';

part 'Notification/NotificationControll.dart';