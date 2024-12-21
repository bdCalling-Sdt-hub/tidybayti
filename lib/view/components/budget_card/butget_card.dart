import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:tidybayte/utils/app_colors/app_colors.dart';
import 'package:tidybayte/view/components/custom_text/custom_text.dart';


class BudgetCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final double amount;
  final double progress;
  final Color progressColor;
  final Color backgroundColor;
  final Color iconColor;
  final Color amountColor;
  final VoidCallback onTap;

  const BudgetCard({
    super.key,
    required this.icon,
    required this.title,
    required this.amount,
    required this.progress,
    required this.progressColor,
    required this.backgroundColor,
    required this.iconColor,
    required this.amountColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          height: 75.h,
          color: AppColors.employeeCardColor,
          width: MediaQuery.of(context).size.width,
          child: Row(
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        Icon(
                          icon,
                          size: 20.w,
                          color: iconColor,
                        ),
                        SizedBox(width: 8.w),
                        CustomText(
                          text: title,
                          fontWeight: FontWeight.w400,
                          fontSize: 16,
                          color: AppColors.blue800,
                        ),
                        const Spacer(),
                        CustomText(
                          text: "\$$amount", // Dynamic amount
                          fontWeight: FontWeight.w600,
                          fontSize: 20.sp,
                          color: amountColor,
                        ),
                      ],
                    ),
                    SizedBox(height: 8.h),
                    LinearPercentIndicator(
                      lineHeight: 8.h,
                      percent: progress, // Dynamic progress value
                      backgroundColor: backgroundColor,
                      progressColor: progressColor,
                      barRadius: const Radius.circular(8),
                    ),
                  ],
                ),
              ),
              SizedBox(width: 16.w),
              GestureDetector(
                onTap: onTap,
                child: Container(
                 decoration: BoxDecoration(
                   color: AppColors.blue900,
                   shape: BoxShape.circle
                 ),
                  child: Icon(
                    Icons.chevron_right,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 10.h,)
      ],
    );
  }
}
