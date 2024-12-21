import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tidybayte/core/app_routes/app_routes.dart';
import 'package:tidybayte/utils/app_const/app_const.dart';
import 'package:tidybayte/utils/app_strings/app_strings.dart';
import 'package:tidybayte/view/components/custom_employee_card/custom_employee_card.dart';
import 'package:tidybayte/view/components/custom_menu_appbar/custom_menu_appbar.dart';

class EmployeeList extends StatefulWidget {
  const EmployeeList({super.key});

  @override
  State<EmployeeList> createState() => _AllTaskScreenState();
}

class _AllTaskScreenState extends State<EmployeeList> {
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
            children: [
              ///=============================== Menu Title ========================
              CustomMenuAppbar(
                title: AppStrings.employeeList,
                onBack: () {
                  Get.back();
                },
              ),

              ///=============================== Employee List ========================
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  children: [
                    Column(
                      children: List.generate(4, (index) {
                        return CustomEmployeeCard(
                          imageUrl: AppConstants.userNtr, // Replace with your image URL
                          name: 'Name:', // Replace with dynamic employee name
                          designation: 'Assistant', // Replace with dynamic designation
                          onSelect: () {
                            // Pass the selected employee's name back to the previous screen
                            Get.back(result: 'Sadhu');
                          },
                          onInfo: () {
                          Get.toNamed(AppRoutes.employeeDetails);
                          },
                        );
                      }),
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
