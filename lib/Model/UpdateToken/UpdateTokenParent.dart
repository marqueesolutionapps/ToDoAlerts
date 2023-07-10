// ignore_for_file: file_names

part of '../ModelLibrary.dart';

class UpdateTokenParent  {
  UpdateTokenDataController? contract;

  UpdateTokenParent(this.contract);
  void loadData() {
    InternetChecker.checkInternet().then((value) async {
      try {
        if(value) {
          var request = http.MultipartRequest('POST', Uri.parse(updateTokenAPI),);
          request.fields.addAll({
            'token': SPUtil.getToken(),
            'device_id': SPUtil.getDeviceId(),
            'user_id': SPUtil.getUserId(),
          });
          var streamResponse = await request.send();
          final response = await http.Response.fromStream(streamResponse);
          Util.consoleLog("response.body Update Token ${response.body}");
          var data;
          if(response.body!="") {
            data= json.decode(response.body);
          }
          if(data['status'] == 200){
            contract!.onLoadUpdateTokenSuccess(UpdateTokenModel.fromJson(data));
            return;
          }else if (data['status'] > 500 && data['status'] < 600) {
            contract!.onLoadUpdateTokenConnection(serverApiError);
            return;
          }else{
            contract!.onLoadUpdateTokenError(CommonMessageModel.fromJson(data));
          }
        }
        else {
          contract!.onLoadUpdateTokenConnection(pleaseCheckInternetConnection);
        }
      }
      catch(e) {
        contract!.onLoadUpdateTokenConnection(somethingWrongString);
      }
    });
  }
}