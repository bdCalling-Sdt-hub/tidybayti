import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tidybayte/app/controller/owner_controller/add_employee_controller/add_employee_controller.dart';
import 'package:tidybayte/app/core/app_routes/app_routes.dart';
import 'package:tidybayte/app/data/service/api_url.dart';
import 'package:tidybayte/app/global/helper/GenerelError/general_error.dart';
import 'package:tidybayte/app/utils/app_colors/app_colors.dart';
import 'package:tidybayte/app/utils/app_const/app_const.dart';
import 'package:tidybayte/app/utils/app_strings/app_strings.dart';
import 'package:tidybayte/app/view/components/custom_loader/custom_loader.dart';

import 'package:tidybayte/app/view/components/custom_menu_appbar/custom_menu_appbar.dart';
import 'package:tidybayte/app/view/components/custom_netwrok_image/custom_network_image.dart';
import 'package:tidybayte/app/view/components/custom_profile_item/custom_profile_item.dart';
import 'package:tidybayte/app/view/components/custom_text/custom_text.dart';
import 'package:tidybayte/app/view/components/no_internet_screen/no_internet_screen.dart';

class EmployeeDetails extends StatefulWidget {
  EmployeeDetails({super.key});

  @override
  State<EmployeeDetails> createState() => _EmployeeDetailsState();
}

class _EmployeeDetailsState extends State<EmployeeDetails> {
  final AddEmployeeController employeeController =
      Get.find<AddEmployeeController>();

  final String employeeId = Get.arguments[0];

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await employeeController.getSingleEmployee(
          employeeId: employeeId.toString());
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print("EmployeeId===========================$employeeId");

    var data = employeeController.singleEmployeeData.value;
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xCCE8F3FA), // First color (with opacity)
              Color(0xFFB5D8EE),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              // crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ///==================================✅✅employeeDetails Appbar✅✅=======================

                CustomMenuAppbar(
                  onTap: () {
                    Get.toNamed(AppRoutes.editEmployeeDetails);
                  },
                  isEdit: true,
                  title: AppStrings.employeeDetails.tr,
                  onBack: () {
                    Get.back();
                  },
                ),

                ///==========================Body Here=====================

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 21),
                  child: Container(
                      padding: const EdgeInsets.all(20),
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Color(0xCCE8F3FA), // First color (with opacity)
                            Color(0xCCE8F3FA), // First color (with opacity)
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                      ),
                      child: Obx(() {
                        if (employeeController.rxRequestStatus.value ==
                                Status.loading) {
                          return const CustomLoader();
                        }

                        if (employeeController.rxRequestStatus.value ==
                            Status.internetError) {
                          return NoInternetScreen(onTap: () {
                            employeeController.getSingleEmployee(
                                employeeId: employeeId.toString());
                          });
                        }

                        if (employeeController.rxRequestStatus.value ==
                            Status.error) {
                          return GeneralErrorScreen(onTap: () {
                            employeeController.getSingleEmployee(
                                employeeId: employeeId.toString());
                          });
                        }

                        var data = employeeController.singleEmployeeData.value;

                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Center(
                              child: CustomNetworkImage(
                                  boxShape: BoxShape.circle,
                                  imageUrl:
                                      "${ApiUrl.networkUrl}${data.profileImage}",
                                  height: 128,
                                  width: 128),
                            ),

                            SizedBox(
                              height: 25.h,
                            ),
                            Row(
                              children: [
                                CustomText(
                                  textAlign: TextAlign.start,
                                  top: 10,
                                  text: "${AppStrings.firstName}: ".tr,
                                  color: AppColors.dark400,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 20,
                                ),
                                Expanded(
                                  child: CustomText(
                                    textAlign: TextAlign.start,
                                    top: 10,
                                    text: data.firstName ?? "",
                                    color: AppColors.dark400,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 20,
                                  ),
                                ),
                              ],
                            ),

                            ///============================Last Name=====================
                            CustomProfileItem(
                              title: "${AppStrings.lastName} :".tr,
                              subTitle: data.lastName ?? "",
                            ),

                            ///================================id========================
                            CustomProfileItem(
                              title: AppStrings.id.tr,
                              subTitle: data.id ?? "",
                            ),

                            ///================================Email========================
                            CustomProfileItem(
                              title: '${AppStrings.email.tr}:',
                              subTitle: data.email ?? "",
                            ),

                            ///================================Contact No========================
                            CustomProfileItem(
                              title: "${AppStrings.contactNumber.tr}:",
                              subTitle: data.phoneNumber ?? "",
                            ),

                            ///================================CPR========================
                            CustomProfileItem(
                              title: '${AppStrings.cPR.tr}:',
                              subTitle: data.cprNumber ?? "",
                            ),

                            ///================================Passport:  ========================
                            CustomProfileItem(
                              title: '${AppStrings.passport.tr}:',
                              subTitle: data.passportNumber ?? "",
                            ),

                            ///================================note  ========================
                            CustomProfileItem(
                              title: "${AppStrings.note.tr} :",
                              subTitle: data.note ?? "",
                            ),

                            ///================================jobType  ========================
                            CustomProfileItem(
                              title: '${AppStrings.jobType.tr}:',
                              subTitle: data.jobType ?? "",
                            ),

                            ///================================dutyTime  ========================
                            CustomProfileItem(
                              title: AppStrings.dutyTime.tr,
                              subTitle: data.dutyTime ?? "",
                            ),

                            ///================================workingDay  ========================
                            CustomProfileItem(
                              title: AppStrings.workingDay.tr,
                              subTitle:
                                  (data.workingDay ?? []).join(', ').isEmpty
                                      ? "No working days available"
                                      : (data.workingDay ?? []).join(', '),
                            ),

                            ///================================offDay  ========================
                            CustomProfileItem(
                              title: AppStrings.offDay.tr,
                              subTitle: data.offDay ?? "",
                            ),

                            SizedBox(
                              height: 20.h,
                            ),
                          ],
                        );
                      })),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
