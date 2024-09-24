import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tidybayte/core/app_routes/app_routes.dart';
import 'package:tidybayte/utils/app_colors/app_colors.dart';
import 'package:tidybayte/view/components/budget_card/butget_card.dart';

class WalletBudgetScreen extends StatelessWidget {
  const WalletBudgetScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Column(
        children: [
          SizedBox(height: 20.h),

          ///<<<<========================= Budget Show List Design Only ================================>>>>
          Column(
            children: List.generate(
              2, // Dummy count for 1 budget item (for design purposes)
                  (index) =>

                      GestureDetector(
                        onTap: (){
                          Get.toNamed(AppRoutes.budgetDetailsScreen);
                        },
                        child: BudgetCard(
                          icon: Icons.home,
                          title: "Home",
                          amount: 1000,
                          progress: 0.4,
                          progressColor: AppColors.red,
                          backgroundColor: AppColors.blue100,
                          iconColor: Colors.grey,
                          amountColor: Colors.green,
                          onTap: () {
                            // Handle your tap logic here
                            print("Home budget tapped!");
                          },
                        ),
                      ),
            ),
          ),


        ],
      ),
    );
  }
}
