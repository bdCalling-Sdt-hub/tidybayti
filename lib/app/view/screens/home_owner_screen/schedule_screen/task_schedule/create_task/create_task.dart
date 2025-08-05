import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:tidybayte/app/utils/app_colors/app_colors.dart';
import 'package:tidybayte/app/view/components/custom_button/custom_button.dart';
import 'package:tidybayte/app/view/components/custom_text/custom_text.dart';
import 'package:tidybayte/app/view/components/custom_text_field/custom_text_field.dart';
import 'package:tidybayte/app/view/screens/home_owner_screen/schedule_screen/task_schedule/create_task/controller/create_task_controller.dart';

import '../../../../../../utils/app_strings/app_strings.dart';
import '../../../../../components/custom_menu_appbar/custom_menu_appbar.dart';

class CreateTask extends StatelessWidget {
  CreateTask({super.key});

  final CreateTaskController controller = Get.find<CreateTaskController>();

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
          child: SingleChildScrollView(
            child: Column(
              children: [
                ///===========================Create Task Appbar================
                CustomMenuAppbar(
                  title: AppStrings.createTask.tr,
                  onBack: () {
                    Get.back();
                  },
                ),

                SingleChildScrollView(
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
                    child: Column(
                      children: [
                        const CustomTextField(
                          fieldBorderColor: AppColors.taskColor,
                          fillColor: AppColors.taskColor,
                          hintText: "Task title",
                        ),
                        SizedBox(
                          height: 12.h,
                        ),
                        const CustomTextField(
                          readOnly: true,
                          fieldBorderColor: AppColors.taskColor,
                          fillColor: AppColors.taskColor,
                          hintText: "Assign to",
                          suffixIcon: Icon(Icons.keyboard_arrow_down),
                        ),
                        SizedBox(
                          height: 12.h,
                        ),

                        ///=========================== DATE =======================
                        CustomTextField(
                          fieldBorderColor: AppColors.taskColor,
                          fillColor: AppColors.taskColor,
                          hintText: "Select date",
                          suffixIcon: const Icon(Icons.calendar_month),
                          textEditingController: controller.dateController,
                          readOnly: true,
                          onTap: () async {
                            DateTime? pickedDate = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(2000),
                              lastDate: DateTime(2100),
                            );

                            if (pickedDate != null) {
                              String formattedDate =
                                  "${pickedDate.day}/${pickedDate.month}/${pickedDate.year}";
                              controller.dateController.text = formattedDate;
                            }
                          },
                        ),
                        SizedBox(height: 12.h),

                        ///=========================== TIME =======================
                        CustomTextField(
                          fieldBorderColor: AppColors.taskColor,
                          fillColor: AppColors.taskColor,
                          hintText: "Select time",
                          suffixIcon: const Icon(Icons.watch_later_outlined),
                          textEditingController: controller.timeController,
                          readOnly: true,
                          onTap: () async {
                            TimeOfDay? pickedTime = await showTimePicker(
                              context: context,
                              initialTime: TimeOfDay.now(),
                            );

                            if (pickedTime != null) {
                              final now = DateTime.now();
                              final dt = DateTime(now.year, now.month, now.day,
                                  pickedTime.hour, pickedTime.minute);
                              String formattedTime =
                                  TimeOfDay.fromDateTime(dt).format(context);
                              controller.timeController.text = formattedTime;
                            }
                          },
                        ),
                        SizedBox(height: 12.h),
                        CustomTextField(
                          fieldBorderColor: AppColors.news,
                          fillColor: AppColors.news,
                          hintText: "Recurrence",
                          readOnly: true,
                          textEditingController:
                              controller.recurrenceController,
                          suffixIcon: const Icon(Icons.keyboard_arrow_down),
                          onTap: () {
                            _showRecurrenceDialog(
                              context,
                              controller.recurrenceController,
                            );
                          },
                        ),

                        SizedBox(
                          height: 12.h,
                        ),
                        const CustomTextField(
                          maxLines: 5,
                          fieldBorderColor: AppColors.news,
                          fillColor: AppColors.news,
                          hintText: "Task Details",
                        ),
                        SizedBox(
                          height: 12.h,
                        ),
                        const CustomTextField(
                          maxLines: 5,
                          fieldBorderColor: AppColors.news,
                          fillColor: AppColors.news,
                          hintText: "Additional message",
                        ),
                        SizedBox(
                          height: 12.h,
                        ),
                        CustomButton(
                          fillColor: Colors.white,
                          onTap: () {},
                          title: "Assign task",
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showRecurrenceDialog(
    BuildContext context,
    TextEditingController controller,
  ) {
    showDialog(
      context: context,
      builder: (context) {
        String? selectedOption = controller.text; // Optional, to preselect
        List<String> options = [
          "Never",
          "Daily",
          "Every week",
          "Every 2 weeks",
          "Every month",
          "Every 3 months",
          "Every 6 months",
          "Every 1 Year",
        ];

        return AlertDialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          contentPadding: const EdgeInsets.all(0),
          content: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ...options.map((option) {
                    return InkWell(
                      onTap: () {
                        controller.text = option;
                        Navigator.pop(context);
                      },
                      child: Column(
                        children: [
                          Container(
                            color: Colors.blue.shade50,
                            padding: const EdgeInsets.symmetric(
                                vertical: 14, horizontal: 16),
                            child: Row(
                              children: [
                                Radio<String>(
                                  value: option,
                                  groupValue: selectedOption,
                                  onChanged: (value) {
                                    controller.text = value!;
                                    Navigator.pop(context);
                                  },
                                ),
                                const SizedBox(width: 8),
                                CustomText(
                                  text: option,
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.black,
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 8),
                        ],
                      ),
                    );
                  }),

                  const Divider(height: 1),
                  const SizedBox(height: 8),
                  // Custom button
                  CustomButton(
                    onTap: () {
                      Navigator.pop(context);
                      _showCustomRecurrencePicker(
                          context, controller);
                    },
                    title: "Custom",
                    fillColor: AppColors.news,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void _showCustomRecurrencePicker(
      BuildContext context,
      TextEditingController controller,
      ) {
    int selectedNumber = 1;
    String selectedUnit = "Days";
    List<String> selectedDays = [];   // ✅ for Weeks
    List<String> selectedMonths = []; // ✅ for Months
    final List<String> weekDays = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"];
    final List<String> monthNames = [
      "Jan", "Feb", "Mar", "Apr", "May", "Jun",
      "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"
    ];

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              title: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Select Recurrence"),
                  Divider(color: Colors.black),
                ],
              ),
              content: SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxHeight: 600),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        children: [
                          /// Number Selector
                          SizedBox(
                            height: 250,
                            width: 80,
                            child: ListView.builder(
                              itemCount: 30,
                              itemBuilder: (context, index) {
                                int value = index + 1;
                                bool isSelected = selectedNumber == value;
                                return InkWell(
                                  onTap: () {
                                    setState(() {
                                      selectedNumber = value;
                                    });
                                  },
                                  child: Container(
                                    margin: const EdgeInsets.symmetric(vertical: 4),
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 12, horizontal: 25),
                                    decoration: BoxDecoration(
                                      color: isSelected
                                          ? AppColors.addedColor
                                          : Colors.transparent,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Center(
                                      child: Text(
                                        "$value",
                                        style: TextStyle(
                                          fontWeight: isSelected
                                              ? FontWeight.bold
                                              : FontWeight.normal,
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),

                          const SizedBox(width: 16),

                          /// Unit Selector
                          SizedBox(
                            height: 250,
                            width: 120,
                            child: ListView(
                              children: ["Days", "Weeks", "Months"].map((unit) {
                                bool isSelected = selectedUnit == unit;
                                return InkWell(
                                  onTap: () {
                                    setState(() {
                                      selectedUnit = unit;
                                      selectedDays.clear();
                                      selectedMonths.clear();
                                    });
                                  },
                                  child: Container(
                                    margin: const EdgeInsets.symmetric(vertical: 4),
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 12, horizontal: 25),
                                    decoration: BoxDecoration(
                                      color: isSelected
                                          ? AppColors.addedColor
                                          : Colors.transparent,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Center(
                                      child: Text(
                                        unit,
                                        style: TextStyle(
                                          fontWeight: isSelected
                                              ? FontWeight.bold
                                              : FontWeight.normal,
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              }).toList(),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 16),

                      /// ✅ Week Days Selection (if Weeks)
                      if (selectedUnit == "Weeks") ...[
                        const Divider(),
                        const Text("Select Days", style: TextStyle(fontWeight: FontWeight.bold)),
                        const SizedBox(height: 8),
                        Wrap(
                          spacing: 8,
                          children: weekDays.map((day) {
                            final isSelected = selectedDays.contains(day);
                            return ChoiceChip(
                              backgroundColor: Colors.white,
                              label: Text(day),
                              selected: isSelected,
                              onSelected: (selected) {
                                setState(() {
                                  isSelected
                                      ? selectedDays.remove(day)
                                      : selectedDays.add(day);
                                });
                              },
                              selectedColor: AppColors.addedColor,
                            );
                          }).toList(),
                        ),
                        const SizedBox(height: 16),
                      ],

                      /// ✅ Month Selection (if Months)
                      if (selectedUnit == "Months") ...[
                        const Divider(),
                        const Text("Select Months", style: TextStyle(fontWeight: FontWeight.bold)),
                        const SizedBox(height: 8),
                        Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: monthNames.map((month) {
                            final isSelected = selectedMonths.contains(month);
                            return ChoiceChip(
                              backgroundColor: Colors.white,
                              label: Text(month),
                              selected: isSelected,
                              onSelected: (selected) {
                                setState(() {
                                  isSelected
                                      ? selectedMonths.remove(month)
                                      : selectedMonths.add(month);
                                });
                              },
                              selectedColor: AppColors.addedColor,
                            );
                          }).toList(),
                        ),
                        const SizedBox(height: 16),
                      ],

                      const Divider(),

                      /// Confirm Button
                      Expanded(
                        child: CustomButton(
                          onTap: () {
                            String text = "$selectedNumber $selectedUnit";
                            if (selectedUnit == "Weeks" && selectedDays.isNotEmpty) {
                              text += " (${selectedDays.join(", ")})";
                            } else if (selectedUnit == "Months" &&
                                selectedMonths.isNotEmpty) {
                              text += " (${selectedMonths.join(", ")})";
                            }

                            controller.text = text;
                            Navigator.pop(context);
                          },
                          title: "Confirm",
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }


}
