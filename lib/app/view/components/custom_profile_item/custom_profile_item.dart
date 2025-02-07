import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tidybayte/app/utils/app_colors/app_colors.dart';
import 'package:tidybayte/app/view/components/custom_text/custom_text.dart';

class CustomProfileItem extends StatelessWidget {
  final String title;
  final String subTitle;

  const CustomProfileItem({
    super.key,
    required this.title,
    required this.subTitle,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 4,
          child: CustomText(
            textAlign: TextAlign.start,
            color: AppColors.dark300,
            text: title,
            fontWeight: FontWeight.w400,
            fontSize: 16,
            bottom: 10,
          ),
        ),  Expanded(
          flex: 6,
          child: CustomText(
            textAlign: TextAlign.start,
            color: AppColors.dark300,
            text: subTitle,
            fontWeight: FontWeight.w400,
            fontSize: 16,
            bottom: 10,
          ),
        ),

        SizedBox(height: 8.h),
      ],
    );
  }
}