import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tidybayte/app/core/app_routes/app_routes.dart';
import 'package:tidybayte/app/utils/app_colors/app_colors.dart';
import 'package:tidybayte/app/utils/app_const/app_const.dart';
import 'package:tidybayte/app/utils/app_icons/app_icons.dart';
import 'package:tidybayte/app/utils/app_strings/app_strings.dart';
import 'package:tidybayte/app/view/components/custom_button/custom_button.dart';
import 'package:tidybayte/app/view/components/custom_image/custom_image.dart';
import 'package:tidybayte/app/view/components/custom_menu_appbar/custom_menu_appbar.dart';
import 'package:tidybayte/app/view/components/custom_netwrok_image/custom_network_image.dart';
import 'package:tidybayte/app/view/components/custom_task_details_dialoge/custom_task_details_dialoge.dart';
import 'package:tidybayte/app/view/components/custom_text/custom_text.dart';
import 'package:tidybayte/app/view/components/custom_text_field/custom_text_field.dart';

class EmployeeEditProfile extends StatelessWidget {
  const EmployeeEditProfile({super.key});

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
          child: SingleChildScrollView(
            child: Column(
              // crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                ///=============================== profile Appbar ========================
                CustomMenuAppbar(
                  onTap: () {
                    Get.toNamed(AppRoutes.employeeEditProfile);
                  },
                  isEdit: false,
                  title: AppStrings.editProfile,
                  onBack: () {
                    Get.back();
                  },
                ),

                ///==========================Body Here=====================
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      Center(
                        child: CustomNetworkImage(
                          boxShape: BoxShape.circle,
                          imageUrl: AppConstants.employee,
                          height: 126,
                          width: 116),
                      ),
                      SizedBox(
                        height: 8.h,
                      ),
                      ///==============================Name Here=====================
                      CustomTextField(
                        textEditingController:
                        TextEditingController(text: 'Habib'),
                      ),
                      SizedBox(
                        height: 8.h,
                      ),

                      ///=================================Location Here===============
                      CustomTextField(
                        textEditingController:
                        TextEditingController(text: 'Dhaka'),
                      ),
                      SizedBox(
                        height: 8.h,
                      ),

                      ///===============================Phone Number Here=================
                      CustomTextField(
                        textEditingController:
                        TextEditingController(text: '+2222222222'),
                      ),
                      SizedBox(
                        height: 175.h,
                      ),

                      ///=======================Save And Changes Button============
                      CustomButton(
                        onTap: () {
                          Get.back();
                        },
                        fillColor: AppColors.blue50,
                        title: AppStrings.saveAndChange,
                      )
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




