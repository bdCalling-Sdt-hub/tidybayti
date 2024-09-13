import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tidybayte/utils/app_colors/app_colors.dart';
import 'package:tidybayte/view/components/custom_text/custom_text.dart';

class CustomContainer extends StatelessWidget {
  final String text;
  final Color textColor;

  const CustomContainer({
    super.key,
    required this.text, required this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      height: 64.h,
      width: MediaQuery.of(context).size.width,
      color: AppColors.blue50,
      child: CustomText(
        textAlign: TextAlign.start,
        text: text,
        fontWeight: FontWeight.w300,
        fontSize: 24,
        color: textColor,
      ),
    );
  }
}