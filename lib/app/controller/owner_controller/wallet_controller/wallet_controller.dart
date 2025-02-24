import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:tidybayte/app/core/dependency/path.dart';
import 'package:tidybayte/app/data/model/owner_model/budget_category.dart';
import 'package:tidybayte/app/data/model/owner_model/budget_details.dart';
import 'package:tidybayte/app/data/model/owner_model/budget_model.dart';
import 'package:tidybayte/app/data/service/api_check.dart';
import 'package:tidybayte/app/data/service/api_client.dart';
import 'package:tidybayte/app/data/service/api_url.dart';
import 'package:tidybayte/app/utils/ToastMsg/toast_message.dart';
import 'package:tidybayte/app/utils/app_const/app_const.dart';

class WalletController extends GetxController {
  ApiClient apiClient = serviceLocator();

  void setRxRequestStatus(Status value) => rxRequestStatus.value = value;
  final rxRequestStatus = Status.loading.obs;

  RxString selectedCurrency = 'BHD'.obs; // Default Currency
  RxBool isSelected = false.obs;

  clearField() {
    categoryNameController.clear();
    dateController.clear();
    currencyController.clear();
    amountController.clear();
  }

  clearExpenseField() {
    expenseDateController.clear();
    expenseAmountController.clear();
  }

  final dateController = TextEditingController();
  final amountController = TextEditingController();
  final currencyController = TextEditingController();
  final categoryNameController = TextEditingController();
  final imageController = TextEditingController();
  final expenseDateController = TextEditingController();
  final expenseAmountController = TextEditingController();
  RxBool isCreateLoading = false.obs;
  RxBool isExpenseLoading = false.obs;

  ///==================================✅✅Budget Create✅✅=======================

  budgetCreate() async {
    isCreateLoading.value = true;
    var body = {
      "category": categoryNameController.text,
      "budgetImage": imageController.text,
      "budgetDateStr": dateController.text,
      "currency": currencyController.text,
      "amount": int.parse(amountController.text)
    };

    var response = await apiClient.post(body: body, url: ApiUrl.budgetCreate);
    if (response.statusCode == 201) {
      clearField();
      toastMessage(message: response.body["message"]);
      Get.back();
    } else if (response.statusCode == 400) {
      toastMessage(message: response.body["message"]);
    } else {
      ApiChecker.checkApi(response);
    }
    isCreateLoading.value = false;
    isCreateLoading.refresh();
  }

  ///==================================✅✅Expense ✅✅=======================

  expenseAdd({required String budgetId}) async {
    isExpenseLoading.value = true;
    var body = {
      "budgetId": budgetId,
      "expenseDateStr": expenseDateController.text,
      "amount": int.parse(expenseAmountController.text)
    };

    var response = await apiClient.post(body: body, url: ApiUrl.expenseCreate);
    if (response.statusCode == 201) {
      clearExpenseField();
      getSingleBudget(budgetId: budgetId);
      toastMessage(message: response.body["message"]);
      Get.back();
    } else if (response.statusCode == 400) {
      toastMessage(message: response.body["message"]);
    } else {
      ApiChecker.checkApi(response);
    }
    isExpenseLoading.value = false;
    isExpenseLoading.refresh();
  }

  ///==================================✅✅getCategoryBudget✅✅=======================

  RxList<CategoryList> budgetCategoryList = <CategoryList>[].obs;

  getCategoryBudget() async {
    setRxRequestStatus(Status.loading);
    refresh();

    try {
      final response =
          await apiClient.get(url: ApiUrl.getCategoryBudget, showResult: true);

      if (response.statusCode == 200) {
        budgetCategoryList.value = List<CategoryList>.from(
            response.body["data"].map((x) => CategoryList.fromJson(x)));
        print('StatusCode==================${response.statusCode}');
        print(
            'Total budgetCategoryList ==================${budgetCategoryList.length}');

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

  ///==================================✅✅Budget Get✅✅=======================

  Rx<BudgetData> budgetData = BudgetData().obs;

  getBudget() async {
    setRxRequestStatus(Status.loading);
    refresh();

    try {
      final response =
          await apiClient.get(url: ApiUrl.getMyBudget, showResult: true);

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

  ///==================================✅✅Budget Single Get✅✅=======================

  Rx<BudgetDetailsData> budgetDetailsData = BudgetDetailsData().obs;

  getSingleBudget({required String budgetId}) async {
    setRxRequestStatus(Status.loading);
    refresh();

    try {
      final response = await apiClient.get(
          url: ApiUrl.getSingleBudget(budgetId), showResult: true);

      if (response.statusCode == 200) {
        budgetDetailsData.value =
            BudgetDetailsData.fromJson(response.body["data"]);

        print('StatusCode==================${response.statusCode}');
        print(
            'budgetData Single==================${budgetDetailsData.value.expenses?.length}');

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

  ///==================================✅✅Remove Expense✅✅=======================
  RxBool isRemoveExpense = false.obs;

  removeExpense({required String expenseId, required String budgetId}) async {
    isRemoveExpense.value = true;
    var body = {
      "expenseId": expenseId
    };

    var response = await apiClient.delete(body: body, url: ApiUrl.deleteExpense);
    if (response.statusCode == 200) {
      getSingleBudget(budgetId: budgetId);
      toastMessage(message: response.body["message"]);
    } else if (response.statusCode == 400) {
      toastMessage(message: response.body["message"]);
    } else {
      ApiChecker.checkApi(response);
    }
    isRemoveExpense.value = false;
    isRemoveExpense.refresh();
  }

  @override
  void onInit() {
    getBudget();
    getCategoryBudget();
    super.onInit();
  }
}
