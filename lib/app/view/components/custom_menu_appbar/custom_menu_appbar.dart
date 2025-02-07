import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:tidybayte/app/utils/app_colors/app_colors.dart';
import 'package:tidybayte/app/utils/app_icons/app_icons.dart';
import 'package:tidybayte/app/view/components/custom_image/custom_image.dart';
import 'package:tidybayte/app/view/components/custom_text/custom_text.dart';

class CustomMenuAppbar extends StatelessWidget {
  final String title;
  final String? backIcon;
  final VoidCallback? onBack;
  final bool? isEdit;
  final bool? download;
  final VoidCallback? onTap;
  final VoidCallback? onDownload;

  const CustomMenuAppbar({
    super.key,
    required this.title,
    this.backIcon = AppIcons.back, // Default back icon
    this.onBack, this.isEdit, this.onTap, this.download, this.onDownload, // Optional onBack callback
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h),
      child: Row(
        children: [
          if (backIcon != null)
            GestureDetector(
              onTap: onBack ?? () => Get.back(), // Fallback to Get.back() if onBack is not provided
              child: CustomImage(imageSrc: backIcon!),
            ),
           Expanded(
            child: CustomText(
              textAlign: TextAlign.center,
              text: title,
              fontWeight: FontWeight.w500,
              fontSize: 20,
              color: AppColors.blue900,
            ),
          ),
          isEdit==true?
          GestureDetector(
              onTap: onTap,
              child: const CustomImage(imageSrc: AppIcons.edit)):
          SizedBox(width: 5.w),

          download==true?
          GestureDetector(
              onTap: onDownload,
              child: const CustomImage(imageSrc: AppIcons.download)):
          SizedBox(width: 5.w), // Add space for alignment purposes (right side)
        ],
      ),
    );
  }
}
