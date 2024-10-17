import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tidybayte/core/app_routes/app_routes.dart';
import 'package:tidybayte/utils/app_colors/app_colors.dart';
import 'package:tidybayte/utils/app_const/app_const.dart';
import 'package:tidybayte/utils/app_images/app_images.dart';
import 'package:tidybayte/utils/app_strings/app_strings.dart';
import 'package:tidybayte/view/components/custom_image/custom_image.dart';
import 'package:tidybayte/view/components/custom_menu_appbar/custom_menu_appbar.dart';
import 'package:tidybayte/view/components/custom_netwrok_image/custom_network_image.dart';
import 'package:tidybayte/view/components/custom_text/custom_text.dart';
import 'package:tidybayte/view/components/custom_text_field/custom_text_field.dart';
import 'package:tidybayte/view/components/nav_bar/nav_bar.dart';

class AllEmployeeShow extends StatelessWidget {
  const AllEmployeeShow({super.key});

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
                title: AppStrings.employees,
                onBack: () {
                  Get.back();
                },
              ),

              ///=============================== Employee List ========================
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.all(16.0),
                  children: [
                    /// Add Employee Text Field
                    CustomTextField(
                      fillColor: AppColors.blue50,
                      readOnly: true,
                      onTap: () {
                        Get.toNamed(AppRoutes.addEmployeeScreen);
                      },
                      hintText: AppStrings.addEmployee,
                      prefixIcon: const Icon(Icons.add),
                    ),

                    const SizedBox(height: 16), // Spacing between text field and list

                    // Sample Employee Card
                    GestureDetector(
                        onTap: (){
                          Get.toNamed(AppRoutes.employeeDetails);
                        },
                        child: _buildEmployeeCard(context)),
                    _buildEmployeeCard(context),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEmployeeCard(BuildContext context) {
    return Card(
      color:AppColors.normal,
      elevation: 2, // Added elevation for better visibility
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12), // Rounded corners
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10), // Padding inside card
        child: Row(
          children: [
            // Employee Image
            // CustomNetworkImage(
            //   imageUrl: AppConstants.userNtr,
            //   height: 53.h,
            //   width: 53.w,
            //   boxShape: BoxShape.circle,
            // ),
            const ClipOval(
              child: SizedBox(
                width: 53.0, // specify width
                height: 53.0, // specify height
                child: CustomImage(
                  imageSrc: AppImages.avatar,
                  imageType: ImageType.png,
                ),
              ),
            ),

            SizedBox(width: 10.w),
            // Employee Info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween, // Space between name and icon
                    children: [
                      const CustomText(
                        text: 'Name:',
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                        color: AppColors.dark400,
                      ),

                      IconButton(
                        onPressed: () {
                          Get.toNamed(AppRoutes.employeeDetails);
                        },
                        icon: const Icon(Icons.info_outline),
                      ),
                    ],
                  ),
                  CustomText(
                    text: 'Designation: Assistant',
                    fontWeight: FontWeight.w400,
                    fontSize: 14.sp,
                    color: AppColors.dark300,
                  ),
                  CustomText(
                    text: 'Id: 123456789',
                    fontWeight: FontWeight.w400,
                    fontSize: 14.sp,
                    color: AppColors.dark400,
                  ),

                  CustomText(
                    text: 'Email:',
                    fontWeight: FontWeight.w400,
                    fontSize: 14.sp,
                    color: AppColors.dark400,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
