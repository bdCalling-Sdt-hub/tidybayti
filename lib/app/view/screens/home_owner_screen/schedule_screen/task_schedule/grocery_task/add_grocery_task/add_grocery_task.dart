import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:tidybayte/app/controller/owner_controller/add_employee_controller/add_employee_controller.dart';
import 'package:tidybayte/app/controller/owner_controller/grocery_controller/grocery_controller.dart';
import 'package:tidybayte/app/utils/app_const/app_const.dart';
import 'package:tidybayte/app/utils/app_strings/app_strings.dart';
import 'package:tidybayte/app/view/components/custom_button/custom_button.dart';
import 'package:tidybayte/app/view/components/custom_loader/custom_loader.dart';
import 'package:tidybayte/app/view/components/custom_menu_appbar/custom_menu_appbar.dart';
import 'package:tidybayte/app/view/components/custom_text/custom_text.dart';
import 'package:tidybayte/app/view/components/custom_text_field/custom_text_field.dart';

class AddGroceryTask extends StatefulWidget {
  const AddGroceryTask({super.key});

  @override
  State<AddGroceryTask> createState() => _AllTaskScreenState();
}

class _AllTaskScreenState extends State<AddGroceryTask> {
  String selectedEmployee = 'Select Employee';

  final GroceryController controller = Get.find<GroceryController>();
  final AddEmployeeController employeeController =
      Get.find<AddEmployeeController>();

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
          child: Obx(
          () {
              return Column(
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
                        ///=========================== Assign Employee =======================
                        GestureDetector(
                          onTap: _showEmployeeList,
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
                                      selectedEmployee,
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    const Icon(Icons.arrow_right),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 12.h),

                        ///===============================addItem  ========================
                        CustomTextField(

                          hintText: AppStrings.addItem.tr,
                          textEditingController: controller.groceryNameController,
                        ),
                        SizedBox(height: 12.h),

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
                        controller.isAddGroceryLoading.value
                            ? const CustomLoader()
                            : CustomButton(
                                onTap: () {
                                  controller.addGrocery();
                                },
                                fillColor: Colors.white,
                                title: AppStrings.confirm,
                              ),
                      ],
                    ),
                  ),
                ],
              );
            }
          ),
        ),
      ),
    );
  }

  ///=========================== Show Employee List Modal =======================
  void _showEmployeeList() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Select Employee',
                style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
              ),
              const Divider(),
              Expanded(
                child: Obx(() {
                  if (employeeController.rxRequestStatus.value ==
                      Status.loading) {
                    return const Center(
                        child: CustomLoader()); // ✅ Show loading indicator
                  }
                  if (employeeController.rxRequestStatus.value ==
                      Status.internetError) {
                    return Center(
                        child: CustomText(
                            text: "No Internet Connection", fontSize: 16.sp));
                  }
                  if (employeeController.rxRequestStatus.value ==
                      Status.error) {
                    return Center(
                        child: CustomText(
                            text: "Something went wrong", fontSize: 16.sp));
                  }
                  if (employeeController.employeeData.value.result == null ||
                      employeeController.employeeData.value.result!.isEmpty) {
                    return Center(
                        child: CustomText(
                            text: "No Employees Found", fontSize: 16.sp));
                  }

                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount:
                        employeeController.employeeData.value.result!.length,
                    itemBuilder: (context, index) {
                      final data =
                          employeeController.employeeData.value.result![index];

                      return ListTile(
                        title: Text(
                          "${data.firstName ?? " "} ${data.lastName}",
                          style:
                              TextStyle(fontSize: 16.sp, color: Colors.black),
                        ),
                        onTap: () {
                          setState(() {
                            selectedEmployee =
                                "${data.firstName ?? " "} ${data.lastName}";
                            print('EmployeeId===================${data.id}');
                            controller.assignedId = data.id ?? "";
                          });
                          Navigator.pop(context);
                        },
                      );
                    },
                  );
                }),
              ),
            ],
          ),
        );
      },
    );
  }
}
