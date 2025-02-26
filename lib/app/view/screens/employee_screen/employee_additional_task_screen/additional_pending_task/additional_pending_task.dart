import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tidybayte/app/controller/employee_controller/employee_home_controller.dart';
import 'package:tidybayte/app/utils/app_colors/app_colors.dart';
import 'package:tidybayte/app/utils/app_strings/app_strings.dart';
import 'package:tidybayte/app/view/components/custom_text/custom_text.dart';
import 'inner/task_section.dart';

class AdditionalPendingTask extends StatefulWidget {
  const AdditionalPendingTask({super.key});

  @override
  State<AdditionalPendingTask> createState() => _AdditionalPendingTaskState();
}

class _AdditionalPendingTaskState extends State<AdditionalPendingTask> {
  final EmployeeHomeController controller = Get.find<EmployeeHomeController>();

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
              text: "No pending tasks available",
              color: AppColors.dark200,
              fontWeight: FontWeight.w400,
              fontSize: 16,
            ),
          );
        }

        return Column(
          children: [
            /// ================== Task Schedule Section ==================
            TaskSection(
              title: AppStrings.taskSchedule.tr,
              taskCount: taskList.length,
              tasks: taskList,
              onTap: (String taskId) {
                controller.employeePendingTask(taskId: taskId, status: "ongoing");
              },
            ),
            SizedBox(height: 16.h),
          ],
        );
      }),
    );
  }
}
