import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tidybayte/app/global/controller/auth_controller.dart';
import 'package:tidybayte/app/utils/app_colors/app_colors.dart';
import 'package:tidybayte/app/utils/app_images/app_images.dart';
import 'package:tidybayte/app/utils/app_strings/app_strings.dart';
import 'package:tidybayte/app/view/components/custom_button/custom_button.dart';
import 'package:tidybayte/app/view/components/custom_loader/custom_loader.dart';
import 'package:tidybayte/app/view/components/custom_text_field/custom_text_field.dart';

class ResetPasswordScreen extends StatelessWidget {
  ResetPasswordScreen({super.key});

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
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Obx(() {
                return Form(
                  key: formKey,
                  child: Column(
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 3,
                      ),

                      ///=============================Enter Password====================
                      CustomTextField(
                        hintText: AppStrings.enterPassword.tr,
                        textEditingController:
                            authController.newPasswordController,
                        isPassword: true,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return AppStrings.passwordMustHaveEightWith;
                          } else if (value.length < 8 ||
                              !AppStrings.passRegexp.hasMatch(value)) {
                            return AppStrings.passwordLengthAndContain;
                          }
                          return null;
                        },
                      ),

                      SizedBox(
                        height: 10.h,
                      ),

                      ///=============================confirmPassword====================
                      CustomTextField(
                        hintText: AppStrings.confirmPassword.tr,
                        isPassword: true,
                        textEditingController:
                            authController.confirmPasswordController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return AppStrings.fieldCantBeEmpty;
                          } else if (value !=
                              authController.newPasswordController.text) {
                            return "Password should match";
                          }
                          return null;
                        },
                      ),

                      SizedBox(
                        height: 40.h,
                      ),

                      ///============================Update Password=============
                      authController.isResetLoading.value
                          ? const CustomLoader()
                          : CustomButton(
                              onTap: () {
                                if (formKey.currentState!.validate()) {
                                  authController.resetPassword();
                                }
                              },
                              fillColor: AppColors.employeeCardColor,
                              title: AppStrings.updatePassword.tr,
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
