import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tidybayte/utils/app_colors/app_colors.dart';
import 'package:tidybayte/utils/app_icons/app_icons.dart';
import 'package:tidybayte/utils/app_strings/app_strings.dart';
import 'package:tidybayte/view/components/custom_image/custom_image.dart';
import 'package:tidybayte/view/components/custom_text/custom_text.dart';

class CustomRoomCard extends StatelessWidget {
  final String taskName;
  final String assignedTo;
  final String time;
  final VoidCallback onInfoPressed;
  final VoidCallback onDeletePressed;

  const CustomRoomCard({
    super.key,
    required this.taskName,
    required this.assignedTo,
    required this.time,
    required this.onInfoPressed,
    required this.onDeletePressed,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          color: Colors.white,
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CustomText(
                    text: taskName,
                    color: AppColors.dark400,
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                  ),
                  const Spacer(),
                  GestureDetector(
                    onTap: onInfoPressed,
                    child: const CustomImage(
                      imageSrc:AppIcons.details,
                      imageType: ImageType.svg,
                      imageColor: AppColors.dark400,
                    ),
                  ),
                  SizedBox(width: 16.w,),
                  GestureDetector(
                    onTap: onDeletePressed,
                    child: const CustomImage(
                      imageSrc:AppIcons.delete,
                      imageType: ImageType.svg,
                      imageColor: AppColors.dark400,
                    ),
                  ),
                ],
              ),
              CustomText(
                text: 'Assigned to - $assignedTo',
                color: AppColors.dark400,
                fontSize: 14,
                top: 8,
                bottom: 8,
                fontWeight: FontWeight.w400,
              ),
              Row(
                children: [
                  const CustomImage(
                    imageSrc:AppIcons.watch,
                    imageType: ImageType.svg,
                    imageColor: AppColors.dark400,
                  ),
                  CustomText(
                    left: 5,
                    text: time,
                    color: AppColors.dark400,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                ],
              )
            ],
          ),
        ),
        SizedBox(
          height: 10.h,
        )
      ],
    );
  }
}
