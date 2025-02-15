import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tidybayte/app/core/app_routes/app_routes.dart';
import 'package:tidybayte/app/core/dependency/path.dart';
import 'package:tidybayte/app/data/model/owner_model/employee_model.dart';
import 'package:tidybayte/app/data/model/owner_model/single_employee_model.dart';
import 'package:tidybayte/app/data/service/api_check.dart';
import 'package:tidybayte/app/data/service/api_client.dart';
import 'package:tidybayte/app/data/service/api_url.dart';
import 'package:tidybayte/app/global/helper/local_db/local_db.dart';
import 'package:tidybayte/app/utils/app_colors/app_colors.dart';
import 'package:tidybayte/app/utils/app_const/app_const.dart';
import 'package:tidybayte/app/utils/app_icons/app_icons.dart';
import 'package:tidybayte/app/utils/app_strings/app_strings.dart';
import 'package:tidybayte/app/view/components/custom_button/custom_button.dart';
import 'package:tidybayte/app/view/components/custom_image/custom_image.dart';
import 'package:tidybayte/app/view/components/custom_text/custom_text.dart';

class AddEmployeeController extends GetxController {
  ApiClient apiClient = serviceLocator();
  DBHelper dbHelper = serviceLocator();
  RxString image = "".obs;
  final RxBool isCprOpen = false.obs;
  final RxBool isPassportOpen = false.obs;
  final RxString selectedJobType = ''.obs;
  var isLoading = false.obs;

  void setLoading(bool value) {
    isLoading.value = value;
  }

  void updateJobType(String jobType) {
    selectedJobType.value = jobType;
    jobTypeController.text = jobType;
    debugPrint("Selected Job Type: =======================$jobType");
  }

  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final jobTypeController = TextEditingController();
  final cprNumberController = TextEditingController();
  final cprExpireDateController = TextEditingController();
  final passportController = TextEditingController();
  final noteController = TextEditingController();
  final passportExpireDateController = TextEditingController();
  void setRxRequestStatus(Status value) => rxRequestStatus.value = value;
  final rxRequestStatus = Status.loading.obs;
  ///==================================✅✅Get Employee✅✅=======================


  Rx<EmployeeData> employeeData = EmployeeData().obs;

  getEmployee() async {
    setRxRequestStatus(Status.loading);
    refresh();
    try {
      final response =
          await apiClient.get(url: ApiUrl.getEmployee, showResult: true);

      if (response.statusCode == 200) {
        employeeData.value = EmployeeData.fromJson(response.body["data"]);

        print('StatusCode==================${response.statusCode}');
        print(
            'Employee Result==================${employeeData.value.result?.length}');
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

  ///==================================✅✅Get Single Employee✅✅=======================

  Rx<SingleEmployeeData> singleEmployeeData = SingleEmployeeData().obs;

  getSingleEmployee({required String employeeId}) async {
    setRxRequestStatus(Status.loading);
    refresh();
    try {
      final response = await apiClient.get(
          url: ApiUrl.singleEmployee(employeeId), showResult: true);

      if (response.statusCode == 200) {
        singleEmployeeData.value =
            SingleEmployeeData.fromJson(response.body["data"]);

        print('StatusCode==================${response.statusCode}');
        print(
            'Employee Result==================${singleEmployeeData.value.employeeId}');
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
  ///==================================✅✅sendEmail✅✅=======================
  void sendEmail(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false, // Prevent dismissing by tapping outside
      builder: (BuildContext context) {
        return AlertDialog(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
                Radius.circular(5.0)), // Adjust the radius as needed
          ),
          backgroundColor: AppColors.addedColor,
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                height: 16.h,
              ),
              Container(
                height: 96,
                width: 96,
                decoration: const BoxDecoration(
                  color: AppColors.blue900,
                  shape: BoxShape.circle,
                ),
                child: const Center(
                    child: CustomImage(
                  imageSrc: AppIcons.rightUp,
                )),
              ),
              CustomText(
                top: 24,
                bottom: 40,
                maxLines: 2,
                text: AppStrings.employeeAddedSu.tr,
                fontWeight: FontWeight.w400,
                fontSize: 24,
                color: AppColors.successFullyColor,
              ),
              CustomText(
                maxLines: 5,
                text: AppStrings.emplyeesAccountDetails.tr,
                fontWeight: FontWeight.w500,
                fontSize: 16,
                color: AppColors.dark400,
              ),
              const CustomText(
                maxLines: 2,
                bottom: 20,
                text: ' diannerussell@gmail.com',
                fontWeight: FontWeight.w700,
                fontSize: 16,
                color: AppColors.dark400,
              ),
              Row(
                children: [
                  CustomText(
                    maxLines: 2,
                    text: "${AppStrings.temporaryPassword}:".tr,
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                    color: AppColors.dark400,
                  ),
                  const CustomText(
                    maxLines: 2,
                    text: ' Masum017@@@',
                    fontWeight: FontWeight.w700,
                    fontSize: 12,
                    color: AppColors.dark400,
                  ),
                ],
              ),
              SizedBox(
                height: 48.h,
              ),

              ///==============================Send Email==================

              CustomButton(
                title: AppStrings.sendEmail.tr,
                onTap: () {
                  Get.toNamed(AppRoutes.mainSentSuccessfullyScreen);
                },
                fillColor: Colors.white,
              ),
              SizedBox(
                height: 15.h,
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  void onInit() {
    getEmployee();
    super.onInit();
  }
}
