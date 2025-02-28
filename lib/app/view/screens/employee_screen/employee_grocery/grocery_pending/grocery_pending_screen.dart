import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tidybayte/app/controller/employee_controller/employee_grocery_controller.dart';
import 'package:tidybayte/app/utils/app_colors/app_colors.dart';
import 'package:tidybayte/app/utils/app_strings/app_strings.dart';
import 'package:tidybayte/app/view/components/custom_text/custom_text.dart';

import 'grocery_text_section.dart';

class GroceryPendingScreen extends StatefulWidget {
  const GroceryPendingScreen({super.key});

  @override
  State<GroceryPendingScreen> createState() => _AdditionalPendingTaskState();
}

class _AdditionalPendingTaskState extends State<GroceryPendingScreen> {
  final EmployeeGroceryController controller = Get.find<EmployeeGroceryController>();

  @override
  void initState() {
    controller.getPending();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.w),
      child: Obx(() {
        final taskList = controller.pendingTask.value.result ?? [];

        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (taskList.isEmpty) {
          return const Center(
            child: CustomText(
              text: "No pending grocery available",
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
              isButton: true,
              title: AppStrings.taskSchedule.tr,
              taskCount: taskList.length,
              tasks: taskList,
              onTap: (String groceryId) {
                controller.employeePendingTask(groceryId: groceryId, status: "ongoing");
              },
            ),
            SizedBox(height: 16.h),
          ],
        );
      }),
    );
  }
}
