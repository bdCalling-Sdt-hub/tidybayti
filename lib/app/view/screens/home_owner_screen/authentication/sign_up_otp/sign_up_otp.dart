import 'dart:async';
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
import 'package:tidybayte/app/view/components/custom_text/custom_text.dart';
import 'package:tidybayte/app/view/components/custom_text_field/custom_text_field.dart';

class SignUpOtp extends StatefulWidget {
  const SignUpOtp({super.key});

  @override
  State<SignUpOtp> createState() => _SignUpOtpState();
}

class _SignUpOtpState extends State<SignUpOtp> {
  final formKey = GlobalKey<FormState>();
  final AuthController authController = Get.find<AuthController>();

  final RxInt _secondsRemaining = 60.obs;
  Timer? _timer;

  void startTimer() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_secondsRemaining.value > 0) {
        _secondsRemaining.value--;
      } else {
        _timer?.cancel();
      }
    });
  }

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _resendOtp() {
    if (_secondsRemaining.value == 0) {
      _secondsRemaining.value = 60;
      startTimer();

      authController.resendOtp().then((value) {
        if (!value) {
          _secondsRemaining.value = 0;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        return SingleChildScrollView(
          child: Stack(
            children: [
              // 🔹 Background Image
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
                    padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
                    child: Form(
                      key: formKey,
                      child: Column(
                        children: [
                          const CustomMenuAppbar(title: ''),
                          SizedBox(
                            height: MediaQuery.of(context).size.height / 3,
                          ),

                          ///=============================Enter 6 Digit Code====================
                          CustomTextField(
                            hintText: AppStrings.enterSIxDegit.tr,
                            textEditingController: authController.otpController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return AppStrings.fieldCantBeEmpty;
                              }
                              return null;
                            },
                          ),

                          SizedBox(height: 16.h),

                          Align(
                            alignment: Alignment.centerRight,
                            child: GestureDetector(
                              onTap: _secondsRemaining.value == 0 ? _resendOtp : null,
                              child: CustomText(
                                text: _secondsRemaining.value == 0
                                    ? "Resend OTP"
                                    : "Resend OTP in ${_secondsRemaining.value} seconds",
                                color: AppColors.dark300,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),

                          SizedBox(height: 16.h),

                          ///============================Verify Code=============
                          Obx(() => authController.isSignUpOtp.value
                              ? const CustomLoader()
                              : CustomButton(
                            onTap: () {
                              if (formKey.currentState!.validate()) {
                                authController.signUpOtp();
                              }
                            },
                            fillColor: AppColors.employeeCardColor,
                            title: AppStrings.verifyCode.tr,
                          )),
                        ],
                      ),
                    ),
                  )),
            ],
          ),
        );
      }),
    );
  }
}
