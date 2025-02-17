import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tidybayte/app/controller/owner_controller/task_controller/task_controller.dart';
import 'package:tidybayte/app/utils/app_colors/app_colors.dart';

import 'package:tidybayte/app/utils/app_strings/app_strings.dart';
import 'package:tidybayte/app/view/components/custom_button/custom_button.dart';
import 'package:tidybayte/app/view/components/custom_menu_appbar/custom_menu_appbar.dart';

import 'package:tidybayte/app/view/components/custom_text/custom_text.dart';
import 'package:tidybayte/app/view/components/custom_text_field/custom_text_field.dart';
class CreateTask extends StatelessWidget {
   CreateTask({super.key});

  final TaskController taskController = Get.find<TaskController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFB5D8EE),
      body: Container(

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
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ///===========================Create Task Appbar================
                  CustomMenuAppbar(
                    title: AppStrings.createTask.tr,
                    onBack: () {
                      Get.back();
                    },
                  ),

                  ///==================================✅✅Assign Employee✅✅=======================

                  GestureDetector(
                    onTap: () {
                      // Placeholder for bottom sheet
                    },
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Assigned To',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16.sp,
                            ),
                          ),
                          Row(
                            children: [
                              Text(
                                'Employee Name',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16.sp,
                                ),
                              ),
                              const Icon(Icons.arrow_right),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),

                  ///==================================✅✅Add Employee Tiitle✅✅=======================
                  SizedBox(height: 10.h),
                   CustomTextField(
                    hintText: AppStrings.taskTitle.tr,

                  ),
                  SizedBox(height: 8.h),

                  ///==================================✅✅Add Employee Tiitle✅✅=======================
                   CustomText(
                    text: AppStrings.recurrence.tr,
                    fontWeight: FontWeight.w300,
                    fontSize: 24,
                    color: AppColors.dark300,
                  ),

                  SizedBox(height: 16.h),

                  ///==================================✅✅Add Employee Tiitle✅✅=======================
                   CustomTextField(
                    hintText: AppStrings.selectDate.tr,
                    suffixIcon: const Icon(Icons.calendar_month),
                  ),
                  SizedBox(height: 16.h),

                  ///==================================✅✅Add Employee Tiitle✅✅=======================
                   CustomTextField(
                    hintText: AppStrings.selectTime.tr,
                    suffixIcon: const Icon(Icons.watch_later_outlined),
                  ),
                  SizedBox(height: 16.h),

                  ///==================================✅✅Add Employee Tiitle✅✅=======================
                   CustomTextField(
                    hintText: AppStrings.taskDetails.tr,
                    maxLines: 8,
                  ),
                  SizedBox(height: 16.h),

                  ///==================================✅✅Add Employee Tiitle✅✅=======================
                   CustomTextField(
                    hintText: AppStrings.additionalMessage.tr,
                    maxLines: 8,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      ///==================================✅✅assignTo Button✅✅=======================

      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 20),
        child: CustomButton(
          onTap: () {
          taskController.addTask();
          },
          fillColor: AppColors.blue50,
          title: AppStrings.assignTo.tr,
        ),
      ),
    );
  }
}
