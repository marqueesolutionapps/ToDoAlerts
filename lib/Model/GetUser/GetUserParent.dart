// ignore_for_file: file_names

part of '../ModelLibrary.dart';

class GetUserParent  {
  GetUserDataController? contract;

  GetUserParent(this.contract);
  void loadData() {
    InternetChecker.checkInternet().then((value) async {
      try {
        if(value) {
          var request = http.MultipartRequest('POST', Uri.parse(getUserAPI),);
          request.fields.addAll({
            'device_id': SPUtil.getDeviceId(),
          });
          var streamResponse = await request.send();
          final response = await http.Response.fromStream(streamResponse);
          // Util.consoleLog("response.body Get User ${response.body}");
          var data;
          if(response.body!="") {
            data= json.decode(response.body);
          }
          if(data['status'] == 200){
            contract!.onLoadGetUserSuccess(GetUserModel.fromJson(data));
            return;
          }else if (data['status'] > 500 && data['status'] < 600) {
            contract!.onLoadGetUserConnection(serverApiError);
            return;
          }else{
            contract!.onLoadGetUserError(CommonMessageModel.fromJson(data));
          }
        }
        else {
          contract!.onLoadGetUserConnection(pleaseCheckInternetConnection);
        }
      }
      catch(e) {
        contract!.onLoadGetUserConnection(somethingWrongString);
      }
    });
  }
}