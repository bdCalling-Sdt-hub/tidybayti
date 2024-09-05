import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tidybayte/utils/app_strings/app_strings.dart';

import 'package:tidybayte/view/components/custom_menu_appbar/custom_menu_appbar.dart';
import 'package:tidybayte/view/components/nav_bar/nav_bar.dart';

class UpgradePackages extends StatelessWidget {
  const UpgradePackages({super.key});

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
          child: SingleChildScrollView(
            child: Column(
              // crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ///=============================== Upgrade Packages ========================
                CustomMenuAppbar(
                  title: AppStrings.upgradePackages,
                  onBack: () {
                    Get.back();
                  },
                ),

                ///=============================== aboutUs ========================

              ],
            ),
          ),
        ),
      ),
    );
  }
}
