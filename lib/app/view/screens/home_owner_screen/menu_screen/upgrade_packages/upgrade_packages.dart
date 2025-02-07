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
class UpgradePackages extends StatelessWidget {
  UpgradePackages({super.key});

  final List<String> listPackages = [
    '5 days free',
    AppStrings.inviteUnlimited,
    AppStrings.assignTasksTo,
    AppStrings.masterYourCleaningSchedule,
    AppStrings.manageMultiplePlaces
  ];

  final List<String> monthly = [
    '3 days free',
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
                ///=============================== Upgrade Packages ========================
                CustomMenuAppbar(
                  title: AppStrings.upgradePackages,
                  onBack: () {
                    Get.back();
                  },
                ),
                SizedBox(height: 20.h),

                ///=============================== Monthly ========================
                _buildPackageCard(
                  context: context,
                  packageTitle: AppStrings.monthly,
                  price: AppStrings.bhdSix,
                  listPackages: monthly,
                  onTap: () {},
                ),
                SizedBox(height: 20.h),

                ///=============================== Premium Pro ========================
                _buildPackageCard(
                  context: context,
                  packageTitle: 'yearly',
                  price: AppStrings.bhd120,
                  listPackages: listPackages,
                  onTap: () {},
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }



















  /// Reusable method to build a package card
  Widget _buildPackageCard({
    required BuildContext context,
    required String packageTitle,
    required String price,
    required List<String> listPackages,
    required VoidCallback onTap,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 21),
      child: Container(
        padding: const EdgeInsets.all(16),
        color: AppColors.blue100,
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
            ),
            _buildPackageList(listPackages),
            SizedBox(height: 16.h),
            CustomButton(
              onTap: onTap,
              fillColor: AppColors.light50,
              title: 'Buy now',
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
