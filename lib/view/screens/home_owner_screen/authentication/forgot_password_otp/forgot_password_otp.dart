import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tidybayte/core/app_routes/app_routes.dart';
import 'package:tidybayte/utils/app_colors/app_colors.dart';
import 'package:tidybayte/utils/app_images/app_images.dart';
import 'package:tidybayte/utils/app_strings/app_strings.dart';
import 'package:tidybayte/view/components/custom_button/custom_button.dart';
import 'package:tidybayte/view/components/custom_text_field/custom_text_field.dart';

class ForgotPasswordOtp extends StatelessWidget {
  const ForgotPasswordOtp({super.key});

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
                        height: 334.h,
                      ),

                      ///=============================Enter 6 Degit code====================
                      const CustomTextField(
                        hintText: AppStrings.enterSIxDegit,
                      ),


                      SizedBox(
                        height: 24.h,
                      ),

                      ///============================Verify Code=============
                      CustomButton(onTap: (){
                        Get.toNamed(AppRoutes.resetPasswordScreen);
                      },
                        fillColor: AppColors.employeeCardColor,
                        title:AppStrings.verifyCode,
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
