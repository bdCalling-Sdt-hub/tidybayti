import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tidybayte/app/core/app_routes/app_routes.dart';
import 'package:tidybayte/app/utils/app_colors/app_colors.dart';
import 'package:tidybayte/app/utils/app_const/app_const.dart';
import 'package:tidybayte/app/utils/app_icons/app_icons.dart';
import 'package:tidybayte/app/utils/app_images/app_images.dart';
import 'package:tidybayte/app/utils/app_strings/app_strings.dart';
import 'package:tidybayte/app/view/components/custom_button/custom_button.dart';
import 'package:tidybayte/app/view/components/custom_image/custom_image.dart';
import 'package:tidybayte/app/view/components/custom_menu_appbar/custom_menu_appbar.dart';
import 'package:tidybayte/app/view/components/custom_netwrok_image/custom_network_image.dart';
import 'package:tidybayte/app/view/components/custom_room_card/custom_room_card.dart';
import 'package:tidybayte/app/view/components/custom_task_details_dialoge/custom_task_details_dialoge.dart';
import 'package:tidybayte/app/view/components/custom_text/custom_text.dart';
import 'package:tidybayte/app/view/components/custom_text_field/custom_text_field.dart';
import 'package:tidybayte/app/view/components/nav_bar/nav_bar.dart';
class CreateTask extends StatelessWidget {
  const CreateTask({super.key});

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
                    title: AppStrings.createTask,
                    onBack: () {
                      Get.back();
                    },
                  ),

                  // Assigned To Section
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
                              Icon(Icons.arrow_right),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),

                  ///=========================Task title=================
                  SizedBox(height: 10.h),
                  const CustomTextField(
                    hintText: AppStrings.taskTitle,
                  ),
                  SizedBox(height: 8.h),

                  ///=========================recurrence=================
                  const CustomText(
                    text: AppStrings.recurrence,
                    fontWeight: FontWeight.w300,
                    fontSize: 24,
                    color: AppColors.dark300,
                  ),
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      mainAxisExtent: 40,
                    ),
                    itemCount: 3,
                    itemBuilder: (context, index) {
                      return Row(
                        children: [
                          Radio(
                            value: index,
                            groupValue: 1,
                            onChanged: (value) {},
                          ),
                          Text(
                            'Option ${index + 1}',
                            style: TextStyle(fontSize: 11),
                          ),
                        ],
                      );
                    },
                  ),
                  SizedBox(height: 16.h),

                  ///===========================Select Date================
                  const CustomTextField(
                    hintText: AppStrings.selectDate,
                    suffixIcon: Icon(Icons.calendar_month),
                  ),
                  SizedBox(height: 16.h),

                  ///===========================Select Time================
                  const CustomTextField(
                    hintText: AppStrings.selectTime,
                    suffixIcon: Icon(Icons.watch_later_outlined),
                  ),
                  SizedBox(height: 16.h),

                  ///===========================taskDetails================
                  const CustomTextField(
                    hintText: AppStrings.taskDetails,
                    maxLines: 8,
                  ),
                  SizedBox(height: 16.h),

                  ///===========================Additional Message================
                  const CustomTextField(
                    hintText: AppStrings.additionalMessage,
                    maxLines: 8,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 20),
        child: CustomButton(
          onTap: () {
            Get.back();
          },
          fillColor: AppColors.blue50,
          title: 'Assign task',
        ),
      ),
    );
  }
}
