import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tidybayte/app/core/app_routes/app_routes.dart';
import 'package:tidybayte/app/global/helper/shared_prefe/shared_prefe.dart';
import 'package:tidybayte/app/utils/app_colors/app_colors.dart';
import 'package:tidybayte/app/utils/app_const/app_const.dart';
import 'package:tidybayte/app/utils/app_icons/app_icons.dart';
import 'package:tidybayte/app/utils/app_strings/app_strings.dart';

import 'package:tidybayte/app/view/components/custom_menu_item/custom_menu_item.dart';
import 'package:tidybayte/app/view/components/custom_text/custom_text.dart';
import 'package:tidybayte/app/view/components/nav_bar/nav_bar.dart';

class MenuScreen extends StatelessWidget {
  const MenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const NavBar(currentIndex: 4),
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
          child: Column(
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ///=============================== Menu Title ========================
               Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CustomText(
                    top: 20,
                    textAlign: TextAlign.center,
                    text: AppStrings.account.tr,
                    fontWeight: FontWeight.w500,
                    fontSize: 24,
                    color: AppColors.dark500,
                  ),
                ],
              ),

              ///=============================== Menu Items ========================
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.all(16.0),
                  children: [
                    ///================================Personal Information=================
                    CustomMenuItem(
                      image: AppIcons.person,
                      text: AppStrings.personalInformation.tr,
                      onTap: () {
                        Get.toNamed(AppRoutes.personalInfoScreen);
                      },
                    ),

                    ///===============================upgradePackages=================
                    CustomMenuItem(
                      image: AppIcons.pacages,
                      text: AppStrings.upgradePackages.tr,
                      onTap: () {
                        Get.toNamed(AppRoutes.upgradePackages);
                      },
                    ),

                    ///================================myPlan=================
                    CustomMenuItem(
                      image: AppIcons.pacages,
                      text: AppStrings.myPlan.tr,
                      onTap: () {
                        Get.toNamed(AppRoutes.myPlanScreen);
                      },
                    ),

                    ///================================Settings=================
                    CustomMenuItem(
                      image: AppIcons.setting,
                      text: AppStrings.settings.tr,
                      onTap: () {
                        Get.toNamed(AppRoutes.settingScreen);
                      },
                    ),

                    ///================================Language=================
                    CustomMenuItem(
                      image: AppIcons.tLanguage,
                      text: AppStrings.language.tr,
                      onTap: () {
                        Get.toNamed(AppRoutes.languageScreen);
                      },
                    ),

                    ///================================logOut=================
                    CustomMenuItem(
                      image: AppIcons.logOut,
                      text: AppStrings.logOut.tr,
                      onTap: () async {
                        await SharePrefsHelper.remove(AppConstants.token);
                        await SharePrefsHelper.remove(AppConstants.profileID);
                        SharePrefsHelper.setBool(
                            AppConstants.rememberMe, false);
                        SharePrefsHelper.setBool(AppConstants.isOwner, false);
                        Get.offAllNamed(AppRoutes.choseOnBoardingScreen);
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
