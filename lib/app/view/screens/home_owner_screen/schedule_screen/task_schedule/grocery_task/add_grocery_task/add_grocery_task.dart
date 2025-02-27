import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:tidybayte/app/controller/owner_controller/grocery_controller/grocery_controller.dart';
import 'package:tidybayte/app/core/app_routes/app_routes.dart';
import 'package:tidybayte/app/utils/app_strings/app_strings.dart';
import 'package:tidybayte/app/view/components/custom_button/custom_button.dart';
import 'package:tidybayte/app/view/components/custom_menu_appbar/custom_menu_appbar.dart';
import 'package:tidybayte/app/view/components/custom_text_field/custom_text_field.dart';
class AddGroceryTask extends StatefulWidget {
  const AddGroceryTask({super.key});

  @override
  State<AddGroceryTask> createState() => _AllTaskScreenState();
}

class _AllTaskScreenState extends State<AddGroceryTask> {


  String? selectedEmployee;
final GroceryController controller = Get.find<GroceryController>();
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
              ///=============================== addGrocery Title ========================
              CustomMenuAppbar(
                title: AppStrings.addGrocery.tr,
                onBack: () {
                  Get.back();
                },
              ),

              ///=============================== Form Fields ========================
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  children: [
                    ///===============================addItem  ========================
                     CustomTextField(
                      readOnly: true,
                      hintText: AppStrings.addItem.tr,
                      textEditingController: controller.groceryNameController,
                    ),
                    SizedBox(height: 12.h),

                    ///=============================== Employee ========================

                    SizedBox(height: 16.h),
                    ///=========================== Start Date =======================
                    CustomTextField(
                      hintText: "Start Date".tr,
                      suffixIcon: const Icon(Icons.calendar_month),
                      textEditingController: controller.startDateController,
                      readOnly: true,
                      // Prevent manual input
                      onTap: () async {
                        DateTime? pickedDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2000),
                          lastDate: DateTime(2100),
                        );

                        if (pickedDate != null) {
                          String formattedDate =
                          DateFormat('MM/dd/yyyy').format(pickedDate);
                          controller.startDateController.text = formattedDate;
                        }
                      },
                    ),
                    SizedBox(height: 16.h),

                    ///=========================== Start Time =======================
                    CustomTextField(
                      hintText: "Start Time".tr,
                      suffixIcon: const Icon(Icons.watch_later_outlined),
                      textEditingController: controller.startTimeController,
                      readOnly: true,
                      // Prevent manual input
                      onTap: () async {
                        TimeOfDay? pickedTime = await showTimePicker(
                          context: context,
                          initialTime: TimeOfDay.now(),
                        );

                        if (pickedTime != null) {
                          // ✅ Format time to HH:mm a (12-hour format with AM/PM)
                          final now = DateTime.now();
                          final selectedTime = DateTime(now.year, now.month,
                              now.day, pickedTime.hour, pickedTime.minute);
                          final formattedTime =
                          DateFormat('hh:mm a').format(selectedTime);

                          controller.startTimeController.text = formattedTime;
                        }
                      },
                    ),

                    SizedBox(height: 16.h),

                    ///=========================== End Date =======================

                    CustomTextField(
                      hintText: "End Date".tr,
                      suffixIcon: const Icon(Icons.calendar_month),
                      textEditingController: controller.endDateController,
                      readOnly: true,
                      // Prevent manual input
                      onTap: () async {
                        DateTime? pickedDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2000),
                          lastDate: DateTime(2100),
                        );

                        if (pickedDate != null) {
                          String formattedDate =
                          DateFormat('MM/dd/yyyy').format(pickedDate);
                          controller.endDateController.text = formattedDate;
                        }
                      },
                    ),
                    SizedBox(height: 16.h),

                    ///=========================== End Time =======================

                    CustomTextField(
                      hintText: "Start Time".tr,
                      suffixIcon: const Icon(Icons.watch_later_outlined),
                      textEditingController: controller.endTimeController,
                      readOnly: true,
                      // Prevent manual input
                      onTap: () async {
                        TimeOfDay? pickedTime = await showTimePicker(
                          context: context,
                          initialTime: TimeOfDay.now(),
                        );

                        if (pickedTime != null) {
                          final now = DateTime.now();
                          final selectedTime = DateTime(now.year, now.month,
                              now.day, pickedTime.hour, pickedTime.minute);
                          final formattedTime =
                          DateFormat('hh:mm a').format(selectedTime);

                          controller.endTimeController.text = formattedTime;
                        }
                      },
                    ),
                    SizedBox(height: 16.h),
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
