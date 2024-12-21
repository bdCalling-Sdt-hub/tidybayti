import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tidybayte/core/app_routes/app_routes.dart';
import 'package:tidybayte/main.dart';  // Adjust the import based on your app structure
import 'package:tidybayte/utils/app_colors/app_colors.dart';
import 'package:tidybayte/utils/app_icons/app_icons.dart';
import 'package:tidybayte/utils/app_strings/app_strings.dart';
import 'package:tidybayte/view/components/custom_image/custom_image.dart';
import 'package:tidybayte/view/components/custom_text/custom_text.dart';
import 'package:get/get.dart'; // Assuming you use GetX for routing

class AssignTaskSuccessfullyScreen extends StatefulWidget {
  const AssignTaskSuccessfullyScreen({super.key});

  @override
  _AssignTaskSuccessfullyScreenState createState() => _AssignTaskSuccessfullyScreenState();
}

class _AssignTaskSuccessfullyScreenState extends State<AssignTaskSuccessfullyScreen> {
  @override
  void initState() {
    super.initState();

    // Automatically navigate to another screen after 5 seconds
    Future.delayed(Duration(seconds: 5), () {
      Get.toNamed(AppRoutes.mainSentSuccessfullyScreen);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            SizedBox(height: 300.h),
            Container(
              height: 96,
              width: 96,
              decoration: BoxDecoration(
                color: AppColors.blue900,
                shape: BoxShape.circle,
              ),
              child: Center(child: CustomImage(imageSrc: AppIcons.rightUp)),
            ),
            CustomText(
              top: 24,
              bottom: 40,
              maxLines: 2,
              text: AppStrings.assignTaskSuccessfully,
              fontWeight: FontWeight.w400,
              fontSize: 24,
              color: AppColors.dark400,
            ),
          ],
        ),
      ),
    );
  }
}
