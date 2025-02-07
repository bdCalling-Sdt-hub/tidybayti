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
class AddGroceryTask extends StatefulWidget {
  const AddGroceryTask({super.key});

  @override
  State<AddGroceryTask> createState() => _AllTaskScreenState();
}

class _AllTaskScreenState extends State<AddGroceryTask> {
  final List<String> dayName = [
    'Pending Tasks',
    'Completed Tasks',
  ];

  // To track the selected employee
  String? selectedEmployee;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          child: Column(
            children: [
              ///=============================== Menu Title ========================
              CustomMenuAppbar(
                title: AppStrings.addGrocery,
                onBack: () {
                  Get.back();
                },
              ),

              ///=============================== Form Fields ========================
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  children: [
                    CustomTextField(
                      readOnly: true,
                      hintText: 'Add item',
                    ),
                    SizedBox(height: 12.h),

                    // Assign to field with employee selection
                    CustomTextField(
                      onTap: () async {
                        final result = await Get.toNamed(AppRoutes.employeeList);
                        if (result != null) {
                          setState(() {
                            selectedEmployee = result as String; // Set selected employee
                          });
                        }
                      },
                      readOnly: true,
                      hintText: selectedEmployee ?? 'Assign To', // Display selected employee
                      suffixIcon: Icon(Icons.arrow_forward_ios),
                    ),

                    SizedBox(height: 12.h),
                    CustomTextField(
                      readOnly: true,
                      hintText: 'Select Date',
                      suffixIcon: Icon(Icons.calendar_month),
                    ),
                    SizedBox(height: 12.h),
                    CustomTextField(
                      readOnly: true,
                      hintText: 'Select Time',
                      suffixIcon: Icon(Icons.watch_later_outlined),
                    ),
                    SizedBox(height: 25.h),
                    CustomButton(
                      onTap: () {
                        Get.back();
                      },
                      fillColor: Colors.white,
                      title: AppStrings.confirm,
                    ),
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
