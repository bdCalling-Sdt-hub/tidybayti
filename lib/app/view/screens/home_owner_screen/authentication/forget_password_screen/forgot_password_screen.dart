import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tidybayte/app/global/controller/auth_controller.dart';
import 'package:tidybayte/app/utils/app_colors/app_colors.dart';
import 'package:tidybayte/app/utils/app_images/app_images.dart';
import 'package:tidybayte/app/utils/app_strings/app_strings.dart';
import 'package:tidybayte/app/view/components/custom_button/custom_button.dart';
import 'package:tidybayte/app/view/components/custom_loader/custom_loader.dart';
import 'package:tidybayte/app/view/components/custom_menu_appbar/custom_menu_appbar.dart';
import 'package:tidybayte/app/view/components/custom_text_field/custom_text_field.dart';

class ForgotPasswordScreen extends StatelessWidget {
  ForgotPasswordScreen({super.key});

  final AuthController authController = Get.find<AuthController>();
  final formKey = GlobalKey<FormState>();

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
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
              child: Obx(() {
                return Form(
                  key: formKey,
                  child: Column(
                    children: [
                      const CustomMenuAppbar(title: ''),

                      SizedBox(
                        height: MediaQuery.of(context).size.height / 3,
                      ),

                      ///=============================Email=====================
                      CustomTextField(
                        hintText: AppStrings.emailForVerification.tr,
                        textEditingController: authController.emailController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return AppStrings.enterValidEmail;
                          } else if (!AppStrings.emailRegexp.hasMatch(value)) {
                            return AppStrings.enterValidEmail;
                          }
                          return null;
                        },
                      ),

                      SizedBox(
                        height: 24.h,
                      ),

                      ///============================Send Email=============

                      authController.isForgetLoading.value
                          ? const CustomLoader()
                          : CustomButton(
                              onTap: () {
                                if (formKey.currentState!.validate()) {
                                  authController.forgetEmail();
                                }
                              },
                              fillColor: AppColors.employeeCardColor,
                              title: AppStrings.sendEmail.tr,
                            ),
                    ],
                  ),
                );
              }),
            )),
          ],
        ),
      ),
    );
  }
}
