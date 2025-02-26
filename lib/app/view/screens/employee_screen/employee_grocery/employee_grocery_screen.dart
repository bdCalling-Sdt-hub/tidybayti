import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tidybayte/app/utils/app_colors/app_colors.dart';
import 'package:tidybayte/app/utils/app_strings/app_strings.dart';
import 'package:tidybayte/app/view/components/custom_menu_appbar/custom_menu_appbar.dart';

import 'package:tidybayte/app/view/components/custom_text/custom_text.dart';
import 'package:tidybayte/app/view/components/employee_nav_bar/employee_navbar.dart';

import 'grocery_complete/grocery_complete_screen.dart';
import 'grocery_ongoing/grocery_ongoing_screen.dart';
import 'grocery_pending/grocery_pending_screen.dart';

class EmployeeGroceryScreen extends StatefulWidget {
  const EmployeeGroceryScreen({super.key});

  @override
  State<EmployeeGroceryScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends State<EmployeeGroceryScreen> {
  int selectedTabIndex = 0;

  final List<Widget> screens = [
    const GroceryPendingScreen(),
    const GroceryOngoingScreen(),
    const GroceryCompleteScreen()
  ];

  final List<String> schedule = ["pending", "Ongoing", "Completed"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const EmployeeNavbar(currentIndex: 2),
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
                ///=============================== additionalTask Appbar ========================
                CustomMenuAppbar(
                  title: AppStrings.grocery.tr,
                  onBack: () {
                    Get.back();
                  },
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
                            fontSize: 14,
                            color: AppColors.blue900,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20.h),

                ///=============================== Selected Screen ========================
                screens[selectedTabIndex],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
