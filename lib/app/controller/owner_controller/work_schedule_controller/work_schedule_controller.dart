import 'package:get/get.dart';
import 'package:tidybayte/app/core/dependency/path.dart';
import 'package:tidybayte/app/data/model/owner_model/work_schedule/user_task_model.dart';
import 'package:tidybayte/app/data/service/api_check.dart';
import 'package:tidybayte/app/data/service/api_client.dart';
import 'package:tidybayte/app/data/service/api_url.dart';
import 'package:tidybayte/app/utils/app_const/app_const.dart';

class WorkScheduleController extends GetxController {
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

  Rx<UserTaskData> userTaskData = UserTaskData().obs;

  Future<void> getUserTask({required String dayName}) async {
    setRxRequestStatus(Status.loading);
    refresh();

    try {
      final response = await apiClient.get(
          url: ApiUrl.userDayOfTask(dayName), showResult: true);

      if (response.statusCode == 200) {
        userTaskData.value = UserTaskData.fromJson(response.body["data"]);

        print('StatusCode==================${response.statusCode}');
        print(
            'userTaskData Result==================${userTaskData.value.result?.length}');

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


}
