import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tidybayte/app/controller/owner_controller/wallet_controller/wallet_controller.dart';
import 'package:tidybayte/app/core/app_routes/app_routes.dart';
import 'package:tidybayte/app/global/helper/time_converter/time_converter.dart';
import 'package:tidybayte/app/utils/app_colors/app_colors.dart';
import 'package:tidybayte/app/utils/app_const/app_const.dart';

import 'package:tidybayte/app/utils/app_strings/app_strings.dart';
import 'package:tidybayte/app/view/components/custom_button/custom_button.dart';
import 'package:tidybayte/app/view/components/custom_loader/custom_loader.dart';
import 'package:tidybayte/app/view/components/custom_menu_appbar/custom_menu_appbar.dart';
import 'package:tidybayte/app/view/components/custom_text/custom_text.dart';

class BudgetDetailsScreen extends StatefulWidget {
  BudgetDetailsScreen({super.key});

  @override
  State<BudgetDetailsScreen> createState() => _BudgetDetailsScreenState();
}

class _BudgetDetailsScreenState extends State<BudgetDetailsScreen> {
  final id = Get.arguments[0];

  final categoryName = Get.arguments[1];
  final progress = Get.arguments[2];

  final WalletController controller = Get.find<WalletController>();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.getSingleBudget(budgetId: id);
    });

    super.initState();
  }

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
                ///==================================✅✅categoryName Appbar✅✅=======================

                CustomMenuAppbar(
                  isEdit: true,
                  onTap: () {
                    Get.toNamed(AppRoutes.createBudgetScreen);
                  },
                  title: categoryName,
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
                                CustomText(
                                  text: AppStrings.budgetDetails.tr,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 24,
                                  color: AppColors.blue800,
                                ),
                                const Spacer(),

                                ///==================================✅✅Total AMount✅✅=======================

                                CustomText(
                                  text:
                                      '\$${controller.budgetDetailsData.value.amount.toString()}',
                                  fontWeight: FontWeight.w600,
                                  fontSize: 24,
                                  color: AppColors.green,
                                ),
                                SizedBox(width: 12.h),
                              ],
                            ),
                            SizedBox(height: 8.h),

                            ///==================================✅✅Date✅✅=======================

                            Row(
                              children: [
                                const Icon(
                                  Icons.calendar_month,
                                  color: Colors.grey,
                                ),
                                const SizedBox(width: 5),
                                CustomText(
                                  text: DateConverter.estimatedDate(controller
                                      .budgetDetailsData.value.budgetDateTime!
                                      .toLocal()),
                                  // Example amount
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14,
                                  color: AppColors.dark300,
                                ),
                              ],
                            ),
                            SizedBox(height: 12.h),

                            ///==================================✅✅progress✅✅=======================

                            LinearProgressIndicator(
                              value: progress, // Example progress
                              backgroundColor: AppColors.blue100,
                              color: AppColors.red,
                              minHeight: 8.0,
                            ),
                            SizedBox(height: 12.h),
                            Row(
                              children: [
                                ///==================================✅✅Cost✅✅=======================

                                CustomText(
                                  text:
                                      "Cost \$${controller.budgetDetailsData.value.currentExpense}",
                                  // Example remaining amount
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14,
                                  color: AppColors.red,
                                ),
                                const Spacer(),
                                CustomText(
                                  text:
                                      "Left budget \$${controller.budgetDetailsData.value.amount}",
                                  // Example remaining amount
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

                      ///==================================✅✅expenseOverview✅✅=======================

                      CustomText(
                        text: AppStrings.expenseOverview.tr,
                        fontWeight: FontWeight.w500,
                        fontSize: 20.h,
                        color: AppColors.blue900,
                      ),
                      Obx(() {
                        switch (controller.rxRequestStatus.value) {
                          case Status.loading:
                            return const CustomLoader(); // Show loading indicator

                          case Status.internetError:
                            return const CustomText(
                              text: 'Internet Error',
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                              color: Colors.black,
                            );

                          case Status.error:
                            return const CustomText(
                              text: 'Something went wrong!',
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                              color: Colors.black,
                            );

                          case Status.completed:
                            final expenses = controller.budgetDetailsData.value.expenses ?? [];

                            if (expenses.isEmpty) {
                              // ✅ Show No Expense Found message
                              return Center(
                                child: Padding(
                                  padding: EdgeInsets.symmetric(vertical: 50.h),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(Icons.money_off, size: 80, color: Colors.grey),
                                      SizedBox(height: 10.h),
                                      CustomText(
                                        text: "No Expense Found",
                                        fontWeight: FontWeight.w500,
                                        fontSize: 18.sp,
                                        color: Colors.grey,
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            }

                            /// ✅ Show Expense List if data is available
                            return Column(
                              children: List.generate(
                                expenses.length,
                                    (index) => Padding(
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
                                                const Icon(
                                                  Icons.house,
                                                  color: Colors.grey,
                                                ),
                                                CustomText(
                                                  left: 10,
                                                  text: controller.budgetDetailsData.value.category ?? "",
                                                  color: AppColors.dark300,
                                                  fontSize: 16.h,
                                                ),
                                                SizedBox(width: 150.w),
                                                CustomText(
                                                  left: 10,
                                                  text: "\$${expenses[index].amount?.toString() ?? '0'}",
                                                  color: AppColors.dark300,
                                                  fontSize: 16.h,
                                                ),
                                              ],
                                            ),
                                            const SizedBox(height: 10),

                                            Row(
                                              children: [
                                                const Icon(
                                                  Icons.calendar_month,
                                                  color: Colors.grey,
                                                ),
                                                CustomText(
                                                  left: 10,
                                                  text: expenses[index].expenseDateStr ?? "",
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
                                ),
                              ),
                            );
                        }
                      }),


                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),

      ///==================================✅✅addExpanse Button✅✅=======================

      bottomSheet: Container(
        color: const Color(0xffB5D8EE),
        child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: CustomButton(
              onTap: () {
                Get.toNamed(AppRoutes.addExpenseScreen);
              },
              fillColor: Colors.white,
              title: AppStrings.addExpanse.tr,
            )),
      ),
    );
  }
}
