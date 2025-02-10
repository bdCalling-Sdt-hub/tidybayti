import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tidybayte/app/utils/app_colors/app_colors.dart';
import 'package:tidybayte/app/view/components/custom_text/custom_text.dart';

class CustomPersonalProfile extends StatelessWidget {
  final String title;
  final String subTitle;

  const CustomPersonalProfile({
    super.key,
    required this.title,
    required this.subTitle,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(
          color: AppColors.dark300,
          text: title,
          fontWeight: FontWeight.w400,
          fontSize: 16,
          bottom: 10,
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.all(12),
          color: AppColors.blue50,
          child: CustomText(
            textAlign: TextAlign.start,
            text: subTitle,
            color: AppColors.dark300,
            fontSize: 16,
            fontWeight: FontWeight.w400,
          ),
        ),
        SizedBox(height: 8.h),
      ],
    );
  }
}