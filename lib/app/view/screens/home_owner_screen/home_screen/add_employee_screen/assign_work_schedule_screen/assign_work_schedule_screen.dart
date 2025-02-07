import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tidybayte/app/core/app_routes/app_routes.dart';
import 'package:tidybayte/app/utils/app_colors/app_colors.dart';
import 'package:tidybayte/app/utils/app_icons/app_icons.dart';
import 'package:tidybayte/app/utils/app_images/app_images.dart';
import 'package:tidybayte/app/utils/app_strings/app_strings.dart';
import 'package:tidybayte/app/view/components/custom_button/custom_button.dart';
import 'package:tidybayte/app/view/components/custom_image/custom_image.dart';
import 'package:tidybayte/app/view/components/custom_menu_appbar/custom_menu_appbar.dart';
import 'package:tidybayte/app/view/components/custom_task_details_dialoge/custom_task_details_dialoge.dart';
import 'package:tidybayte/app/view/components/custom_text/custom_text.dart';
import 'package:tidybayte/app/view/components/custom_text_field/custom_text_field.dart';


class AssignWorkScheduleScreen extends StatefulWidget {
  const AssignWorkScheduleScreen({super.key});

  @override
  State<AssignWorkScheduleScreen> createState() =>
      _AssignWorkScheduleScreenState();
}

class _AssignWorkScheduleScreenState extends State<AssignWorkScheduleScreen> {
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
        height: MediaQuery
            .of(context)
            .size
            .height,
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
                    CustomButton(
                      onTap: () {},
                      fillColor: Colors.white,
                      title: 'Annette Black',
                    ),
                    CustomText(text: 'Choose Six working Days and one day off.',
                      fontSize: 15,
                      top: 8,
                      bottom: 10,
                      fontWeight: FontWeight.w400,
                      color: AppColors.dark300,),
                    const Text(
                      "Select working days",
                      style: TextStyle(fontSize: 18),
                    ),
                    GridView.builder(
                      shrinkWrap: true,
                      itemCount: days.length,
                      gridDelegate:
                      const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 5,
                      ),
                      itemBuilder: (context, index) {
                        String day = days[index];
                        return CheckboxListTile(
                          title: Text(day),
                          value: selectedWorkingDays.contains(day),
                          onChanged: (bool? value) {
                            toggleWorkingDay(day);
                          },
                          controlAffinity: ListTileControlAffinity.leading,
                          activeColor: AppColors.dark400,
                        );
                      },
                    ),
                    const SizedBox(height: 20),

                    // Off day section
                    const Text(
                      "Select off days",
                      style: TextStyle(fontSize: 18),
                    ),
                    GridView.builder(
                      shrinkWrap: true,
                      itemCount: days.length,
                      gridDelegate:
                      const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 5,
                      ),
                      itemBuilder: (context, index) {
                        String day = days[index];
                        return CheckboxListTile(
                          title: Text(day),
                          value: selectedOffDay == day,
                          onChanged: (bool? value) {
                            toggleOffDay(day);
                          },
                          controlAffinity: ListTileControlAffinity.leading,
                          activeColor: AppColors.dark400,
                        );
                      },
                    ),
                  ],
                ),
              ),

              CustomButton(
                width: MediaQuery.of(context).size.width/1.1,
                onTap: (){
                  Get.toNamed(AppRoutes.assignWorkScreen);
                },

              fillColor: Colors.white,
                title: AppStrings.continues,
              ),
              SizedBox(height: 40.h,)
            ],
          ),
        ),
      ),
    );
  }
}
