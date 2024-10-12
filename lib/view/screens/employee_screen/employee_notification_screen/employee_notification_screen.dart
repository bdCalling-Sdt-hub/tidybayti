import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tidybayte/utils/app_strings/app_strings.dart';
import 'package:tidybayte/view/components/custom_menu_appbar/custom_menu_appbar.dart';

class EmployeeNotificationScreen extends StatelessWidget {
  const EmployeeNotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE3F2FD), // Light blue background

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
        child:     Padding(
          padding: EdgeInsets.all(16.w),
          child: Column(
            children: [
              CustomMenuAppbar(
                title: AppStrings.notification,
                onBack: () {
                  Get.back();
                },
              ),
              const NotificationCard(
                icon: Icons.notifications_none_outlined,
                title: 'Welcome to Tidy bayti app.',
                timeAgo: '1 day ago',
              ),
              SizedBox(height: 16.h),
              NotificationCard(
                icon: Icons.notifications_none_outlined,
                title: 'You are assigned to a new task',
                timeAgo: '1 day ago',
              ),
              SizedBox(height: 16.h),
              NotificationCard(
                icon: Icons.notifications_none_outlined,
                title: 'Your task has been re-scheduled.',
                timeAgo: '1 day ago',
              ),
              SizedBox(height: 16.h),
              NotificationCard(
                icon: Icons.notifications_none_outlined,
                title: 'You have completed your task.',
                timeAgo: '1 day ago',
              ),
            ],
          ),
        ),
      )


    );
  }
}

class NotificationCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String timeAgo;

  const NotificationCard({
    super.key,
    required this.icon,
    required this.title,
    required this.timeAgo,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.r),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: Row(
        children: [
          Icon(icon, color: Colors.blue, size: 30.sp),
          SizedBox(width: 16.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 5.h),
                Text(
                  timeAgo,
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}