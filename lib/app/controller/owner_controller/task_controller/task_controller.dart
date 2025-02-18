import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:tidybayte/app/core/dependency/path.dart';
import 'package:tidybayte/app/data/model/owner_model/all_room_model.dart';
import 'package:tidybayte/app/data/model/owner_model/task_model.dart';
import 'package:tidybayte/app/data/service/api_check.dart';
import 'package:tidybayte/app/data/service/api_client.dart';
import 'package:tidybayte/app/data/service/api_url.dart';
import 'package:tidybayte/app/utils/ToastMsg/toast_message.dart';
import 'package:tidybayte/app/utils/app_const/app_const.dart';

class TaskController extends GetxController {
  ApiClient apiClient = serviceLocator();
  // DBHelper dbHelper = serviceLocator();
  final taskTitleController = TextEditingController();
  final startDateController = TextEditingController();
  final startTimeController = TextEditingController();
  final endDateController = TextEditingController();
  final endTimeController = TextEditingController();
  final taskDetailsController = TextEditingController();
  final additionalController = TextEditingController();
  final recurrenceController = TextEditingController();
  late String assignedId = "";
  late String roomId = "";

  void setRxRequestStatus(Status value) => rxRequestStatus.value = value;
  final rxRequestStatus = Status.loading.obs;
  clearField() {
    taskTitleController.clear();
    startDateController.clear();
    startTimeController.clear();
    endTimeController.clear();
    endDateController.clear();
    taskDetailsController.clear();
    additionalController.clear();
  }


  ///==================================✅✅Forget Method✅✅=======================

  RxBool isTaskLoading = false.obs;

  addTask() async {
    isTaskLoading.value = true;
    var body = {
      "assignedTo": assignedId,
      "roomId": roomId,
      "taskName": taskTitleController.text,
      "recurrence": recurrenceController.text,
      "startDateStr": startDateController.text,
      "startTimeStr":startTimeController.text,
      "endDateStr": endDateController.text,
      "endTimeStr": endTimeController.text,
      "taskDetails":taskDetailsController.text,
      "additionalMessage": additionalController.text
    };

    var response = await apiClient.post(body: body,
        url: ApiUrl.addTask);
    if (response.statusCode == 200) {
      clearField();
      toastMessage(message: response.body["message"]);
      Get.back();
    } else if (response.statusCode == 400) {
      toastMessage(message: response.body["message"]);
    } else {
      ApiChecker.checkApi(response);
    }
    isTaskLoading.value = false;
    isTaskLoading.refresh();
  }


  var selectedDayIndex = Rxn<int>();


  ///==================================✅✅Get All Room✅✅=======================

  Rx<RoomList> roomModel = RoomList().obs;
  getAllRoom() async {
    setRxRequestStatus(Status.loading);
    refresh();
    try {
      final response =
      await apiClient.get(url: ApiUrl.allRoom, showResult: true);

      if (response.statusCode == 200) {
        roomModel.value = RoomList.fromJson(response.body["data"]);

        print('StatusCode==================${response.statusCode}');
        print(
            'Room Result==================${roomModel.value.rooms?.length}');
        setRxRequestStatus(Status.completed);
        refresh();
      } else {
        setRxRequestStatus(Status.error);
        ApiChecker.checkApi(response);
      }
    } catch (e) {
      setRxRequestStatus(Status.error);
    }
  }



  //ALl task
  final List<String> dayName = [
    'Completed Tasks',
    'Ongoing Tasks',
    'Pending Tasks',
  ];

  ///==================================✅✅Get All Task✅✅=======================

  Rx<TaskData> taskData = TaskData().obs;

  Future<void> getTaskData({required String apiUrl}) async {
    setRxRequestStatus(Status.loading);
    refresh();

    try {
      final response = await apiClient.get(url: apiUrl, showResult: true);

      if (response.statusCode == 200) {
        taskData.value = TaskData.fromJson(response.body["data"]);

        print('StatusCode==================${response.statusCode}');
        print('taskData Result==================${taskData.value.result?.length}');

        setRxRequestStatus(Status.completed);
        refresh();
      } else {
        setRxRequestStatus(Status.error);
        ApiChecker.checkApi(response);
      }
    } catch (e) {
      setRxRequestStatus(Status.error);
      print('Error fetching data: $e');
    }
  }






  @override
  void onInit() {
    getAllRoom();
    super.onInit();
  }
}
