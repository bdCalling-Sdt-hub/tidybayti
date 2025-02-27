import 'package:get/get.dart';
import 'package:tidybayte/app/core/dependency/path.dart';
import 'package:tidybayte/app/data/model/owner_model/grocery_model/grocery_model.dart';
import 'package:tidybayte/app/data/service/api_check.dart';
import 'package:tidybayte/app/data/service/api_client.dart';
import 'package:tidybayte/app/data/service/api_url.dart';
import 'package:tidybayte/app/utils/ToastMsg/toast_message.dart';
import 'package:tidybayte/app/utils/app_const/app_const.dart';

class EmployeeGroceryController extends GetxController {
  void setRxRequestStatus(Status value) => rxRequestStatus.value = value;
  final rxRequestStatus = Status.loading.obs;
  ApiClient apiClient = serviceLocator();
  RxBool isLoading = false.obs;

  ///==================================✅✅Get All Task✅✅=======================
  Rx<GroceryData> pendingTask = GroceryData().obs;

  Future<void> getPending() async {
    setRxRequestStatus(Status.loading);

    try {
      final response = await apiClient.get(
          url: ApiUrl.employeeGroceryPending, showResult: true);

      if (response.statusCode == 200 && response.body["data"] != null) {
        pendingTask.value = GroceryData.fromJson(response.body["data"]);

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

  ///==================================✅✅ongoing✅✅=======================
  Rx<GroceryData> ongoingTask = GroceryData().obs;

  Future<void> getOngoing() async {
    setRxRequestStatus(Status.loading);

    try {
      final response =
          await apiClient.get(url: ApiUrl.getGroceryOngoing, showResult: true);

      if (response.statusCode == 200 && response.body["data"] != null) {
        ongoingTask.value = GroceryData.fromJson(response.body["data"]);

        print('✅ Status Code: ${response.statusCode}');
        print(' ongoingTask Count: ${ongoingTask.value.result?.length ?? 0}');

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

  ///==================================✅✅complete✅✅=======================
  Rx<GroceryData> completeTask = GroceryData().obs;

  Future<void> getComplete() async {
    setRxRequestStatus(Status.loading);

    try {
      final response =
          await apiClient.get(url: ApiUrl.groceryComplete, showResult: true);

      if (response.statusCode == 200 && response.body["data"] != null) {
        completeTask.value = GroceryData.fromJson(response.body["data"]);

        print('✅ Status Code: ${response.statusCode}');
        print(' completeTask Count: ${completeTask.value.result?.length ?? 0}');

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

  // ///==================================✅✅PendingTask✅✅=======================
  RxBool isPendingTask = false.obs;
  RxString pendingTaskId = "".obs;

  employeePendingTask(
      {required String groceryId, required String status}) async {
    isPendingTask.value = true;
    pendingTaskId.value = groceryId;

    var body = {"groceryId": groceryId, "status": status};

    try {
      var response =
          await apiClient.patch(body: body, url: ApiUrl.updateStatus);

      if (response.statusCode == 200) {
       await getPending();
       await  getOngoing();
        print(response.body);
        toastMessage(message: response.body["message"]);
      } else if (response.statusCode == 400) {
        toastMessage(message: response.body["message"]);
      } else {
        ApiChecker.checkApi(response);
      }
    } catch (e) {
      print("❌ Error updating task status: $e");
    } finally {
      isPendingTask.value = false;
      pendingTaskId.value = groceryId;
    }
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }
}
