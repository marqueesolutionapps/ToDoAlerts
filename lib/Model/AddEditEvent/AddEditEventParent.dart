// ignore_for_file: file_names

part of '../ModelLibrary.dart';

class AddEditEventParent  {
  AddEditEventDataController? contract;

  AddEditEventParent(this.contract);
  void loadData(String id, String eventName, String eventNote, String eventDate, String eventStartTime, String eventEndTime, String utcDateTime, bool isRemindMe, String categoryID) {
    InternetChecker.checkInternet().then((value) async {
      try {
        if(value) {
          var request = http.MultipartRequest('POST', Uri.parse(addEditEventAPI),);
          request.fields.addAll({
            'device_id': SPUtil.getDeviceId(),
            'id': id,
            'user_id': SPUtil.getUserId(),
            'event_name': eventName,
            'note': eventNote,
            'date': eventDate,
            'start_time': eventStartTime,
            'end_time': eventEndTime,
            'utc_time': utcDateTime,
            'remind_me': isRemindMe == true ? "1" : "0",
            'category_id': categoryID,
          });
          var streamResponse = await request.send();
          final response = await http.Response.fromStream(streamResponse);
          Util.consoleLog("response.body Add Edit Event ${response.body}");
          var data;
          if(response.body!="") {
            data= json.decode(response.body);
          }
          if(data['status'] == 200){
            contract!.onLoadAddEditEventSuccess(AddEditEventModel.fromJson(data));
            return;
          }else if (data['status'] > 500 && data['status'] < 600) {
            contract!.onLoadAddEditEventConnection(serverApiError);
            return;
          }else{
            contract!.onLoadAddEditEventError(CommonMessageModel.fromJson(data));
          }
        }
        else {
          contract!.onLoadAddEditEventConnection(pleaseCheckInternetConnection);
        }
      }
      catch(e) {
        contract!.onLoadAddEditEventConnection(somethingWrongString);
      }
    });
  }
}