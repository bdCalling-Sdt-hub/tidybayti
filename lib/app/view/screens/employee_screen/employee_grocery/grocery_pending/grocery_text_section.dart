import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tidybayte/app/controller/employee_controller/employee_grocery_controller.dart';
import 'package:tidybayte/app/controller/employee_controller/employee_home_controller.dart';
import 'package:tidybayte/app/utils/app_strings/app_strings.dart';

import '../../../../../data/model/owner_model/grocery_model/grocery_model.dart';

class GroceryTextSection extends StatefulWidget {
  final String title;
  final int taskCount;
  final bool? isButton;
  final List<Result> tasks;
  final Function(String taskId)? onTap;

  const GroceryTextSection({
    super.key,
    required this.title,
    required this.taskCount,
    required this.tasks,
    this.onTap, this.isButton,
  });

  @override
  State<GroceryTextSection> createState() => _TaskSectionState();
}

class _TaskSectionState extends State<GroceryTextSection> {
  late List<bool> isTabList;
  bool isExpanded = false;

  @override
  void initState() {
    super.initState();
    isTabList = List<bool>.filled(widget.taskCount, false);
  }

  final EmployeeGroceryController controller = Get.find<EmployeeGroceryController>();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: widget.tasks.asMap().entries.map((entry) {
        Result task = entry.value;
        return Container(
          margin: const EdgeInsets.all(10),
          padding: EdgeInsets.all(16.w),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10.r),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                spreadRadius: 1,
                blurRadius: 5,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// =================== Task Title & Info Icon ===================
              Row(
                children: [
                  Expanded(
                    child: Text(
                      task.groceryName ?? "Unknown Task",
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      // _showTaskDetailsDialog(context, task);
                    },
                    child: Icon(
                      Icons.info_outline,
                      color: Colors.grey,
                      size: 24.sp,
                    ),
                  ),
                ],
              ),

              SizedBox(height: 8.h),
              Text(
                'Assigned to - ${task.assignedTo?.firstName ?? ""} ${task.assignedTo?.lastName ?? ""}',
                style: TextStyle(
                  fontSize: 14.sp,
                  color: Colors.grey[700],
                ),
              ),
              SizedBox(height: 8.h),

              /// =================== Task Date & Confirm Button ===================
              Row(
                children: [
                  Icon(
                    Icons.access_time_outlined,
                    color: Colors.grey,
                    size: 18.sp,
                  ),
                  SizedBox(width: 5.w),
                  Text(
                    task.startDateStr ?? "No Date",
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: Colors.grey[700],
                    ),
                  ),
                  const Spacer(),
                  widget.isButton == true?
                  ElevatedButton(
                    onPressed: () {
                      if (widget.onTap != null && !controller.isPendingTask.value) {
                        widget.onTap!(task.id ?? ""); // ✅ Call the method with taskId
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: controller.isPendingTask.value && controller.pendingTaskId.value == task.id
                          ? Colors.grey // ✅ Show grey when loading
                          : Colors.grey[800],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                    ),
                    child: controller.isPendingTask.value && controller.pendingTaskId.value == task.id
                        ? const SizedBox( // ✅ Show Loader While Task is Being Updated
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                        color: Colors.white,
                        strokeWidth: 2,
                      ),
                    )
                        : Text(
                      AppStrings.confirmTask.tr,
                      style: TextStyle(fontSize: 14.sp, color: Colors.white),
                    ),
                  ):SizedBox()

                ],
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}
