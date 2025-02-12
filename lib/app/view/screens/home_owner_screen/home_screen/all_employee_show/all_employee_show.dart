import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tidybayte/app/core/app_routes/app_routes.dart';
import 'package:tidybayte/app/utils/app_colors/app_colors.dart';
import 'package:tidybayte/app/utils/app_const/app_const.dart';

import 'package:tidybayte/app/utils/app_strings/app_strings.dart';
import 'package:tidybayte/app/view/components/custom_menu_appbar/custom_menu_appbar.dart';

import 'package:tidybayte/app/view/components/custom_text_field/custom_text_field.dart';
import 'package:tidybayte/app/view/components/employee_card/custom_employee_card.dart';
import 'package:tidybayte/app/view/components/nav_bar/nav_bar.dart';

class AllEmployeeShow extends StatelessWidget {
  const AllEmployeeShow({super.key});

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
          child: Column(
            children: [
              ///==================================✅✅employees Appbar✅✅=======================
              CustomMenuAppbar(
                title: AppStrings.employees.tr,
                onBack: () {
                  Get.back();
                },
              ),

              Expanded(
                child: ListView(
                  padding: const EdgeInsets.all(16.0),
                  children: [
                    ///==================================✅✅addNewEmployee Button✅✅=======================
                    CustomTextField(
                      fillColor: AppColors.blue50,
                      readOnly: true,
                      onTap: () {
                        Get.toNamed(AppRoutes.addEmployeeScreen);
                      },
                      hintText: AppStrings.addEmployee.tr,
                      prefixIcon: const Icon(Icons.add),
                    ),

                    const SizedBox(height: 16),
                    // Spacing between text field and list

                    ///==================================✅✅All Employee Card✅✅=======================
                    Column(
                      children: List.generate(4, (context) {
                        return CustomEmployeeData(
                          imageUrl: AppConstants.userNtr,
                          name: "John Doe",
                          designation: "Assistant",
                          id: "123456789",
                          email: "johndoe@example.com",
                          onDetailsTap: () {
                            Get.toNamed(AppRoutes.employeeDetails);
                          },
                          onDeleteTap: () {
                            print("Employee Deleted!");
                          },
                        );
                      }),
                    )
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
