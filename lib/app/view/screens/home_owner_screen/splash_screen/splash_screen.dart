import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tidybayte/app/core/app_routes/app_routes.dart';
import 'package:tidybayte/app/global/helper/shared_prefe/shared_prefe.dart';
import 'package:tidybayte/app/utils/app_colors/app_colors.dart';
import 'package:tidybayte/app/utils/app_const/app_const.dart';
import 'package:tidybayte/app/view/components/custom_loader/custom_loader.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  navigateScreen() async {
    bool? isRememberMe =
    await SharePrefsHelper.getBool(AppConstants.rememberMe);
    bool? isEmployee = await SharePrefsHelper.getBool(AppConstants.isOwner);

    if (isRememberMe == null || isRememberMe == false) {
      Get.offAndToNamed(AppRoutes.onboardScreen);
    } else if (isRememberMe && isEmployee!) {
      Get.offAllNamed(AppRoutes.homeScreen);
    } else if (isRememberMe && isEmployee == false) {
      Get.offAllNamed(AppRoutes.employeeHomeScreen);
    }
  }

  @override
  void initState() {
    Timer(const Duration(seconds: 2), () {
      navigateScreen();
    });
    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: AppColors.blue500,
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 24, horizontal: 20),
        child: Center(
          child: CustomLoader()
        ),
      ),
    );
  }
}