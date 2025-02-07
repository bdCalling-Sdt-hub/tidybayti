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
import 'package:tidybayte/app/view/components/nav_bar/nav_bar.dart';

class EditEmployeeDetails extends StatefulWidget {
  const EditEmployeeDetails({super.key});

  @override
  State<EditEmployeeDetails> createState() => _AddEmployeeScreenState();
}

class _AddEmployeeScreenState extends State<EditEmployeeDetails> {
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
              Column(
                children: [
                  CustomMenuAppbar(
                    title: AppStrings.editEmployeeDetails,
                    onBack: () {
                      Get.back();
                    },
                  ),
                ],
              ),

              ///=============================== Employee List ========================
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.all(16.0),
                  children: [
                    // CustomNetworkImage(
                    //     boxShape: BoxShape.circle,
                    //     imageUrl: AppConstants.userNtr,
                    //     height: 117,
                    //     width: 117),
                    const Center(
                      child: ClipOval(
                        child: SizedBox(
                          width: 117.0, // specify width
                          height: 117.0, // specify height
                          child: CustomImage(
                            imageSrc: AppImages.avatar,
                            imageType: ImageType.png,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    CustomTextField(
                      hintText:"First Name",
                      fillColor: AppColors.employeeCardColor,
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    CustomTextField(
                      hintText: "Last Name",
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
                      hintText: "Note",
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
                    // CustomTextField(
                    //   hintText: AppStrings.address,
                    //   fillColor: AppColors.employeeCardColor,
                    // ),

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

                    const CustomText(
                      textAlign: TextAlign.start,
                      bottom: 24,
                      text: 'Select off days',
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                      color: AppColors.dark400,
                    ),
                    _buildDaySelectionGrid(selectedOffDays, false),

                    const SizedBox(
                      height: 15,
                    ),
                    CustomButton(
                      onTap: () {
                        Get.back();
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
      physics: const NeverScrollableScrollPhysics(),
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
              activeColor: AppColors.blue900,
              checkColor: AppColors.light200,
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
