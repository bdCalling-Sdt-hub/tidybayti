import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tidybayte/app/core/app_routes/app_routes.dart';
import 'package:tidybayte/app/utils/app_colors/app_colors.dart';
import 'package:tidybayte/app/utils/app_strings/app_strings.dart';
import 'package:tidybayte/app/view/components/custom_button/custom_button.dart';
import 'package:tidybayte/app/view/components/custom_menu_appbar/custom_menu_appbar.dart';
import 'package:tidybayte/app/view/components/custom_text/custom_text.dart';
import 'package:tidybayte/app/view/components/nav_bar/nav_bar.dart';
import 'package:tidybayte/app/view/screens/home_owner_screen/wallet_screen/wallet_overView_screen.dart';

import 'wallet_budget_screen.dart';

class WalletScreen extends StatefulWidget {
  const WalletScreen({super.key});

  @override
  State<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
  int selectedTabIndex = 0;

  final List<Widget> screens = [
    WalletBudgetScreen(),
    const WalletOverviewScreen()
  ];

  final List<String> schedule = ["Budget", "Overview"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: const NavBar(currentIndex: 2),
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
                  ///=============================== Wallet Appbar ========================
                  CustomMenuAppbar(
                    title: AppStrings.wallet.tr,
                    onBack: () {
                      Get.back();
                    },
                    download: false,
                  ),
                  SizedBox(height: 20.h),

                  ///=============================== Tab Switching ========================
                  Row(
                    children: List.generate(
                      schedule.length,
                      (index) => Expanded(
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              selectedTabIndex = index;
                            });
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 28),
                            decoration: BoxDecoration(
                                color: selectedTabIndex == index
                                    ? AppColors.light50
                                    : AppColors.light50,
                                border: Border(
                                  bottom: selectedTabIndex == index
                                      ? const BorderSide(
                                          color: AppColors.blue900, width: 4)
                                      : const BorderSide(
                                          color: AppColors.blue50, width: 4),
                                )),
                            child: CustomText(
                              text: schedule[index],
                              fontWeight: FontWeight.w500,
                              fontSize: 18.h,
                              color: AppColors.blue900,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20.h),

                  ///=============================== Selected Screen ========================
                  SingleChildScrollView(
                    child: SizedBox(
                        height: MediaQuery.of(context).size.height/1.7,
                        child: screens[selectedTabIndex]),
                  ),
                ],
              ),
            ),
          ),
        ),

        ///==================================✅✅createBudgets Button✅✅=======================

        floatingActionButton: selectedTabIndex == 0
            ? Padding(
                padding: const EdgeInsets.all(8.0),
                child: CustomButton(
                  width: MediaQuery.of(context).size.width / 1.2,
                  onTap: () {
                    Get.toNamed(AppRoutes.createBudgetScreen);
                  },
                  fillColor: Colors.white,
                  title: AppStrings.createBudgets.tr,
                ),
              )
            : const SizedBox()
    );
  }
}
