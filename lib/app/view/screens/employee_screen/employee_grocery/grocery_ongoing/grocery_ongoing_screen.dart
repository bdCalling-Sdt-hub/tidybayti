import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tidybayte/app/controller/employee_controller/employee_grocery_controller.dart';
import 'package:tidybayte/app/controller/employee_controller/employee_home_controller.dart';
import 'package:tidybayte/app/utils/app_colors/app_colors.dart';
import 'package:tidybayte/app/utils/app_strings/app_strings.dart';
import 'package:tidybayte/app/view/components/custom_text/custom_text.dart';
import 'package:tidybayte/app/view/screens/employee_screen/employee_grocery/grocery_pending/grocery_text_section.dart';


class GroceryOngoingScreen extends StatefulWidget {
  const GroceryOngoingScreen({super.key});

  @override
  State<GroceryOngoingScreen> createState() => _AdditionalPendingTaskState();
}

class _AdditionalPendingTaskState extends State<GroceryOngoingScreen> {
  final EmployeeGroceryController controller = Get.find<EmployeeGroceryController>();

  @override
  void initState() {
    controller.getOngoing();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.w),
      child: Obx(() {
        final taskList = controller.ongoingTask.value.result ?? [];

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
              isButton: true,
              title: AppStrings.taskSchedule.tr,
              taskCount: taskList.length,
              tasks: taskList,
              onTap: (String taskId) {
                controller.employeePendingTask(
                    groceryId: taskId, status: "completed");
              },
            ),
            SizedBox(height: 16.h),
          ],
        );
      }),
    );
  }
}
