// ignore_for_file: file_names

part of '../ModelLibrary.dart';

class AddCategoryParent  {
  AddCategoryDataController? contract;

  AddCategoryParent(this.contract);
  void loadData(String categoryName, String categoryColor) {
    InternetChecker.checkInternet().then((value) async {
      try {
        if(value) {
          var request = http.MultipartRequest('POST', Uri.parse(addCategoryAPI),);
          request.fields.addAll({
            'device_id': SPUtil.getDeviceId(),
            'user_id': SPUtil.getUserId(),
            'category_name': categoryName,
            'category_color': categoryColor,
          });
          var streamResponse = await request.send();
          final response = await http.Response.fromStream(streamResponse);
          // Util.consoleLog("response.body Add Category ${response.body}");
          var data;
          if(response.body!="") {
            data= json.decode(response.body);
          }
          if(data['status'] == 200){
            contract!.onLoadAddCategorySuccess(AddCategoryModel.fromJson(data));
            return;
          }else if (data['status'] > 500 && data['status'] < 600) {
            contract!.onLoadAddCategoryConnection(serverApiError);
            return;
          }else{
            contract!.onLoadAddCategoryError(CommonMessageModel.fromJson(data));
          }
        }
        else {
          contract!.onLoadAddCategoryConnection(pleaseCheckInternetConnection);
        }
      }
      catch(e) {
        contract!.onLoadAddCategoryConnection(somethingWrongString);
      }
    });
  }
}