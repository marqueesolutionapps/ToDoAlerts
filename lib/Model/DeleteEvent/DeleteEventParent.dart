// ignore_for_file: file_names

part of '../ModelLibrary.dart';

class DeleteEventParent  {
  DeleteEventDataController? contract;

  DeleteEventParent(this.contract);
  void loadData(String eventId) {
    InternetChecker.checkInternet().then((value) async {
      try {
        if(value) {
          var request = http.MultipartRequest('POST', Uri.parse(deleteEventAPI),);
          request.fields.addAll({
            'id': eventId,
            'user_id': SPUtil.getUserId(),
            'device_id': SPUtil.getDeviceId(),
          });
          var streamResponse = await request.send();
          final response = await http.Response.fromStream(streamResponse);
          // Util.consoleLog("response.body Delete Event ${response.body}");
          var data;
          if(response.body!="") {
            data= json.decode(response.body);
          }
          if(data['status'] == 200){
            contract!.onLoadDeleteEventSuccess(DeleteEventModel.fromJson(data));
            return;
          }else if (data['status'] > 500 && data['status'] < 600) {
            contract!.onLoadDeleteEventConnection(serverApiError);
            return;
          }else{
            contract!.onLoadDeleteEventError(CommonMessageModel.fromJson(data));
          }
        }
        else {
          contract!.onLoadDeleteEventConnection(pleaseCheckInternetConnection);
        }
      }
      catch(e) {
        contract!.onLoadDeleteEventConnection(somethingWrongString);
      }
    });
  }
}