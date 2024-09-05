import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tidybayte/utils/app_colors/app_colors.dart';
import 'package:tidybayte/utils/app_strings/app_strings.dart';
import 'package:tidybayte/view/components/custom_button/custom_button.dart';

import 'package:tidybayte/view/components/custom_menu_appbar/custom_menu_appbar.dart';
import 'package:tidybayte/view/components/custom_text_field/custom_text_field.dart';
import 'package:tidybayte/view/components/nav_bar/nav_bar.dart';

class ChangePasswordScreen extends StatelessWidget {
  const ChangePasswordScreen({super.key});

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
          child: SingleChildScrollView(
            child: Column(
              // crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ///=============================== Change Password  Appbar========================
                CustomMenuAppbar(
                  title: AppStrings.changePassword,
                  onBack: () {
                    Get.back();
                  },
                ),

                ///=============================== aboutUs ========================
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 130.h,
                        ),
                        ///========================Present Password===================
                        const CustomTextField(
                          hintText: AppStrings.presentPassword,
                        ),
                        SizedBox(
                          height: 40.h,
                        ),

                        ///=================================New Password===============
                        const CustomTextField(
                          hintText: AppStrings.newPassword,
                        ),
                        SizedBox(
                          height: 16.h,
                        ),
                        ///==========================Confirm Password==================
                        const CustomTextField(
                          hintText: AppStrings.confirmPassword,
                        ),
                        SizedBox(
                          height: 40.h,
                        ),


                        ///=====================================Button================
                        CustomButton(
                          onTap: (){

                        },
                          title: AppStrings.confirmPassword,
                        fillColor: AppColors.employeeCardColor,
                        ),

                      ],
                    ),
                  )
              ],
            ),
          ), 
        ),
      ),
    );
  }
}
