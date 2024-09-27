import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tidybayte/utils/app_colors/app_colors.dart';
import 'package:tidybayte/utils/app_const/app_const.dart';

import 'package:tidybayte/utils/app_strings/app_strings.dart';
import 'package:tidybayte/view/components/custom_button/custom_button.dart';
import 'package:tidybayte/view/components/custom_menu_appbar/custom_menu_appbar.dart';
import 'package:tidybayte/view/components/custom_netwrok_image/custom_network_image.dart';
import 'package:tidybayte/view/components/custom_text/custom_text.dart';
import 'package:tidybayte/view/components/custom_text_field/custom_text_field.dart';
import 'package:tidybayte/view/components/nav_bar/nav_bar.dart';

class AddEmployeeScreen extends StatefulWidget {
  const AddEmployeeScreen({super.key});

  @override
  State<AddEmployeeScreen> createState() => _AddEmployeeScreenState();
}

class _AddEmployeeScreenState extends State<AddEmployeeScreen> {
  // Days of the week
  final List<String> daysOfWeek = [
    'Saturday',
    'Sunday',
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday'
  ];

  // Selected state for working and off days
  List<bool> selectedWorkingDays = [
    true,
    false,
    true,
    true,
    true,
    false,
    true
  ]; // Preselected working days
  List<bool> selectedOffDays = [
    false,
    true,
    false,
    false,
    false,
    false,
    false
  ]; // Preselected off days

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const NavBar(currentIndex: 4),
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
              ///=============================== Menu Title ========================
              CustomMenuAppbar(
                title: AppStrings.addEmployee,
                onBack: () {
                  Get.back();
                },
              ),

              ///=============================== Employee List ========================
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.all(16.0),
                  children: [
                    CustomNetworkImage(
                      boxShape: BoxShape.circle,
                        imageUrl: AppConstants.userNtr,
                        height: 117,
                        width: 117),
                    SizedBox(
                      height: 20.h,
                    ),
                    CustomTextField(
                      hintText: AppStrings.employeeName,
                      fillColor: AppColors.employeeCardColor,
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    CustomTextField(
                      hintText: AppStrings.designation,
                      fillColor: AppColors.employeeCardColor,
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    CustomTextField(
                      suffixIcon: Icon(Icons.keyboard_arrow_down_rounded),
                      hintText: AppStrings.jobType,
                      fillColor: AppColors.employeeCardColor,
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    CustomTextField(
                      suffixIcon: Icon(Icons.keyboard_arrow_down_rounded),
                      hintText: AppStrings.cPR,
                      fillColor: AppColors.employeeCardColor,
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    CustomTextField(
                      suffixIcon: Icon(Icons.keyboard_arrow_down_rounded),
                      hintText: AppStrings.passport,
                      fillColor: AppColors.employeeCardColor,
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    CustomTextField(
                      hintText: AppStrings.drivingLicense,
                      fillColor: AppColors.employeeCardColor,
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    CustomTextField(
                      hintText: AppStrings.contactNumber,
                      fillColor: AppColors.employeeCardColor,
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    CustomTextField(
                      hintText: AppStrings.address,
                      fillColor: AppColors.employeeCardColor,
                    ),

                    ///============================
                    const Padding(
                      padding: EdgeInsets.only(bottom: 16.0, top: 16),
                      child: Text(
                        'Select working days',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    _buildDaySelectionGrid(selectedWorkingDays, true),

                    const SizedBox(height: 24.0), // Spacing between sections

                    const Text(
                      'Select off days',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    _buildDaySelectionGrid(selectedOffDays, false),

                    SizedBox(
                      height: 15,
                    ),
                    CustomButton(
                      onTap: () {
                        showDialoge(context);
                      },
                      fillColor: Colors.white,
                      title: AppStrings.upgradeProfile,
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDaySelectionGrid(List<bool> selectedDays, bool isWorkingDay) {
    return GridView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: daysOfWeek.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 5, // Adjust this to control checkbox size
        crossAxisSpacing: 16,
        mainAxisSpacing: 8,
      ),
      itemBuilder: (BuildContext context, int index) {
        return Row(
          children: [
            Checkbox(
              value: selectedDays[index],
              onChanged: (bool? newValue) {
                setState(() {
                  if (isWorkingDay) {
                    selectedWorkingDays[index] = newValue ?? false;
                  } else {
                    selectedOffDays[index] = newValue ?? false;
                  }
                });
              },
            ),
            Text(
              daysOfWeek[index],
              style: const TextStyle(fontSize: 16),
            ),
          ],
        );
      },
    );
  }
}

void showDialoge(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: false, // Prevent dismissing by tapping outside
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: AppColors.addedColor,
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomText(
              maxLines: 2,
              text: 'Employee Added Successfully',
              fontWeight: FontWeight.w500,
              fontSize: 25,
              color: AppColors.dark400,
            ),
            CustomText(
              maxLines: 5,
              text: 'Employees accounts details is sending to employee email :',
              fontWeight: FontWeight.w500,
              fontSize: 16,
              color: AppColors.dark400,
            ),
            CustomText(
              maxLines: 2,
              text: ' diannerussell@gmail.com',
              fontWeight: FontWeight.w900,
              fontSize: 16,
              color: AppColors.dark400,
            ),
            Row(
              children: [
                CustomText(
                  maxLines: 2,
                  text: ' Temporary Password',
                  fontWeight: FontWeight.w500,
                  fontSize: 10,
                  color: AppColors.dark400,
                ),
                CustomText(
                  maxLines: 2,
                  text: ' Masum017@@@',
                  fontWeight: FontWeight.w900,
                  fontSize: 12,
                  color: AppColors.dark400,
                ),
              ],
            ),
            SizedBox(
              height: 10.h,
            ),
            CustomButton(
              title: 'Send email',
              onTap: () {
                Get.back();
              },
              fillColor: Colors.white,
            ),
          ],
        ),
      );
    },
  );
}
