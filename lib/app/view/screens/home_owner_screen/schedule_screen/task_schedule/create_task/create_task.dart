import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:tidybayte/app/controller/owner_controller/add_employee_controller/add_employee_controller.dart';
import 'package:tidybayte/app/controller/owner_controller/task_controller/task_controller.dart';
import 'package:tidybayte/app/utils/app_colors/app_colors.dart';
import 'package:tidybayte/app/utils/app_const/app_const.dart';
import 'package:tidybayte/app/utils/app_strings/app_strings.dart';
import 'package:tidybayte/app/view/components/custom_button/custom_button.dart';
import 'package:tidybayte/app/view/components/custom_loader/custom_loader.dart';
import 'package:tidybayte/app/view/components/custom_menu_appbar/custom_menu_appbar.dart';
import 'package:tidybayte/app/view/components/custom_text/custom_text.dart';
import 'package:tidybayte/app/view/components/custom_text_field/custom_text_field.dart';

class CreateTask extends StatefulWidget {
  const CreateTask({super.key});

  @override
  State<CreateTask> createState() => _CreateTaskState();
}

class _CreateTaskState extends State<CreateTask> {
  final TaskController taskController = Get.find<TaskController>();
  final AddEmployeeController employeeController =
      Get.find<AddEmployeeController>();

  String selectedEmployee = 'Select Employee';
  String selectRoom = 'Select Room';
  String selectedOption = 'weekly';

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      employeeController.getEmployee();
      // taskController.getAllRoom();
    });
  }

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
              child: Obx(
                () {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ///===========================Create Task Appbar================
                      CustomMenuAppbar(
                        title: AppStrings.createTask.tr,
                        onBack: () {
                          Get.back();
                        },
                      ),

                      ///=========================== Room id  =======================
                      GestureDetector(
                        onTap: _showRoomList,
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
                                    selectRoom,
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
                      SizedBox(height: 10.h),

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

                      ///=========================== Task Title =======================
                      SizedBox(height: 10.h),
                      CustomTextField(
                        hintText: AppStrings.taskTitle.tr,
                        textEditingController: taskController.taskTitleController,
                      ),
                      SizedBox(height: 8.h),

                      ///=========================== Recurrence =======================
                      CustomText(
                        text: AppStrings.recurrence.tr,
                        fontWeight: FontWeight.w300,
                        fontSize: 24,
                        color: AppColors.dark300,
                      ),
                      Row(
                        children: [
                          _buildRadioButton("one_time"),
                          SizedBox(width: 20.w),
                          _buildRadioButton("Weekly"),
                        ],
                      ),
                      SizedBox(height: 16.h),

                      ///=========================== Start Date =======================
                      CustomTextField(
                        hintText: "Start Date".tr,
                        suffixIcon: const Icon(Icons.calendar_month),
                        textEditingController: taskController.startDateController,
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
                            taskController.startDateController.text = formattedDate;
                          }
                        },
                      ),
                      SizedBox(height: 16.h),

                      ///=========================== Start Time =======================
                      CustomTextField(
                        hintText: "Start Time".tr,
                        suffixIcon: const Icon(Icons.watch_later_outlined),
                        textEditingController: taskController.startTimeController,
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

                            taskController.startTimeController.text = formattedTime;
                          }
                        },
                      ),

                      SizedBox(height: 16.h),

                      ///=========================== End Date =======================

                      CustomTextField(
                        hintText: "End Date".tr,
                        suffixIcon: const Icon(Icons.calendar_month),
                        textEditingController: taskController.endDateController,
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
                            taskController.endDateController.text = formattedDate;
                          }
                        },
                      ),
                      SizedBox(height: 16.h),

                      ///=========================== End Time =======================

                      CustomTextField(
                        hintText: "Start Time".tr,
                        suffixIcon: const Icon(Icons.watch_later_outlined),
                        textEditingController: taskController.endTimeController,
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

                            taskController.endTimeController.text = formattedTime;
                          }
                        },
                      ),
                      SizedBox(height: 16.h),

                      ///=========================== Task Details =======================
                      CustomTextField(
                        hintText: AppStrings.taskDetails.tr,
                        textEditingController: taskController.taskDetailsController,
                        maxLines: 8,
                      ),
                      SizedBox(height: 16.h),

                      ///=========================== Additional Message =======================
                      CustomTextField(
                        hintText: AppStrings.additionalMessage.tr,
                        textEditingController: taskController.additionalController,
                        maxLines: 8,
                      ),
                      SizedBox(height: 16.h),
                      taskController.isTaskLoading.value
                          ? const CustomLoader()
                          : CustomButton(
                        onTap: () {
                          taskController.addTask();
                        },
                        fillColor: AppColors.blue50,
                        title: AppStrings.assignTo.tr,
                      ),
                    ],
                  );
                }
              ),
            ),
          ),
        ),
      ),

      ///=========================== Assign Button =======================
      // bottomNavigationBar: Padding(
      //   padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 20),
      //   child:
      // ),
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
                            taskController.assignedId = data.id ?? "";
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

  ///=========================== Show Room  =======================
  void _showRoomList() {
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
                'Select Room',
                style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
              ),
              const Divider(),
              Expanded(
                child: Obx(() {
                  if (taskController.rxRequestStatus.value == Status.loading) {
                    return const Center(
                        child: CustomLoader()); // ✅ Show loading indicator
                  }
                  if (taskController.rxRequestStatus.value ==
                      Status.internetError) {
                    return Center(
                        child: CustomText(
                            text: "No Internet Connection", fontSize: 16.sp));
                  }
                  if (taskController.rxRequestStatus.value == Status.error) {
                    return Center(
                        child: CustomText(
                            text: "Something went wrong", fontSize: 16.sp));
                  }
                  if (taskController.roomModel.value.rooms == null ||
                      taskController.roomModel.value.rooms!.isEmpty) {
                    return Center(
                        child:
                            CustomText(text: "No Room Found", fontSize: 16.sp));
                  }

                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: taskController.roomModel.value.rooms!.length,
                    itemBuilder: (context, index) {
                      final data = taskController.roomModel.value.rooms![index];

                      return ListTile(
                        title: Text(
                          data.name ?? "",
                          style:
                              TextStyle(fontSize: 16.sp, color: Colors.black),
                        ),
                        onTap: () {
                          setState(() {
                            selectRoom = data.name ?? "";
                            print('RoomId===================${data.id}');
                            taskController.roomId = data.id ?? "";
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

  Widget _buildRadioButton(String label) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedOption = label; // ✅ Update selected option
          taskController.recurrenceController.text =
              label; // ✅ Store in controller
        });
      },
      child: Row(
        children: [
          Radio<String>(
            value: label,
            groupValue: selectedOption,
            onChanged: (value) {
              setState(() {
                selectedOption = value!;
                taskController.recurrenceController.text = value;
              });
            },
          ),
          Text(
            label,
            style: TextStyle(fontSize: 16.sp, color: Colors.black),
          ),
        ],
      ),
    );
  }
}
