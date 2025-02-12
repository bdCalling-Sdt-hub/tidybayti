import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tidybayte/app/controller/owner_controller/add_employee_controller/add_employee_controller.dart';
import 'package:tidybayte/app/utils/app_colors/app_colors.dart';
import 'package:tidybayte/app/utils/app_const/app_const.dart';
import 'package:tidybayte/app/utils/app_strings/app_strings.dart';
import 'package:tidybayte/app/view/components/custom_button/custom_button.dart';
import 'package:tidybayte/app/view/components/custom_menu_appbar/custom_menu_appbar.dart';
import 'package:tidybayte/app/view/components/custom_netwrok_image/custom_network_image.dart';
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

  final AddEmployeeController controller = Get.find<AddEmployeeController>();
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
              ///==================================✅✅AeditEmployeeDetails Appbar✅✅=======================
              Column(
                children: [
                  CustomMenuAppbar(
                    title: AppStrings.editEmployeeDetails.tr,
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
                    CustomNetworkImage(
                        boxShape: BoxShape.circle,
                        imageUrl: AppConstants.userNtr,
                        height: 117,
                        width: 117),

                    SizedBox(
                      height: 20.h,
                    ),
                    CustomTextField(
                      hintText:AppStrings.firstName.tr,
                      fillColor: AppColors.employeeCardColor,
                    ),
                    SizedBox(
                      height: 8.h,
                    ),
                    CustomTextField(
                      hintText: AppStrings.lastName.tr,
                      fillColor: AppColors.employeeCardColor,
                    ),
                    SizedBox(
                      height: 8.h,
                    ),

                    ///==================================✅✅jobType✅✅=======================

                    Obx(() => CustomTextField(
                      textEditingController: controller.jobTypeController,
                      suffixIcon: PopupMenuButton<String>(
                        icon: const Icon(Icons.keyboard_arrow_down_rounded),
                        onSelected: (value) {
                          controller.updateJobType(value);
                        },
                        itemBuilder: (context) => [
                          const PopupMenuItem(
                            value: "Full Time",
                            child: Text("Full Time"),
                          ),
                          const PopupMenuItem(
                            value: "Part Time",
                            child: Text("Part Time"),
                          ),
                        ],
                      ),
                      hintText: controller.selectedJobType.value.isEmpty
                          ? AppStrings.jobType.tr
                          : controller.selectedJobType.value,
                      readOnly: true,
                      fillColor: AppColors.employeeCardColor,
                    )),
                    SizedBox(
                      height: 8.h,
                    ),

                    ///==================================✅✅cPR✅✅=======================

                    CustomTextField(
                      readOnly: true,
                      onTap: () {
                        controller.isCprOpen.value = !controller.isCprOpen.value;
                      },
                      suffixIcon: const Icon(Icons.keyboard_arrow_down_rounded),
                      hintText: AppStrings.cPR.tr,
                      fillColor: AppColors.employeeCardColor,
                    ),
                    SizedBox(
                      height: 8.h,
                    ),
                    Obx(() => controller.isCprOpen.value
                        ?  Column(
                      children: [
                        CustomTextField(
                          textEditingController: controller.cprNumberController,
                          hintText: AppStrings.cprNumber.tr,
                          fillColor: Colors.white,
                        ),
                        SizedBox(
                          height: 8.h,
                        ),
                        CustomTextField(
                          textEditingController: controller.cprExpireDateController,
                          readOnly: true,
                          hintText: AppStrings.expireDate.tr,
                          fillColor: Colors.white,
                          suffixIcon: const Icon(Icons.calendar_month),
                        ),
                      ],
                    )
                        : const SizedBox()),


                    ///==================================✅✅passport✅✅=======================

                    CustomTextField(
                      readOnly: true,
                      onTap: () {
                        controller.isPassportOpen.value = !controller.isPassportOpen.value;
                      },
                      suffixIcon: const Icon(Icons.keyboard_arrow_down_rounded),
                      hintText: AppStrings.passport.tr,
                      fillColor: AppColors.employeeCardColor,
                    ),
                    SizedBox(
                      height: 8.h,
                    ),
                    Obx(() => controller.isPassportOpen.value
                        ?  Column(
                      children: [
                        CustomTextField(
                          textEditingController: controller.passportController,
                          hintText: AppStrings.passportNumber.tr,
                          fillColor: Colors.white,
                        ),
                        SizedBox(
                          height: 8.h,
                        ),
                        CustomTextField(
                          textEditingController: controller.passportExpireDateController,
                          readOnly: true,
                          hintText: AppStrings.expireDate.tr,
                          fillColor: Colors.white,
                          suffixIcon: const Icon(Icons.calendar_month),
                        ),
                      ],
                    )
                        : const SizedBox()),

                    CustomTextField(
                      hintText: AppStrings.note.tr,
                      fillColor: AppColors.employeeCardColor,
                    ),
                    SizedBox(
                      height: 8.h,
                    ),
                    CustomTextField(
                      hintText: AppStrings.contactNumber.tr,
                      fillColor: AppColors.employeeCardColor,
                    ),
                    SizedBox(
                      height: 8.h,
                    ),


                    ///==================================✅✅Select working days✅✅=======================

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
                    ///==================================✅✅Select off days✅✅=======================

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
                    ///==================================✅✅upgradeProfile✅✅=======================

                    CustomButton(
                      onTap: () {
                        Get.back();
                      },
                      fillColor: Colors.white,
                      title: AppStrings.upgradeProfile.tr,
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
