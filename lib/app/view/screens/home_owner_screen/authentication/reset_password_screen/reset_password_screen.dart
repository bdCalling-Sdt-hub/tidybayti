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
import 'package:tidybayte/app/view/components/custom_task_details_dialoge/custom_task_details_dialoge.dart';
import 'package:tidybayte/app/view/components/custom_text/custom_text.dart';
import 'package:tidybayte/app/view/components/custom_text_field/custom_text_field.dart';

class ResetPasswordScreen extends StatelessWidget {
  const ResetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            // Background Image
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Image.asset(
                AppImages.signInBackground,
                fit: BoxFit.cover,
              ),
            ),

            Positioned(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 282.h,
                      ),

                      ///=============================Enter Password====================
                      const CustomTextField(
                        hintText: AppStrings.enterPassword,
                        isPassword: true,
                      ),


                      SizedBox(
                        height: 10.h,
                      ),    ///=============================confirmPassword====================
                      const CustomTextField(
                        hintText: AppStrings.confirmPassword,
                        isPassword: true,
                      ),


                      SizedBox(
                        height: 40.h,
                      ),

                      ///============================Update Password=============
                      CustomButton(onTap: (){
                        Get.toNamed(AppRoutes.signInScreen);
                      },
                        fillColor: AppColors.employeeCardColor,
                        title:AppStrings.updatePassword,
                      ),



                    ],
                  ),
                )),

          ],
        ),
      ),
    );
  }
}
