import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tidybayte/app/core/app_routes/app_routes.dart';
import 'package:tidybayte/app/utils/app_colors/app_colors.dart';
import 'package:tidybayte/app/utils/app_const/app_const.dart';
import 'package:tidybayte/app/utils/app_icons/app_icons.dart';
import 'package:tidybayte/app/utils/app_images/app_images.dart';
import 'package:tidybayte/app/utils/app_strings/app_strings.dart';
import 'package:tidybayte/app/view/components/budget_card/butget_card.dart';
import 'package:tidybayte/app/view/components/custom_button/custom_button.dart';
import 'package:tidybayte/app/view/components/custom_image/custom_image.dart';
import 'package:tidybayte/app/view/components/custom_menu_appbar/custom_menu_appbar.dart';
import 'package:tidybayte/app/view/components/custom_netwrok_image/custom_network_image.dart';
import 'package:tidybayte/app/view/components/custom_room_card/custom_room_card.dart';
import 'package:tidybayte/app/view/components/custom_task_details_dialoge/custom_task_details_dialoge.dart';
import 'package:tidybayte/app/view/components/custom_text/custom_text.dart';
import 'package:tidybayte/app/view/components/custom_text_field/custom_text_field.dart';
import 'package:tidybayte/app/view/components/nav_bar/nav_bar.dart';
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
