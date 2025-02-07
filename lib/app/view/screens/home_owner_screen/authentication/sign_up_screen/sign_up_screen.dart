import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tidybayte/app/core/app_routes/app_routes.dart';
import 'package:tidybayte/app/global/controller/auth_controller.dart';
import 'package:tidybayte/app/utils/app_colors/app_colors.dart';
import 'package:tidybayte/app/utils/app_images/app_images.dart';
import 'package:tidybayte/app/utils/app_strings/app_strings.dart';
import 'package:tidybayte/app/view/components/custom_button/custom_button.dart';
import 'package:tidybayte/app/view/components/custom_rech_text/custom_rich_text.dart';
import 'package:tidybayte/app/view/components/custom_text_field/custom_text_field.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({super.key});

  final AuthController authController = Get.find<AuthController>();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: formKey,
        child: SingleChildScrollView(
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
                      height: 88.h,
                    ),

                    ///=============================First Name=====================
                    CustomTextField(
                      hintText: AppStrings.firstName.tr,
                      fillColor: AppColors.employeeCardColor,
                      textEditingController: authController.firstNameController,
                      validator: (value) {
                        if (value == null || value.toString().isEmpty) {
                          return AppStrings.fieldCantBeEmpty;
                        } else if (value.length < 4) {
                          return AppStrings.enterAValidName;
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 10.h,
                    ),

                    ///===========================Last Name======================
                    CustomTextField(
                      hintText: AppStrings.lastName.tr,
                      textEditingController: authController.lastNameController,
                      validator: (value) {
                        if (value == null || value.toString().isEmpty) {
                          return AppStrings.fieldCantBeEmpty;
                        } else if (value.length < 4) {
                          return AppStrings.enterAValidName;
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 10.h,
                    ),

                    ///===========================Contact Number======================
                    CustomTextField(
                      hintText: AppStrings.contactNumber.tr,
                      textEditingController:
                          authController.phoneNumberController,
                      validator: (value) {
                        if (value == null || value.toString().isEmpty) {
                          return AppStrings.fieldCantBeEmpty;
                        }
                        return null;
                      },
                    ),

                    SizedBox(
                      height: 10.h,
                    ),

                    ///===========================Email======================
                    CustomTextField(
                      hintText: AppStrings.email.tr,
                      textEditingController: authController.emailController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return AppStrings.enterValidEmail;
                        } else if (!AppStrings.emailRegexp
                            .hasMatch(authController.emailController.text)) {
                          return AppStrings.enterValidEmail;
                        } else {
                          return null;
                        }
                      },
                    ),
                    SizedBox(
                      height: 10.h,
                    ),

                    ///===========================Password======================
                    CustomTextField(
                      hintText: AppStrings.password.tr,
                      isPassword: true,
                      textEditingController: authController.passwordController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return AppStrings.passwordMustHaveEightWith;
                        } else if (value.length < 8 ||
                            !AppStrings.passRegexp.hasMatch(value)) {
                          return AppStrings.passwordLengthAndContain;
                        } else {
                          return null;
                        }
                      },
                    ),
                    SizedBox(
                      height: 10.h,
                    ),

                    ///===========================Confirm Password======================
                    CustomTextField(
                      hintText: AppStrings.confirmPassword.tr,
                      isPassword: true,
                      textEditingController:
                          authController.confirmPasswordController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return AppStrings.fieldCantBeEmpty;
                        } else if (value !=
                            authController.passwordController.text) {
                          return "Password should match";
                        }
                        return null;
                      },
                    ),

                    SizedBox(
                      height: 24.h,
                    ),

                    ///============================Create Account=============
                    CustomButton(
                      onTap: () {
                        if (formKey.currentState!.validate()) {
                          authController.signup();
                        }
                      },
                      fillColor: AppColors.employeeCardColor,
                      title: AppStrings.createAccount.tr,
                    ),
                    SizedBox(
                      height: 48.h,
                    ),

                    ///==============================Dont Have=============
                    CustomRichTextLink(
                      firstText: AppStrings.alreadyHaveAnYAccount.tr,
                      linkText: AppStrings.signIn.tr,
                      onTap: () {
                        Get.toNamed(AppRoutes.signInScreen);
                      },
                    )
                  ],
                ),
              )),
            ],
          ),
        ),
      ),
    );
  }
}
