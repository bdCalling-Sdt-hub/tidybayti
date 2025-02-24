import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tidybayte/app/core/app_routes/app_routes.dart';
import 'package:tidybayte/app/utils/app_icons/app_icons.dart';
import 'package:tidybayte/app/utils/app_strings/app_strings.dart';

import 'package:tidybayte/app/view/components/custom_menu_appbar/custom_menu_appbar.dart';
import 'package:tidybayte/app/view/components/custom_menu_item/custom_menu_item.dart';


class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
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
              ///=============================== settings ========================
              CustomMenuAppbar(
                title: AppStrings.settings.tr,
                onBack: () {
                  Get.back();
                },
              ),

              ///=============================== Settings Items ========================
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  children: [
                    ///================================changePassword=================
                    CustomMenuItem(
                      image: AppIcons.lock,
                      text: AppStrings.changePassword.tr,
                      onTap: () {
                        Get.toNamed(AppRoutes.changePasswordScreen);
                      },
                    ),

                    ///===============================termsOfService=================
                    CustomMenuItem(
                      image: AppIcons.terms,
                      text: AppStrings.termsOfService.tr,
                      onTap: () {
                        Get.toNamed(AppRoutes.termsAndServiceScreen);
                      },
                    ),

                    ///================================privacyPolicy=================
                    CustomMenuItem(
                      image: AppIcons.privacy,
                      text: AppStrings.privacyPolicy.tr,
                      onTap: () {
                        Get.toNamed(AppRoutes.privacyPolicyScreen);
                      },
                    ),

                    ///================================faqScreen=================
                    CustomMenuItem(
                      image: AppIcons.about,
                      text: "FAQ".tr,
                      onTap: () {
                        Get.toNamed(AppRoutes.faqScreen);
                      },
                    ),

                    ///================================helpWhere=================
                    CustomMenuItem(
                      image: AppIcons.help,
                      text: AppStrings.helpWhere.tr,
                      onTap: () {
                        Get.toNamed(AppRoutes.helpWhereScreen);

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
