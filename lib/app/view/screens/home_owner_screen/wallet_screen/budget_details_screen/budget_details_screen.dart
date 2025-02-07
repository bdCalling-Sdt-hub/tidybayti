import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tidybayte/app/core/app_routes/app_routes.dart';
import 'package:tidybayte/app/utils/app_colors/app_colors.dart';
import 'package:tidybayte/app/utils/app_const/app_const.dart';
import 'package:tidybayte/app/utils/app_icons/app_icons.dart';
import 'package:tidybayte/app/utils/app_images/app_images.dart';
import 'package:tidybayte/app/utils/app_strings/app_strings.dart';
import 'package:tidybayte/app/view/components/custom_button/custom_button.dart';
import 'package:tidybayte/app/view/components/custom_image/custom_image.dart';
import 'package:tidybayte/app/view/components/custom_menu_appbar/custom_menu_appbar.dart';
import 'package:tidybayte/app/view/components/custom_netwrok_image/custom_network_image.dart';
import 'package:tidybayte/app/view/components/custom_room_card/custom_room_card.dart';
import 'package:tidybayte/app/view/components/custom_task_details_dialoge/custom_task_details_dialoge.dart';
import 'package:tidybayte/app/view/components/custom_text/custom_text.dart';
import 'package:tidybayte/app/view/components/custom_text_field/custom_text_field.dart';
import 'package:tidybayte/app/view/components/nav_bar/nav_bar.dart';

class BudgetDetailsScreen extends StatelessWidget {
  const BudgetDetailsScreen({super.key});

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
                /// Budget Appbar
                CustomMenuAppbar(
                  isEdit: true,
                  onTap: (){
                    Get.toNamed(AppRoutes.createBudgetScreen);
                  },
                  title: 'Housing',
                  onBack: () {
                    Get.back();
                  },
                ),
                SizedBox(height: 20.h),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 24.h),
                      Container(
                        padding: const EdgeInsets.all(15),
                        color: Colors.white,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                const CustomText(
                                  text: AppStrings.budgetDetails,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 24,
                                  color: AppColors.blue800,
                                ),
                                   const Spacer(),
                                const CustomText(
                                  text: '\$2000',
                                  fontWeight: FontWeight.w600,
                                  fontSize: 24,
                                  color: AppColors.green,
                                ),
                                SizedBox(width: 12.h),
                              ],
                            ),

                            SizedBox(height: 8.h),
                            const Row(
                              children: [
                               Icon(Icons.calendar_month,color: Colors.grey,),
                                SizedBox(width: 5),
                                CustomText(
                                  text: "10/2/2025", // Example amount
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14,
                                  color: AppColors.dark300,
                                ),
                              ],
                            ),
                            SizedBox(height: 12.h),
                            LinearProgressIndicator(
                              value: 0.7, // Example progress
                              backgroundColor: AppColors.blue100,
                              color: AppColors.red,
                              minHeight: 8.0,
                            ),
                            SizedBox(height: 12.h),
                            const Row(
                              children: [
                                CustomText(
                                  text: "Cost \$300", // Example remaining amount
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14,
                                  color: AppColors.red,
                                ),
                                Spacer(),

                                CustomText(
                                  text: "Left budget \$1600", // Example remaining amount
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14,
                                  color: AppColors.green,
                                ),
                              ],
                            ),

                          ],
                        ),
                      ),
                      SizedBox(height: 16.h),

                      /// Expense Overview
                      CustomText(
                        text: AppStrings.expenseOverview,
                        fontWeight: FontWeight.w500,
                        fontSize: 20.h,
                        color: AppColors.blue900,
                      ),

                      /// Example Expense List
                      Column(
                        children: List.generate(5, (index) => Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: Container(
                            color: Colors.white,
                            padding: const EdgeInsets.all(15),
                            child: Row(
                              children: [

                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                    const Icon(Icons.house,color: Colors.grey,),

                                        CustomText(
                                          left: 10,
                                          text: "Housing", // Example amount
                                          color: AppColors.dark300,
                                          fontSize: 16.h,
                                        ),
                                        SizedBox(width: 150.w,),
                                        CustomText(
                                          left: 10,
                                          text: "\$200", // Example amount
                                          color: AppColors.dark300,
                                          fontSize: 16.h,
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 10,),

                                    Row(
                                      children: [
                                    const Icon(Icons.calendar_month,color: Colors.grey,),

                                        CustomText(
                                          left: 10,
                                          text: "10/2/2025", // Example amount
                                          color: AppColors.dark300,
                                          fontSize: 16.h,
                                        ),

                                      ],
                                    ), // Example icon


                                  ],
                                ),
                              ],
                            ),
                          ),
                        )),
                      ),
                      SizedBox(height: 100),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),

      /// Add Expense Button
      bottomSheet: Container(
        color: const Color(0xffB5D8EE),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: CustomButton(
            onTap: (){
              Get.toNamed(AppRoutes.addExpenseScreen);
            },
          fillColor: Colors.white,
            title: AppStrings.addExpanse,

          )
        ),
      ),
    );
  }
}
