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
class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key});

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
          child: SingleChildScrollView(
            child: Column(
              // crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ///=============================== editProfile ========================
                CustomMenuAppbar(
                  title: AppStrings.editProfile,
                  onBack: () {
                    Get.back();
                  },
                ),

                Padding(
                  padding:  EdgeInsets.symmetric(horizontal: 20.w),
                  child: Column(
                    children: [
                      ///============================FirstName================
                      const CustomTextField(
                        hintText: AppStrings.firstName,
                      ),
                       SizedBox(
                        height: 10.h,
                      ),
                      ///============================LastName================
                      const CustomTextField(
                        hintText: AppStrings.lastName,
                      ),
                       SizedBox(
                        height: 10.h,
                      ),
                      ///==========================Contact Number============
                      const CustomTextField(
                        hintText: AppStrings.contactNo,
                      ),
                       SizedBox(
                        height: 10.h,
                      ),

                      // ///==========================Address====================
                      // const CustomTextField(
                      //   hintText: AppStrings.address,
                      // ),
                       SizedBox(
                        height: 247.h,
                      ),
                      ///============================Button Here=================
                      CustomButton(
                          onTap: (){
                         Get.back();
                      },
                      fillColor: AppColors.employeeCardColor,
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
