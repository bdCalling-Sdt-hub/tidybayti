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
  final bool? isRemove;
  final VoidCallback? onTap;
  final VoidCallback? onRemove;
  final VoidCallback? onDownload;

  const CustomMenuAppbar({
    super.key,
    required this.title,
    this.backIcon = AppIcons.back,
    this.onBack,
    this.isEdit,
    this.onTap,
    this.download,
    this.onDownload, this.isRemove, this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h),
      child: Row(
        children: [
          if (backIcon != null)
            IconButton(onPressed: (){
              Get.back();
            }, icon: const Icon(Icons.arrow_back)),

          Expanded(
            child: CustomText(
              textAlign: TextAlign.center,
              text: title,
              fontWeight: FontWeight.w500,
              fontSize: 20,
              color: AppColors.blue900,
            ),
          ),
          isEdit == true
              ? GestureDetector(
                  onTap: onTap,
                  child: const CustomImage(imageSrc: AppIcons.edit))
              : SizedBox(width: 5.w),

          isRemove == true
              ? GestureDetector(
                  onTap: onRemove,
                  child: const Icon(Icons.delete,color: Colors.grey,))
              : SizedBox(width: 5.w),

          download == true
              ? GestureDetector(
                  onTap: onDownload,
                  child: const CustomImage(imageSrc: AppIcons.download))
              : SizedBox(
                  width: 5.w), // Add space for alignment purposes (right side)
        ],
      ),
    );
  }
}
