import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tidybayte/app/controller/employee_controller/employee_home_controller.dart';
import 'package:tidybayte/app/utils/app_colors/app_colors.dart';
import 'package:tidybayte/app/view/components/custom_text/custom_text.dart';
import 'package:tidybayte/app/view/components/employee_nav_bar/employee_navbar.dart';
import 'package:tidybayte/app/view/screens/employee_screen/employee_home_screen/inner_widget/employee_home_app_bar.dart';

class EmployeeHomeScreen extends StatelessWidget {
  EmployeeHomeScreen({super.key});

  final scaffoldKey = GlobalKey<ScaffoldState>();
  final EmployeeHomeController employeeHomeController =
  Get.put(EmployeeHomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      bottomNavigationBar: const EmployeeNavbar(currentIndex: 0),
      body: Obx(() {
        return Column(
          children: [
            EmployeeHomeAppBar(scaffoldKey: scaffoldKey),
            _buildCalendar(employeeHomeController),

            // Wrapping scrollable content in Expanded to avoid overflow
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildDayHeader(context, 'Sunday'),
                    _buildDayDescription('Off Day'),
                    SizedBox(height: 15.h),
                    _buildDayHeader(context, 'Monday'),
                    SizedBox(height: 15.h),

                    _buildHorizontalTaskList(),
                    SizedBox(height: 15.h),

                    _buildDayHeader(context, 'Tuesday'),

                    SizedBox(height: 15.h),

                    _buildHorizontalTaskList(),
                    SizedBox(height: 15.h),
                    _buildDayHeader(context, 'Tuesday'),
                    SizedBox(height: 15.h),

                    _buildHorizontalTaskList(),
                    SizedBox(height: 15.h),
                  ],
                ),
              ),
            ),
          ],
        );
      }),
    );
  }

  // Widget to build the calendar
  Widget _buildCalendar(EmployeeHomeController controller) {
    return Container(
      margin: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.white,
      ),
      child: CalendarDatePicker2(
        config: CalendarDatePicker2Config(
          controlsTextStyle: const TextStyle(color: Colors.green),
          dayTextStyle: const TextStyle(color: Colors.black),
          monthTextStyle: const TextStyle(color: Colors.black),
          yearTextStyle: const TextStyle(color: Colors.black),
          weekdayLabelTextStyle: const TextStyle(color: Colors.black),
          selectedDayHighlightColor: Colors.black,
        ),
        value: controller.dates,
        onValueChanged: (dates) {
          controller.updateDates(dates);
        },
      ),
    );
  }

  // Helper function to build day headers
  Widget _buildDayHeader(BuildContext context, String day) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 50,
      color: AppColors.blue300,
      child: CustomText(
        left: 10,
        top: 15,
        textAlign: TextAlign.start,
        text: day,
        fontWeight: FontWeight.w500,
        color: AppColors.dark300,
      ),
    );
  }

  // Helper function to build day description text
  Widget _buildDayDescription(String description) {
    return CustomText(
      top: 15,
      left: 10,
      text: description,
      fontWeight: FontWeight.w500,
      fontSize: 18,
      color: AppColors.dark500,
    );
  }

  // Build horizontal list of task cards
  Widget _buildHorizontalTaskList() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(10, (index) {
          return Row(
            children: [
              TaskCard(),
              // Reusable TaskCard widget
              SizedBox(width: 20.w),
            ],
          );
        }),
      ),
    );
  }
}

// Reusable Task Card Widget
class TaskCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      color: AppColors.blue100,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomText(
            text: 'Work',
            fontSize: 15,
            color: AppColors.dark500,
          ),
          CustomText(
            text: 'Arrange appointment',
            fontSize: 15,
            color: AppColors.dark500,
          ),
          Row(
            children: [
              const Icon(Icons.watch_later_outlined),
              CustomText(
                text: '10:00 am',
                fontSize: 14,
                color: AppColors.dark400,
              ),
              const SizedBox(width: 10),
              CustomText(
                text: '11:00 am',
                fontSize: 14,
                color: AppColors.dark400,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
