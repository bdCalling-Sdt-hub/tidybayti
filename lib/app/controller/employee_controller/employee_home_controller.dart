import 'package:get/get.dart';
import 'package:tidybayte/app/core/dependency/path.dart';
import 'package:tidybayte/app/data/model/owner_model/work_schedule/user_task_model.dart';
import 'package:tidybayte/app/data/service/api_check.dart';
import 'package:tidybayte/app/data/service/api_client.dart';
import 'package:tidybayte/app/data/service/api_url.dart';
import 'package:tidybayte/app/utils/ToastMsg/toast_message.dart';
import 'package:tidybayte/app/utils/app_const/app_const.dart';

class EmployeeHomeController extends GetxController {
  void setRxRequestStatus(Status value) => rxRequestStatus.value = value;
  final rxRequestStatus = Status.loading.obs;
  ApiClient apiClient = serviceLocator();

  var selectedDayIndex = 0.obs;
  List<String> dayName = [
    'All',
    'Sunday',
    "Monday",
    "Tuesday",
    "Wednesday",
    "Thursday",
    'Friday',
    'Saturday'
  ];

  ///==================================✅✅Get All Task✅✅=======================
  RxBool isLoading = false.obs;

  Rx<UserTaskData> userTaskData = UserTaskData().obs;

  Future<void> getEmployeeAllTask({required String dayName}) async {
    setRxRequestStatus(Status.loading);

    try {
      String apiUrl = dayName == "All"
          ? ApiUrl.employeeAllTask
          : ApiUrl.employeeDateAllTask(dayName);

      print("Fetching tasks from: $apiUrl");

      final response = await apiClient.get(url: apiUrl, showResult: true);

      if (response.statusCode == 200 && response.body["data"] != null) {
        userTaskData.value = UserTaskData.fromJson(response.body["data"]);

        print('✅ Status Code: ${response.statusCode}');
        print('✅ Task Count: ${userTaskData.value.result?.length ?? 0}');

        setRxRequestStatus(Status.completed);
      } else {
        print("⚠️ Error: Unexpected API Response");
        setRxRequestStatus(Status.error);
        ApiChecker.checkApi(response);
      }
    } catch (e) {
      setRxRequestStatus(Status.error);
      print('❌ Error fetching data: $e');
    }
  }

  ///==================================✅✅getPending✅✅=======================

  Rx<UserTaskData> pendingTask = UserTaskData().obs;

  Future<void> getPending() async {
    setRxRequestStatus(Status.loading);

    try {
      final response =
          await apiClient.get(url: ApiUrl.getEmployeePendingTask, showResult: true);

      if (response.statusCode == 200 && response.body["data"] != null) {
        pendingTask.value = UserTaskData.fromJson(response.body["data"]);

        print('✅ Status Code: ${response.statusCode}');
        print(' pendingTask Count: ${pendingTask.value.result?.length ?? 0}');

        setRxRequestStatus(Status.completed);
      } else {
        print("⚠️ Error: Unexpected API Response");
        setRxRequestStatus(Status.error);
        ApiChecker.checkApi(response);
      }
    } catch (e) {
      setRxRequestStatus(Status.error);
      print('❌ Error fetching data: $e');
    }
  }

  ///==================================✅✅PendingTask✅✅=======================
  RxBool isPendingTask = false.obs;
  RxString pendingTaskId = "".obs; // ✅ Track which task is loading

  Future<void> employeePendingTask({required String taskId, required String status}) async {
    isPendingTask.value = true;
    pendingTaskId.value = taskId; // ✅ Set loading state for the specific task

    var body = {"taskId": taskId, "status": status};

    try {
      var response = await apiClient.patch(body: body, url: ApiUrl.updateStatus);

      if (response.statusCode == 200) {
        print(response.body);
        toastMessage(message: response.body["message"]);
        await getPending(); // ✅ Refresh Pending Task List After Updating
      } else if (response.statusCode == 400) {
        toastMessage(message: response.body["message"]);
      } else {
        ApiChecker.checkApi(response);
      }
    } catch (e) {
      print("❌ Error updating task status: $e");
    } finally {
      isPendingTask.value = false;
      pendingTaskId.value = ""; // ✅ Reset loading state
    }
  }

  @override
  void onInit() {
    getPending();
    super.onInit();
  }
}
