import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tidybayte/app/core/app_routes/app_routes.dart';
import 'package:tidybayte/app/utils/app_colors/app_colors.dart';
import 'package:tidybayte/app/utils/app_icons/app_icons.dart';
import 'package:tidybayte/app/utils/app_images/app_images.dart';
import 'package:tidybayte/app/utils/app_strings/app_strings.dart';
import 'package:tidybayte/app/view/components/custom_button/custom_button.dart';
import 'package:tidybayte/app/view/components/custom_image/custom_image.dart';
import 'package:tidybayte/app/view/components/custom_menu_appbar/custom_menu_appbar.dart';
import 'package:tidybayte/app/view/components/custom_task_details_dialoge/custom_task_details_dialoge.dart';
import 'package:tidybayte/app/view/components/custom_text/custom_text.dart';
import 'package:tidybayte/app/view/components/custom_text_field/custom_text_field.dart';
import 'package:tidybayte/app/view/components/nav_bar/nav_bar.dart';
class MyPlanScreen extends StatelessWidget {
  MyPlanScreen({super.key});

  final List<String> listPackages = [
    AppStrings.inviteUnlimited,
    AppStrings.assignTasksTo,
    AppStrings.masterYourCleaningSchedule,
    AppStrings.manageMultiplePlaces
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          child: SingleChildScrollView(
            child: Column(
              children: [
                ///=============================== My Plan AppBar ========================
                CustomMenuAppbar(
                  title: AppStrings.myPlan,
                  onBack: () {
                    Get.back();
                  },
                ),
                SizedBox(height: 20.h),

                ///=============================== Premium Plan Card ========================
                _buildPackageCard(
                  context: context,
                  packageTitle: AppStrings.premium,
                  price: AppStrings.sixMonth,
                  listPackages: listPackages,
                  onAutoRenewTap: () {
                    // Handle auto-renewal logic
                  },
                  onRenewPlanTap: () {
                    // Handle renew plan logic
                  },
                  onBuyNewPackagesTap: () {
                    // Handle buying new packages logic
                  }, bhd: 'BHD 60/Month', expireDate: 'Expiry date :22 Feb 2024',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// Reusable method to build a package card with specific button actions
  Widget _buildPackageCard({
    required BuildContext context,
    required String packageTitle,
    required String price,
    required String expireDate,
    required String bhd,
    required List<String> listPackages,
    required VoidCallback onAutoRenewTap,
    required VoidCallback onRenewPlanTap,
    required VoidCallback onBuyNewPackagesTap,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 21),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
        decoration: BoxDecoration(
          color: AppColors.blue100,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomText(
              text: packageTitle,
              fontWeight: FontWeight.w600,
              fontSize: 14,
              color: AppColors.red,
            ),
            CustomText(
              top: 8,
              text: price,
              fontWeight: FontWeight.w600,
              fontSize: 20,
              color: AppColors.bhdColor,
              bottom: 16,
            ),   CustomText(
              top: 8,
              text: bhd,
              fontWeight: FontWeight.w600,
              fontSize: 20,
              color: AppColors.bhdColor,
              bottom: 16,
            ),
            _buildPackageList(listPackages),

            CustomText(
              top: 8,
              text: expireDate,
              fontWeight: FontWeight.w400,
              fontSize: 14,
              color: AppColors.red,
              bottom: 16,
            ),
            SizedBox(height: 16.h),

            ///=========================== Auto-Renewal Button ============================
            Center(
              child: CustomButton(
                width: MediaQuery.of(context).size.width / 2,
                onTap: onAutoRenewTap,
                fillColor: AppColors.light50,
                title: AppStrings.autoRenewal,
              ),
            ),
            SizedBox(height: 16.h),

            ///=========================== Renew Plan Button ============================
            Center(
              child: CustomButton(
                width: MediaQuery.of(context).size.width / 2,
                onTap: onRenewPlanTap,
                fillColor: AppColors.light50,
                title: AppStrings.reNewPlan,
              ),
            ),
            SizedBox(height: 16.h),

            ///=========================== Buy New Packages Button ============================
            Center(
              child: CustomButton(
                width: MediaQuery.of(context).size.width / 2,
                onTap: onBuyNewPackagesTap,
                fillColor: AppColors.light50,
                title: AppStrings.buyNewPackages,
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Reusable method to build a list of package features
  Widget _buildPackageList(List<String> listPackages) {
    return Column(
      children: List.generate(listPackages.length, (index) {
        return Column(
          children: [
            Row(
              children: [
                const CustomImage(imageSrc: AppIcons.premium),
                SizedBox(width: 5.w),
                CustomText(
                  text: listPackages[index],
                  fontWeight: FontWeight.w400,
                  fontSize: 16,
                  color: AppColors.dark300,
                ),
              ],
            ),
            SizedBox(height: 10.h),
          ],
        );
      }),
    );
  }
}
