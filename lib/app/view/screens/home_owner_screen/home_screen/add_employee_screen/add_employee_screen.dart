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
import 'package:tidybayte/app/view/components/custom_text/custom_text.dart';
import 'package:tidybayte/app/view/components/custom_text_field/custom_text_field.dart';
import 'package:tidybayte/app/view/components/nav_bar/nav_bar.dart';

class AddEmployeeScreen extends StatefulWidget {
  const AddEmployeeScreen({super.key});

  @override
  State<AddEmployeeScreen> createState() => _AddEmployeeScreenState();
}

class _AddEmployeeScreenState extends State<AddEmployeeScreen> {
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
              ///==================================✅✅Add Employee Tiitle✅✅=======================
              CustomMenuAppbar(
                title: AppStrings.addEmployee.tr,
                onBack: () {
                  Get.back();
                },
              ),

              ///==================================✅✅Employee Image✅✅=======================
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.all(16.0),
                  children: [
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipOval(
                          child: SizedBox(
                            width: 117, // specify width
                            height: 117, // specify height
                            child: CustomImage(
                              imageSrc: AppImages.avatar,
                              imageType: ImageType.png,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20.h,
                    ),

                    ///==================================✅✅Employee Personal List✅✅=======================

                     CustomTextField(
                      hintText: AppStrings.firstName.tr,
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

                     CustomTextField(
                      suffixIcon: const Icon(Icons.keyboard_arrow_down_rounded),
                      hintText: AppStrings.jobType.tr,
                      readOnly: true,
                      fillColor: AppColors.employeeCardColor,
                    ),
                    SizedBox(
                      height: 8.h,
                    ),
                    ///==================================✅✅cPR✅✅=======================

                     CustomTextField(
                      suffixIcon: const Icon(Icons.keyboard_arrow_down_rounded),
                      hintText: AppStrings.cPR.tr,
                      fillColor: AppColors.employeeCardColor,
                    ),
                    SizedBox(
                      height: 8.h,
                    ),
                    ///==================================✅✅passport✅✅=======================
                    CustomTextField(
                      suffixIcon: const Icon(Icons.keyboard_arrow_down_rounded),
                      hintText: AppStrings.passport.tr,
                      fillColor: AppColors.employeeCardColor,
                    ),
                    SizedBox(
                      height: 8.h,
                    ),
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


                    ///==================================✅✅email✅✅=======================

                    SizedBox(
                      height: 8.h,
                    ),
                     CustomTextField(
                      hintText: AppStrings.email.tr,
                      fillColor: AppColors.employeeCardColor,
                    ),
                    SizedBox(
                      height: 8.h,
                    ),
                    ///==================================✅✅temporaryPassword✅✅=======================

                     CustomTextField(
                      hintText: AppStrings.temporaryPassword.tr,
                      fillColor: AppColors.employeeCardColor,
                      isPassword: true,
                    ),
                    SizedBox(
                      height: 15.h,
                    ),
                    ///==================================✅✅addNewEmployee Button✅✅=======================

                    CustomButton(
                      onTap: () {
                        showDialoge(context);
                      },
                      fillColor: Colors.white,
                      title: AppStrings.addNewEmployee.tr,
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
}

void showDialoge(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: false, // Prevent dismissing by tapping outside
    builder: (BuildContext context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
              Radius.circular(5.0)), // Adjust the radius as needed
        ),
        backgroundColor: AppColors.addedColor,
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: 16.h,
            ),
            Container(
              height: 96,
              width: 96,
              decoration: const BoxDecoration(
                color: AppColors.blue900,
                shape: BoxShape.circle,
              ),
              child: Center(
                  child: CustomImage(
                imageSrc: AppIcons.rightUp,
              )),
            ),
            CustomText(
              top: 24,
              bottom: 40,
              maxLines: 2,
              text: 'Employee Added Successfully',
              fontWeight: FontWeight.w400,
              fontSize: 24,
              color: AppColors.successFullyColor,
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
              bottom: 20,
              text: ' diannerussell@gmail.com',
              fontWeight: FontWeight.w700,
              fontSize: 16,
              color: AppColors.dark400,
            ),
            Row(
              children: [
                CustomText(
                  maxLines: 2,
                  text: ' Temporary Password:',
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                  color: AppColors.dark400,
                ),
                CustomText(
                  maxLines: 2,
                  text: ' Masum017@@@',
                  fontWeight: FontWeight.w700,
                  fontSize: 12,
                  color: AppColors.dark400,
                ),
              ],
            ),
            SizedBox(
              height: 48.h,
            ),

            ///==============================Send Email==================

            CustomButton(
              title: 'Send email',
              onTap: () {
                Get.toNamed(AppRoutes.mainSentSuccessfullyScreen);
              },
              fillColor: Colors.white,
            ),
            SizedBox(
              height: 15.h,
            ),
          ],
        ),
      );
    },
  );
}
