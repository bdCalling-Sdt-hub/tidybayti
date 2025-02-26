import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tidybayte/app/controller/employee_controller/employee_home_controller.dart';
import 'package:tidybayte/app/utils/app_colors/app_colors.dart';
import 'package:tidybayte/app/utils/app_strings/app_strings.dart';

import 'package:tidybayte/app/view/components/custom_text/custom_text.dart';
import 'package:tidybayte/app/view/screens/employee_screen/employee_additional_task_screen/additional_pending_task/inner/task_section.dart';

class AdditionalCompletedTask extends StatefulWidget {
  const AdditionalCompletedTask({super.key});

  @override
  State<AdditionalCompletedTask> createState() => _AdditionalPendingTaskState();
}

class _AdditionalPendingTaskState extends State<AdditionalCompletedTask> {

  final EmployeeHomeController controller = Get.find<EmployeeHomeController>();

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
            TaskSection(

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

// class TaskSection extends StatefulWidget {
//   final String title;
//   final String taskTitle;
//   final String assignedTo;
//   final String dateTime;
//   final int taskCount;
//
//   const TaskSection({
//     super.key,
//     required this.title,
//     required this.taskTitle,
//     required this.assignedTo,
//     required this.dateTime,
//     required this.taskCount,
//   });
//
//   @override
//   State<TaskSection> createState() => _TaskSectionState();
// }
//
// class _TaskSectionState extends State<TaskSection> {
//   late List<bool> isTabList; // A list to control each button's state
//   bool isExpanded =
//       false; // This controls whether the content is expanded or not.
//
//   @override
//   void initState() {
//     super.initState();
//     // Initialize the list with 'false' values for each button
//     isTabList = List<bool>.filled(widget.taskCount, false);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Text(
//               widget.title,
//               style: TextStyle(
//                 fontSize: 18.sp,
//                 fontWeight: FontWeight.w500,
//                 color: Colors.black,
//               ),
//             ),
//             IconButton(
//               icon: Icon(
//                 isExpanded
//                     ? Icons.keyboard_arrow_up
//                     : Icons.keyboard_arrow_down,
//                 size: 24.sp,
//                 color: Colors.black,
//               ),
//               onPressed: () {
//                 setState(() {
//                   isExpanded =
//                       !isExpanded; // Toggle the state when the button is pressed
//                 });
//               },
//             ),
//           ],
//         ),
//
//         // Conditional Display of Additional Content
//         if (isExpanded) ...[
//           // Task Card Information
//           Column(
//             children: List.generate(widget.taskCount, (index) {
//               return Container(
//                 margin: const EdgeInsets.all(10),
//                 padding: EdgeInsets.all(16.w),
//                 decoration: BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.circular(10.r),
//                   boxShadow: [
//                     BoxShadow(
//                       color: Colors.grey.withOpacity(0.2),
//                       spreadRadius: 1,
//                       blurRadius: 5,
//                       offset: const Offset(0, 3),
//                     ),
//                   ],
//                 ),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Row(
//                       children: [
//                         Expanded(
//                           child: Text(
//                             widget.taskTitle,
//                             style: TextStyle(
//                               fontSize: 18.sp,
//                               fontWeight: FontWeight.w500,
//                               color: Colors.black,
//                             ),
//                           ),
//                         ),
//                         GestureDetector(
//                           onTap: () {
//                             _showTaskDetailsDialog(context);
//                           },
//                           child: Icon(
//                             Icons.info_outline,
//                             color: Colors.grey,
//                             size: 24.sp,
//                           ),
//                         ),
//
//                       ],
//                     ),
//                     SizedBox(height: 8.h),
//                     Text(
//                       'Assigned to - ${widget.assignedTo}',
//                       style: TextStyle(
//                         fontSize: 14.sp,
//                         color: Colors.grey[700],
//                       ),
//                     ),
//                     SizedBox(height: 8.h),
//                     Row(
//                       children: [
//                         Icon(
//                           Icons.access_time_outlined,
//                           color: Colors.grey,
//                           size: 18.sp,
//                         ),
//                         SizedBox(width: 5.w),
//                         Text(
//                           widget.dateTime,
//                           style: TextStyle(
//                             fontSize: 14.sp,
//                             color: Colors.grey[700],
//                           ),
//                         ),
//                         const Spacer(),
//                         const CustomText(
//                           text: 'Completed',
//                           fontSize: 16,
//                           fontWeight: FontWeight.w500,
//                           color: AppColors.dark500,
//                         )
//                       ],
//                     ),
//                   ],
//                 ),
//               );
//             }),
//           )
//         ],
//       ],
//     );
//   }
// }
//
// void _showTaskDetailsDialog(BuildContext context) {
//   showDialog(
//     context: context,
//     builder: (BuildContext context) {
//       return const CustomTaskDetailsDialoge(
//         task: 'Clean Car',
//         assignTo: 'Siddhu',
//         recurrence: 'Ontime',
//         date: '10 Aug, 2024',
//         time: 'Worktime',
//         taskDetails:
//             'gravida elit enim. lobortis, ex orci lobortis,\nDonec orci elit felis, luctus ultrices odio',
//         additionalMessage:
//             'gravida elit enim. lobortis, ex orci lobortis,\nDonec orci elit felis, luctus ultrices odio',
//       );
//     },
//   );
// }
//
// void addNote(BuildContext context) {
//   showDialog(
//     context: context,
//     builder: (BuildContext context) {
//       TextEditingController noteController =
//           TextEditingController(); // To handle text input
//
//       return AlertDialog(
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(20.r),
//         ),
//         title: Center(
//             child: Row(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             Text("Add Note"),
//             Spacer(),
//             GestureDetector(
//                 onTap: () {
//                   Get.back();
//                 },
//                 child: CustomImage(imageSrc: AppIcons.x))
//           ],
//         )),
//         content: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             CustomTextField(
//               maxLines: 10,
//               fillColor: AppColors.blue100,
//             ),
//             SizedBox(
//               height: 20.h,
//             ),
//             CustomButton(
//                 fillColor: AppColors.blue300,
//                 title: AppStrings.save,
//                 onTap: () {
//                   Get.back();
//                 })
//           ],
//         ),
//       );
//     },
//   );
// }
