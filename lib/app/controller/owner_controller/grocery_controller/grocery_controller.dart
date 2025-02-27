import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:tidybayte/app/core/dependency/path.dart';
import 'package:tidybayte/app/data/model/owner_model/grocery_model/grocery_model.dart';
import 'package:tidybayte/app/data/service/api_check.dart';
import 'package:tidybayte/app/data/service/api_client.dart';
import 'package:tidybayte/app/data/service/api_url.dart';
import 'package:tidybayte/app/utils/ToastMsg/toast_message.dart';
import 'package:tidybayte/app/utils/app_const/app_const.dart';

class GroceryController extends GetxController {
  ApiClient apiClient = serviceLocator();

  void setRxRequestStatus(Status value) => rxRequestStatus.value = value;
  final rxRequestStatus = Status.loading.obs;
  final groceryNameController = TextEditingController();
  final startDateController = TextEditingController();
  final startTimeController = TextEditingController();
  final endDateController = TextEditingController();
  final endTimeController = TextEditingController();




  clearGroceryField() {
    groceryNameController.clear();
    startDateController.clear();
    startTimeController.clear();
    endTimeController.clear();
    endDateController.clear();
  }

  ///==================================✅✅addGrocery Method✅✅=======================

  RxBool isAddGroceryLoading = false.obs;

  addGrocery() async {
    isAddGroceryLoading.value = true;
    var body = {
      "assignedTo": "67a5dcd0da89b5111daff368",
      "groceryName": groceryNameController.text,
      "startDateStr": startDateController.text,
      "startTimeStr": startTimeController.text,
      "endDateStr": endDateController.text,
      "endTimeStr": endTimeController.text,
    };

    var response = await apiClient.post(body: body, url: ApiUrl.addGrocery);
    if (response.statusCode == 200) {
      clearGroceryField();
      toastMessage(message: response.body["message"]);
      Get.back();
    } else if (response.statusCode == 400) {
      toastMessage(message: response.body["message"]);
    } else {
      ApiChecker.checkApi(response);
    }
    isAddGroceryLoading.value = false;
    isAddGroceryLoading.refresh();
  }

  ///==================================✅✅remove Grocery✅✅=======================

  RxBool isRemoveGrocery = false.obs;

  removeGrocery() async {
    isRemoveGrocery.value = true;
    var body = {"groceryId": "67b4092eb14e12970ad4fa6e"};

    var response =
        await apiClient.delete(body: body, url: ApiUrl.groceryDelete);
    if (response.statusCode == 200) {
      toastMessage(message: response.body["message"]);
      Get.back();
    } else if (response.statusCode == 400) {
      toastMessage(message: response.body["message"]);
    } else {
      ApiChecker.checkApi(response);
    }
    isRemoveGrocery.value = false;
    isRemoveGrocery.refresh();
  }

  ///==================================✅✅getMyGrocery✅✅=======================
  Rx<GroceryData> groceryData = GroceryData().obs;
  RxInt selectedTabIndex = 0.obs;
  RxBool isLoading = false.obs;
  var selectedDayIndex = 0.obs;
  Future<void> getMyGrocery({required String apiUrl}) async {
    isLoading.value = true;
    setRxRequestStatus(Status.loading);
    refresh();
    try {
      final response = await apiClient.get(url: apiUrl, showResult: true);

      if (response.statusCode == 200) {
        groceryData.value = GroceryData.fromJson(response.body["data"]);

        print('StatusCode==================${response.statusCode}');
        print('groceryData Result==================${groceryData.value.result?.length}');

        setRxRequestStatus(Status.completed);
        refresh();
      } else {
        setRxRequestStatus(Status.error);
        ApiChecker.checkApi(response);
      }
    } catch (e) {
      setRxRequestStatus(Status.error);
      print('Error fetching data: $e');
    } finally {
      isLoading.value = false;
    }
  }


}
