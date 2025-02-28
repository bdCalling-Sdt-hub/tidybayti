import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tidybayte/app/controller/employee_controller/employee_grocery_controller.dart';
import 'package:tidybayte/app/utils/app_colors/app_colors.dart';
import 'package:tidybayte/app/utils/app_strings/app_strings.dart';

import 'package:tidybayte/app/view/components/custom_text/custom_text.dart';
import 'package:tidybayte/app/view/screens/employee_screen/employee_grocery/grocery_pending/grocery_text_section.dart';

class GroceryCompleteScreen extends StatefulWidget {
  const GroceryCompleteScreen({super.key});

  @override
  State<GroceryCompleteScreen> createState() => _AdditionalPendingTaskState();
}

class _AdditionalPendingTaskState extends State<GroceryCompleteScreen> {

  final EmployeeGroceryController controller = Get.find<EmployeeGroceryController>();

  @override
  void initState() {
    controller.getComplete();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.w),
      child: Obx(() {
        final taskList = controller.completeTask.value.result ?? [];

        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (taskList.isEmpty) {
          return const Center(
            child: CustomText(
              text: "No Ongoing tasks available",
              color: AppColors.dark200,
              fontWeight: FontWeight.w400,
              fontSize: 16,
            ),
          );
        }

        return Column(
          children: [
            /// ================== Task Schedule Section ==================
            GroceryTextSection(

              title: AppStrings.taskSchedule.tr,
              taskCount: taskList.length,
              tasks: taskList,

            ),
            SizedBox(height: 16.h),
          ],
        );
      }),
    );
  }
}