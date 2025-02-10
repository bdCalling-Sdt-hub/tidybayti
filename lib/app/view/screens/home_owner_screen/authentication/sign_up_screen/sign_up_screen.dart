import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tidybayte/app/core/app_routes/app_routes.dart';
import 'package:tidybayte/app/global/controller/auth_controller.dart';
import 'package:tidybayte/app/utils/app_colors/app_colors.dart';
import 'package:tidybayte/app/utils/app_images/app_images.dart';
import 'package:tidybayte/app/utils/app_strings/app_strings.dart';
import 'package:tidybayte/app/view/components/custom_button/custom_button.dart';
import 'package:tidybayte/app/view/components/custom_loader/custom_loader.dart';
import 'package:tidybayte/app/view/components/custom_rech_text/custom_rich_text.dart';
import 'package:tidybayte/app/view/components/custom_text_field/custom_text_field.dart';

import '../../../../components/custom_menu_appbar/custom_menu_appbar.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({super.key});

  final AuthController authController = Get.find<AuthController>();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        return Form(
          key: formKey,
          child: Stack(
            children: [
              ///================== Background Image ====================
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: Image.asset(
                  AppImages.signInBackground,
                  fit: BoxFit.cover,
                ),
              ),

              ///================== SignUp Form ====================
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 40.h),
                child: SingleChildScrollView(
                  clipBehavior: Clip.none,
                  child: Column(
                    children: [
                      const CustomMenuAppbar(title: ''),

                      SizedBox(height: 50.h),

                      ///================ First Name ====================
                      CustomTextField(
                        hintText: AppStrings.firstName.tr,
                        fillColor: AppColors.employeeCardColor,
                        textEditingController: authController.firstNameController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return AppStrings.fieldCantBeEmpty;
                          } else if (value.length < 3) {
                            return AppStrings.enterAValidName;
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 10.h),

                      ///================ Last Name ====================
                      CustomTextField(
                        hintText: AppStrings.lastName.tr,
                        textEditingController: authController.lastNameController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return AppStrings.fieldCantBeEmpty;
                          } else if (value.length < 3) {
                            return AppStrings.enterAValidName;
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 10.h),

                      ///================ Contact Number ====================
                      CustomTextField(
                        hintText: AppStrings.contactNumber.tr,
                        textEditingController: authController.phoneNumberController,
                        keyboardType: TextInputType.phone,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return AppStrings.fieldCantBeEmpty;
                          } else if (!RegExp(r'^[0-9]{10,15}$').hasMatch(value)) {
                            return "Enter a valid phone number";
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 10.h),

                      ///================ Email ====================
                      CustomTextField(
                        hintText: AppStrings.email.tr,
                        textEditingController: authController.emailController,
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return AppStrings.enterValidEmail;
                          } else if (!AppStrings.emailRegexp.hasMatch(value)) {
                            return AppStrings.enterValidEmail;
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 10.h),

                      ///================ Password ====================
                      CustomTextField(
                        hintText: AppStrings.password.tr,
                        isPassword: true,
                        textEditingController: authController.passwordController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return AppStrings.passwordMustHaveEightWith;
                          } else if (value.length < 8 || !AppStrings.passRegexp.hasMatch(value)) {
                            return AppStrings.passwordLengthAndContain;
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 10.h),

                      ///================ Confirm Password ====================
                      CustomTextField(
                        hintText: AppStrings.confirmPassword.tr,
                        isPassword: true,
                        textEditingController: authController.confirmPasswordController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return AppStrings.fieldCantBeEmpty;
                          } else if (value != authController.passwordController.text) {
                            return "Password should match";
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 24.h),

                      ///================ Create Account Button ====================
                      authController.signUpLoading.value
                          ? const CustomLoader()
                          : CustomButton(
                        onTap: () {
                          if (formKey.currentState!.validate()) {
                            authController.signup();
                          }
                        },
                        fillColor: AppColors.employeeCardColor,
                        title: AppStrings.createAccount.tr,
                      ),
                      SizedBox(height: 20.h),

                      ///================ Already Have an Account ====================
                      CustomRichTextLink(
                        firstText: AppStrings.alreadyHaveAnYAccount.tr,
                        linkText: AppStrings.signIn.tr,
                        onTap: () => Get.toNamed(AppRoutes.signInScreen),
                      ),
                      SizedBox(height: 30.h),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
