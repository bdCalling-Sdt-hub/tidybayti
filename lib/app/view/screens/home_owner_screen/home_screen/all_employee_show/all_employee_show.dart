import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tidybayte/app/controller/owner_controller/add_employee_controller/add_employee.dart';
import 'package:tidybayte/app/controller/owner_controller/add_employee_controller/add_employee_controller.dart';
import 'package:tidybayte/app/core/app_routes/app_routes.dart';
import 'package:tidybayte/app/data/service/api_url.dart';
import 'package:tidybayte/app/global/helper/GenerelError/general_error.dart';
import 'package:tidybayte/app/global/helper/global_alart/global_alart.dart';
import 'package:tidybayte/app/utils/app_colors/app_colors.dart';
import 'package:tidybayte/app/utils/app_const/app_const.dart';

import 'package:tidybayte/app/utils/app_strings/app_strings.dart';
import 'package:tidybayte/app/view/components/custom_loader/custom_loader.dart';
import 'package:tidybayte/app/view/components/custom_menu_appbar/custom_menu_appbar.dart';
import 'package:tidybayte/app/view/components/custom_text/custom_text.dart';

import 'package:tidybayte/app/view/components/custom_text_field/custom_text_field.dart';
import 'package:tidybayte/app/view/components/employee_card/custom_employee_card.dart';
import 'package:tidybayte/app/view/components/no_internet_screen/no_internet_screen.dart';

class AllEmployeeShow extends StatelessWidget {
  AllEmployeeShow({super.key});

  final AddEmployeeController employeeController =
      Get.find<AddEmployeeController>();

  @override
  Widget build(BuildContext context) {
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
          child: Column(
            children: [
              ///==================================✅✅employees Appbar✅✅=======================
              CustomMenuAppbar(
                title: AppStrings.employees.tr,
                onBack: () {
                  Get.back();
                },
              ),

              Expanded(
                child: ListView(
                  padding: const EdgeInsets.all(16.0),
                  children: [
                    ///==================================✅✅addNewEmployee Button✅✅=======================
                    CustomTextField(
                      fillColor: AppColors.blue50,
                      readOnly: true,
                      onTap: () {
                        Get.toNamed(AppRoutes.addEmployeeScreen);
                      },
                      hintText: AppStrings.addEmployee.tr,
                      prefixIcon: const Icon(Icons.add),
                    ),

                    const SizedBox(height: 16),
                    // Spacing between text field and list

                    ///==================================✅✅All Employee Card✅✅=======================

                    Obx(() {
                      switch (employeeController.rxRequestStatus.value) {
                        case Status.loading:
                          return const CustomLoader();

                        case Status.internetError:
                          return NoInternetScreen(onTap: () {
                            employeeController.getEmployee();
                          });

                        case Status.error:
                          return GeneralErrorScreen(
                            onTap: () {
                              employeeController.getEmployee();
                            },
                          );

                        case Status.completed:
                          var employeeList =
                              employeeController.employeeData.value.result ??
                                  [];

                          if (employeeList.isEmpty) {
                            return Padding(
                              padding: EdgeInsets.symmetric(vertical: 50.h),
                              child: const CustomText(
                                text: "No Employee Found",
                                fontWeight: FontWeight.w500,
                                color: Colors.black,
                                fontSize: 16,
                              ),
                            );
                          }
                          return Column(
                            children: List.generate(
                                employeeController
                                        .employeeData.value.result?.length ??
                                    0, (index) {
                              var data = employeeController
                                  .employeeData.value.result?[index];
                              return CustomEmployeeData(
                                imageUrl:
                                    "${ApiUrl.networkUrl}${data?.profileImage}",
                                name:
                                    "${data?.firstName ?? " "} ${data?.lastName}",
                                designation: data?.jobType ?? "",
                                id: data?.id ?? "",
                                email: data?.email ?? "",
                                onDetailsTap: () {
                                  Get.toNamed(AppRoutes.employeeDetails,
                                      arguments: [data?.id]);
                                },
                                onDeleteTap: () {
                                  GlobalAlert.showDeleteDialog(context, () {
                                    AddEmployee.deleteEmployee(
                                        userId: data?.id ?? "",
                                        authId: data?.authId ?? "");
                                  }, AppStrings.areYouSureYouWant.tr);
                                },
                              );
                            }),
                          );
                      }
                    })
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
