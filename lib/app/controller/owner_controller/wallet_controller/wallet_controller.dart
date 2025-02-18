import 'package:get/get.dart';
import 'package:tidybayte/app/core/dependency/path.dart';
import 'package:tidybayte/app/data/model/owner_model/budget_model.dart';
import 'package:tidybayte/app/data/service/api_check.dart';
import 'package:tidybayte/app/data/service/api_client.dart';
import 'package:tidybayte/app/data/service/api_url.dart';
import 'package:tidybayte/app/utils/app_const/app_const.dart';

class WalletController extends GetxController{
  ApiClient apiClient = serviceLocator();

  void setRxRequestStatus(Status value) => rxRequestStatus.value = value;
  final rxRequestStatus = Status.loading.obs;
  //Budget Crate Loader
  var isLoading = false.obs;

  void setLoading(bool value) {
    isLoading.value = value;
  }

  ///==================================✅✅Budget Get✅✅=======================

  Rx<BudgetData> budgetData = BudgetData().obs;

  getBudget() async {
    setRxRequestStatus(Status.loading);
    refresh();

    try {
      final response = await apiClient.get(url: ApiUrl.getMyBudget, showResult: true);

      if (response.statusCode == 200) {
        budgetData.value = BudgetData.fromJson(response.body["data"]);

        print('StatusCode==================${response.statusCode}');
        print(
            'budgetData Result==================${budgetData.value.result?.length}');

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
    getBudget();
    super.onInit();
  }

}