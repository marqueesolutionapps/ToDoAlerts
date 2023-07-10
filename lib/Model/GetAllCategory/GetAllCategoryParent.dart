// ignore_for_file: file_names

part of '../ModelLibrary.dart';

class GetAllCategoryParent  {
  GetAllCategoryDataController? contract;

  GetAllCategoryParent(this.contract);
  void loadData() {
    InternetChecker.checkInternet().then((value) async {
      try {
        if(value) {
          var request = http.MultipartRequest('POST', Uri.parse(allCategoryListAPI),);
          request.fields.addAll({
            'user_id': SPUtil.getUserId(),
            'device_id': SPUtil.getDeviceId(),
          });
          var streamResponse = await request.send();
          final response = await http.Response.fromStream(streamResponse);
          // Util.consoleLog("response.body Get All Category ${response.body}");
          var data;
          if(response.body!="") {
            data= json.decode(response.body);
          }
          if(data['status'] == 200){
            contract!.onLoadGetAllCategorySuccess(GetAllCategoryModel.fromJson(data));
            return;
          }else if (data['status'] > 500 && data['status'] < 600) {
            contract!.onLoadGetAllCategoryConnection(serverApiError);
            return;
          }else{
            contract!.onLoadGetAllCategoryError(CommonMessageModel.fromJson(data));
          }
        }
        else {
          contract!.onLoadGetAllCategoryConnection(pleaseCheckInternetConnection);
        }
      }
      catch(e) {
        contract!.onLoadGetAllCategoryConnection(somethingWrongString);
      }
    });
  }
}