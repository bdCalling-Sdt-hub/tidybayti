import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:tidybayte/app/core/dependency/path.dart';
import 'package:tidybayte/app/data/service/api_check.dart';
import 'package:tidybayte/app/data/service/api_client.dart';
import 'package:tidybayte/app/data/service/api_url.dart';
import 'package:tidybayte/app/utils/ToastMsg/toast_message.dart';

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
      "assignedTo": "67b0120aafe2f88c3a6f142e",
      "roomId": "67b3014a33e1f91f895dad60",
      "taskName": "Desk Cleaning",
      "recurrence": "weekly",
      "startDateStr": "09/16/2024",
      "startTimeStr": "1:30 AM",
      "endDateStr": "09/16/2024",
      "endTimeStr": "01:50 AM",
      "taskDetails": "Vacuum and mop the living room and bedrooms.",
      "additionalMessage": "Use the new cleaning supplies under the sink."
    };

    var response = await apiClient.post(body: body,
        url: ApiUrl.addTask);
    if (response.statusCode == 200) {
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


  var selectedDayIndex = Rxn<int>(); // Nullable RxInt

  final List<String> dayName = [
    'Completed Tasks',
    'Ongoing Tasks',
    'Pending Tasks',
  ];

  final List<Map<String, String>> allTasks = [
    {"taskName": "Clean Car", "assignedTo": "Annette Black", "time": "10 Aug, 2024", "status": "Completed"},
    {"taskName": "Wash Dishes", "assignedTo": "John Doe", "time": "11 Aug, 2024", "status": "Ongoing"},
    {"taskName": "Mop Floor", "assignedTo": "Alice Smith", "time": "12 Aug, 2024", "status": "Pending"},
    {"taskName": "Laundry", "assignedTo": "Robert Brown", "time": "13 Aug, 2024", "status": "Completed"},
    {"taskName": "Grocery Shopping", "assignedTo": "Emily Johnson", "time": "14 Aug, 2024", "status": "Ongoing"},
    {"taskName": "Cook Dinner", "assignedTo": "David Wilson", "time": "15 Aug, 2024", "status": "Pending"},
  ];

  List<Map<String, String>> get filteredTasks {
    if (selectedDayIndex.value == null) {
      return [];
    }
    String statusFilter = dayName[selectedDayIndex.value!].split(" ")[0]; // "Completed" / "Ongoing" / "Pending"
    return allTasks.where((task) => task["status"] == statusFilter).toList();
  }

}
