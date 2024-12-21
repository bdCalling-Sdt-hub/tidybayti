import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tidybayte/core/app_routes/app_routes.dart';
import 'package:tidybayte/utils/app_icons/app_icons.dart';
import 'package:tidybayte/utils/app_strings/app_strings.dart';

import 'package:tidybayte/view/components/custom_menu_appbar/custom_menu_appbar.dart';
import 'package:tidybayte/view/components/custom_menu_item/custom_menu_item.dart';


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
              ///=============================== Menu Title ========================
              CustomMenuAppbar(
                title: AppStrings.settings,
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
                      text: AppStrings.changePassword,
                      onTap: () {
                        Get.toNamed(AppRoutes.changePasswordScreen);
                      },
                    ),

                    ///===============================termsOfService=================
                    CustomMenuItem(
                      image: AppIcons.terms,
                      text: AppStrings.termsOfService,
                      onTap: () {
                        Get.toNamed(AppRoutes.termsAndServiceScreen);
                      },
                    ),

                    ///================================privacyPolicy=================
                    CustomMenuItem(
                      image: AppIcons.privacy,
                      text: AppStrings.privacyPolicy,
                      onTap: () {
                        Get.toNamed(AppRoutes.privacyPolicyScreen);
                      },
                    ),

                    ///================================aboutUs=================
                    CustomMenuItem(
                      image: AppIcons.about,
                      text: AppStrings.aboutUs,
                      onTap: () {
                        Get.toNamed(AppRoutes.aboutUsScreen);
                      },
                    ),

                    ///================================helpWhere=================
                    CustomMenuItem(
                      image: AppIcons.help,
                      text: AppStrings.helpWhere,
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
