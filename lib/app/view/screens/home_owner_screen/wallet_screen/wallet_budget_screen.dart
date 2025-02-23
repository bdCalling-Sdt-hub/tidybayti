import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tidybayte/app/controller/owner_controller/wallet_controller/wallet_controller.dart';
import 'package:tidybayte/app/core/app_routes/app_routes.dart';
import 'package:tidybayte/app/global/helper/GenerelError/general_error.dart';
import 'package:tidybayte/app/utils/app_colors/app_colors.dart';
import 'package:tidybayte/app/utils/app_const/app_const.dart';

import 'package:tidybayte/app/view/components/budget_card/butget_card.dart';
import 'package:tidybayte/app/view/components/custom_loader/custom_loader.dart';
import 'package:tidybayte/app/view/components/no_internet_screen/no_internet_screen.dart';

class WalletBudgetScreen extends StatelessWidget {
  WalletBudgetScreen({super.key});

  final WalletController controller = Get.find<WalletController>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: RefreshIndicator(
        onRefresh: () async {
          await controller.getBudget(); // ✅ Fetch latest budget data
        },
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(), // ✅ Allows pull-to-refresh
          child: Column(
            children: [
              SizedBox(height: 20.h),

              ///<<<<========================= Budget Show List Design Only ================================>>>>
              Obx(() {
                switch (controller.rxRequestStatus.value) {
                  case Status.loading:
                    return const Center(child: CustomLoader()); // Show loading indicator

                  case Status.internetError:
                    return NoInternetScreen(onTap: () {
                      controller.getBudget();
                    });

                  case Status.error:
                    return GeneralErrorScreen(
                      onTap: () {
                        controller.getBudget();
                      },
                    );

                  case Status.completed:
                    final budgetList = controller.budgetData.value.result ?? [];

                    if (budgetList.isEmpty) {
                      // ✅ Show No Data Found message
                      return Center(
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 50.h),
                          child: Column(
                            children: [
                              const Icon(Icons.folder_off, size: 80, color: Colors.grey),
                              SizedBox(height: 10.h),
                              Text(
                                "No Data Found",
                                style: TextStyle(
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }

                    return Column(
                      children: List.generate(
                        budgetList.length,
                            (index) {
                          final data = budgetList[index];

                          double totalBudget = data.amount?.toDouble() ?? 0.0;
                          double totalExpense = data.currentExpense?.toDouble() ?? 0.0;
                          double progress = totalBudget > 0
                              ? (totalBudget - totalExpense) / totalBudget
                              : 0.0;

                          progress = progress.clamp(0.0, 1.0);

                          return GestureDetector(
                            onTap: () {
                              Get.toNamed(AppRoutes.budgetDetailsScreen);
                            },
                            child: BudgetCard(
                              image: data.budgetImage ?? "",
                              title: data.category ?? "",
                              amount: totalBudget,
                              progress: progress,
                              progressColor: AppColors.red,
                              backgroundColor: AppColors.blue100,
                              iconColor: Colors.grey,
                              amountColor: Colors.green,
                              onTap: () {
                                print("Home budget tapped!");
                              },
                            ),
                          );
                        },
                      ),
                    );
                }
              })
            ],
          ),
        ),
      ),
    );
  }
}
