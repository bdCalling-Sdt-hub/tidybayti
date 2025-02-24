import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tidybayte/app/controller/owner_controller/wallet_controller/wallet_controller.dart';
import 'package:tidybayte/app/core/app_routes/app_routes.dart';
import 'package:tidybayte/app/global/helper/GenerelError/general_error.dart';
import 'package:tidybayte/app/global/helper/global_alart/global_alart.dart';
import 'package:tidybayte/app/global/helper/time_converter/time_converter.dart';
import 'package:tidybayte/app/utils/app_colors/app_colors.dart';
import 'package:tidybayte/app/utils/app_const/app_const.dart';
import 'package:tidybayte/app/utils/app_strings/app_strings.dart';
import 'package:tidybayte/app/view/components/custom_button/custom_button.dart';
import 'package:tidybayte/app/view/components/custom_loader/custom_loader.dart';
import 'package:tidybayte/app/view/components/custom_menu_appbar/custom_menu_appbar.dart';
import 'package:tidybayte/app/view/components/custom_text/custom_text.dart';
import 'package:tidybayte/app/view/components/no_internet_screen/no_internet_screen.dart';

class BudgetDetailsScreen extends StatefulWidget {
  const BudgetDetailsScreen({super.key});

  @override
  State<BudgetDetailsScreen> createState() => _BudgetDetailsScreenState();
}

class _BudgetDetailsScreenState extends State<BudgetDetailsScreen> {
  final id = Get.arguments[0];
  final categoryName = Get.arguments[1];

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
            colors: [Color(0xCCE8F3FA), Color(0xFFB5D8EE)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: Obx(() {
            switch (controller.rxRequestStatus.value) {
              case Status.loading:
                return const Center(child: CustomLoader());

              case Status.internetError:
                return NoInternetScreen(
                  onTap: () => controller.getSingleBudget(budgetId: id),
                );

              case Status.error:
                return GeneralErrorScreen(
                  onTap: () => controller.getSingleBudget(budgetId: id),
                );

              case Status.completed:
                final budget = controller.budgetDetailsData.value;
                final amount = budget.amount?.toDouble() ?? 0.0;
                final currentExpense = budget.currentExpense?.toDouble() ?? 0.0;
                final progress =
                    amount > 0 ? (amount - currentExpense) / amount : 0.0;
                final expenses = budget.expenses ?? [];

                return SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      /// ✅ Appbar
                      CustomMenuAppbar(
                        isRemove: true,
                        onRemove: () {
                          GlobalAlert.showDeleteDialog(
                              context, () {
                           controller.removeBudget(budgetId: id);
                          }, 'Remove Budget');
                        },
                        title: categoryName,
                        onBack: () {
                          Get.back();
                        },
                      ),
                      SizedBox(height: 20.h),

                      /// ✅ Budget Details Card
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
                                CustomText(
                                  text: '\$${amount.toStringAsFixed(2)}',
                                  fontWeight: FontWeight.w600,
                                  fontSize: 24,
                                  color: AppColors.green,
                                ),
                              ],
                            ),
                            SizedBox(height: 8.h),

                            /// ✅ Budget Date
                            Row(
                              children: [
                                const Icon(Icons.calendar_month,
                                    color: Colors.grey),
                                const SizedBox(width: 5),
                                CustomText(
                                  text: budget.budgetDateTime != null
                                      ? DateConverter.estimatedDate(
                                          budget.budgetDateTime!.toLocal())
                                      : "N/A",
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14,
                                  color: AppColors.dark300,
                                ),
                              ],
                            ),
                            SizedBox(height: 12.h),

                            /// ✅ Budget Progress
                            LinearProgressIndicator(
                              value: progress.clamp(0.0, 1.0),
                              backgroundColor: AppColors.blue100,
                              color: AppColors.red,
                              minHeight: 8.0,
                            ),
                            SizedBox(height: 12.h),

                            /// ✅ Cost & Remaining Budget
                            Row(
                              children: [
                                CustomText(
                                  text:
                                      "Cost: \$${currentExpense.toStringAsFixed(2)}",
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14,
                                  color: AppColors.red,
                                ),
                                const Spacer(),
                                CustomText(
                                  text:
                                      "Left: \$${(amount - currentExpense).toStringAsFixed(2)}",
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

                      /// ✅ Expense Overview
                      CustomText(
                        text: AppStrings.expenseOverview.tr,
                        fontWeight: FontWeight.w500,
                        fontSize: 20.h,
                        color: AppColors.blue900,
                      ),

                      /// ✅ Expense List
                      expenses.isEmpty
                          ? Center(
                              child: Padding(
                                padding: EdgeInsets.symmetric(vertical: 50.h),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Icon(Icons.money_off,
                                        size: 80, color: Colors.grey),
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
                            )
                          : ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: expenses.length,
                              itemBuilder: (context, index) {
                                return Container(
                                  // height: MediaQuery.of(context).size.height/4,
                                  margin:
                                      const EdgeInsets.symmetric(vertical: 5),
                                  color: Colors.white,
                                  padding: const EdgeInsets.only(
                                      top: 10, left: 10, right: 10),
                                  child: Column(
                                    children: [
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const Icon(Icons.house,
                                              color: Colors.grey),
                                          SizedBox(width: 10.w),
                                          CustomText(
                                            text: budget.category ?? "",
                                            color: AppColors.dark300,
                                            fontSize: 16.h,
                                          ),
                                          const Spacer(),
                                          CustomText(
                                            text:
                                                "\$${expenses[index].amount?.toStringAsFixed(2) ?? '0'}",
                                            color: AppColors.dark300,
                                            fontSize: 16.h,
                                          )
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          const Spacer(),
                                          IconButton(
                                              onPressed: () {
                                                GlobalAlert.showDeleteDialog(
                                                    context, () {
                                                  controller.removeExpense(
                                                      expenseId:
                                                          expenses[index].id ??
                                                              "",
                                                      budgetId: id);
                                                }, 'Remove Expense');
                                              },
                                              icon: const Icon(
                                                Icons.delete,
                                                color: Colors.grey,
                                              )),
                                        ],
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),

                      SizedBox(height: 20.h),
                    ],
                  ),
                );
            }
          }),
        ),
      ),

      /// ✅ Add Expense Button
      bottomSheet: Container(
        color: const Color(0xffB5D8EE),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: CustomButton(
            onTap: () => Get.toNamed(AppRoutes.addExpenseScreen,
                arguments: [id, categoryName]),
            fillColor: Colors.white,
            title: AppStrings.addExpanse.tr,
          ),
        ),
      ),
    );
  }
}
