// ignore_for_file: file_names

part of '../ModelLibrary.dart';

class AddEditUserParent  {
  AddEditUserDataController? contract;

  AddEditUserParent(this.contract);
  void loadData(String id, String name, String email, String phone) {
    InternetChecker.checkInternet().then((value) async {
      try {
        if(value) {
          var request = http.MultipartRequest('POST', Uri.parse(addEditUserAPI),);
          request.fields.addAll({
            'device_id': SPUtil.getDeviceId(),
            'id': id,
            'username': name,
            'email': email,
            'phone_no': phone,
            'token': SPUtil.getToken(),
          });
          var streamResponse = await request.send();
          final response = await http.Response.fromStream(streamResponse);
          // Util.consoleLog("response.body Add Edit User ${response.body}");
          var data;
          if(response.body!="") {
            data= json.decode(response.body);
          }
          if(data['status'] == 200){
            contract!.onLoadAddEditUserSuccess(AddEditUserModel.fromJson(data));
            return;
          }else if (data['status'] > 500 && data['status'] < 600) {
            contract!.onLoadAddEditUserConnection(serverApiError);
            return;
          }else{
            contract!.onLoadAddEditUserError(CommonMessageModel.fromJson(data));
          }
        }
        else {
          contract!.onLoadAddEditUserConnection(pleaseCheckInternetConnection);
        }
      }
      catch(e) {
        contract!.onLoadAddEditUserConnection(somethingWrongString);
      }
    });
  }
}