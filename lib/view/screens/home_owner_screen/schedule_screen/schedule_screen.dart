import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tidybayte/utils/app_colors/app_colors.dart';
import 'package:tidybayte/utils/app_strings/app_strings.dart';
import 'package:tidybayte/view/components/custom_menu_appbar/custom_menu_appbar.dart';
import 'package:tidybayte/view/components/custom_text/custom_text.dart';
import 'package:tidybayte/view/components/nav_bar/nav_bar.dart';
import 'package:tidybayte/view/screens/home_owner_screen/schedule_screen/task_schedule/task_schedule.dart';
import 'package:tidybayte/view/screens/home_owner_screen/schedule_screen/work_schedule/work_schedule.dart';

class ScheduleScreen extends StatefulWidget {
  const ScheduleScreen({super.key});

  @override
  State<ScheduleScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends State<ScheduleScreen> {
  int selectedTabIndex = 0;

  final List<Widget> screens = [ const WorkSchedule(), const TaskSchedule()];

  final List<String> schedule = ["Work Schedule", "Task Schedule"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const NavBar(currentIndex: 1),
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
                ///=============================== Schedule Appbar ========================
                CustomMenuAppbar(
                  title: AppStrings.scheduleOverview,
                  onBack: () {
                    Get.back();
                  },
                     download:selectedTabIndex == 0,
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
                                    color: AppColors.blue900,
                                    width: 4)
                                    : const BorderSide(
                                    color: AppColors.blue50,
                                    width: 4),
                              )),
                          child: CustomText(
                            text: schedule[index],
                            fontWeight: FontWeight.w400,
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
                screens[selectedTabIndex],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
