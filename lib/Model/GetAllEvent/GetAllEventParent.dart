// ignore_for_file: file_names

part of '../ModelLibrary.dart';

class GetAllEventParent  {
  GetAllEventDataController? contract;

  GetAllEventParent(this.contract);
  void loadData() {
    InternetChecker.checkInternet().then((value) async {
      try {
        if(value) {
          var request = http.MultipartRequest('POST', Uri.parse(allEventListAPI),);
          request.fields.addAll({
            'user_id': SPUtil.getUserId(),
            'device_id': SPUtil.getDeviceId(),
          });
          var streamResponse = await request.send();
          final response = await http.Response.fromStream(streamResponse);
          // Util.consoleLog("response.body Get All Event ${response.body}");
          var data;
          if(response.body!="") {
            data= json.decode(response.body);
          }
          if(data['status'] == 200){
            contract!.onLoadGetAllEventSuccess(GetAllEventModel.fromJson(data));
            return;
          }else if (data['status'] > 500 && data['status'] < 600) {
            contract!.onLoadGetAllEventConnection(serverApiError);
            return;
          }else{
            contract!.onLoadGetAllEventError(CommonMessageModel.fromJson(data));
          }
        }
        else {
          contract!.onLoadGetAllEventConnection(pleaseCheckInternetConnection);
        }
      }
      catch(e) {
        contract!.onLoadGetAllEventConnection(somethingWrongString);
      }
    });
  }
}