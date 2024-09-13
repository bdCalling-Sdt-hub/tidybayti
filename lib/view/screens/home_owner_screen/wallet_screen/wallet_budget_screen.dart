import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tidybayte/core/app_routes/app_routes.dart';
import 'package:tidybayte/view/components/custom_text/custom_text.dart';

class WalletBudgetScreen extends StatelessWidget {
  const WalletBudgetScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
            onTap: (){
              Get.toNamed(AppRoutes.createBudgetScreen);
            },
            child: CustomText(text: 'Create Budget',color: Colors.red,)),

        GestureDetector(
            onTap: (){
              Get.toNamed(AppRoutes.budgetDetailsScreen);
            },
            child: CustomText(text: 'Budget Details',color: Colors.red,)),
      ],
    );
  }
}
