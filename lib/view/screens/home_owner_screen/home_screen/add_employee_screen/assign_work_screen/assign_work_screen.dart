import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tidybayte/core/app_routes/app_routes.dart';
import 'package:tidybayte/utils/app_colors/app_colors.dart';

import 'package:tidybayte/utils/app_strings/app_strings.dart';
import 'package:tidybayte/view/components/custom_button/custom_button.dart';
import 'package:tidybayte/view/components/custom_menu_appbar/custom_menu_appbar.dart';
import 'package:tidybayte/view/components/custom_room_card/custom_room_card.dart';
import 'package:tidybayte/view/components/custom_text/custom_text.dart';

import '../../room_details_screen/room_details_screen.dart';

class AssignWorkScreen extends StatefulWidget {
  const AssignWorkScreen({super.key});

  @override
  State<AssignWorkScreen> createState() => _AssignWorkScheduleScreenState();
}

class _AssignWorkScheduleScreenState extends State<AssignWorkScreen> {
  // Days of the week
  final List<String> days = [
    'Saturday',
    'Sunday',
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
  ];

  // Tracking working and off days selections
  List<String> selectedWorkingDays = [];
  String? selectedOffDay;

  // Maximum limits
  final int maxWorkingDays = 6;
  final int maxOffDays = 1;

  // Method to update working days
  void toggleWorkingDay(String day) {
    setState(() {
      if (selectedWorkingDays.contains(day)) {
        selectedWorkingDays.remove(day); // Unselect if already selected
      } else if (selectedWorkingDays.length < maxWorkingDays) {
        selectedWorkingDays.add(day); // Add if not at max limit
      }
    });
  }

  // Method to update off day
  void toggleOffDay(String day) {
    setState(() {
      if (selectedOffDay == day) {
        selectedOffDay = null; // Unselect if already selected
      } else {
        selectedOffDay = day; // Set as off day
      }
    });
  }

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
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ///=============================== Menu Title ========================
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CustomMenuAppbar(
                    title: AppStrings.assignWork,
                    onBack: () {
                      Get.back();
                    },
                  ),
                ],
              ),

              ///=============================== Menu Items ========================
              Expanded(
                child: ListView(
                  padding: EdgeInsets.all(16.0),
                  children: [
                    Row(
                      children: [
                        Expanded(
                          flex: 5,
                          child: CustomButton(
                            onTap: () {},
                            fillColor: Colors.white,
                            title: AppStrings.addNewTask,
                          ),
                        ),
                        SizedBox(
                          width: 8.w,
                        ),
                        Expanded(
                          flex: 5,
                          child: CustomButton(
                            onTap: () {},
                            fillColor: Colors.white,
                            title: AppStrings.addBreakTime,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Column(
                      children: List.generate(4, (index) {
                        return CustomRoomCard(
                          taskName: 'Clean',
                          assignedTo: 'Annette Black',
                          time: '10.00 am - 11 am',
                          onInfoPressed: () {
                            TaskInfoDialog.showTask(
                              context: context,
                              content:
                                  'Are you sure you want to delete this task?',
                              onConfirm: () {
                                // Handle confirm action (e.g., delete task)
                                Navigator.of(context).pop(); // Close the dialog
                              },
                              onCancel: () {
                                Navigator.of(context)
                                    .pop(); // Close the dialog without any action
                              },
                            );
                          },
                          onDeletePressed: () {
                            TaskAlertDialog.showTaskDialog(
                              context: context,
                              title: 'Delete Task',
                              content:
                                  'Are you sure you want to delete this task?',
                              onConfirm: () {
                                // Handle confirm action (e.g., delete task)
                                Navigator.of(context).pop(); // Close the dialog
                              },
                              onCancel: () {
                                Navigator.of(context)
                                    .pop(); // Close the dialog without any action
                              },
                            );
                          },
                        );
                      }),
                    )
                  ],
                ),
              ),

              CustomButton(
                width: MediaQuery.of(context).size.width / 1.1,
                onTap: () {
                  Get.toNamed(AppRoutes.assignTaskSuccessfullyScreen);
                },
                fillColor: Colors.white,
                title: AppStrings.finish,
              ),
              SizedBox(
                height: 40.h,
              )
            ],
          ),
        ),
      ),
    );
  }
}
