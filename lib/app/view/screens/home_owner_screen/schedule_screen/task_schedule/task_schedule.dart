import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tidybayte/app/core/app_routes/app_routes.dart';
import 'package:tidybayte/app/utils/app_colors/app_colors.dart';
import 'package:tidybayte/app/utils/app_icons/app_icons.dart';
import 'package:tidybayte/app/utils/app_strings/app_strings.dart';
import 'package:tidybayte/app/view/components/custom_image/custom_image.dart';
import 'package:tidybayte/app/view/components/custom_menu_item/custom_menu_item.dart';

import 'package:tidybayte/app/view/components/custom_text/custom_text.dart';

class TaskSchedule extends StatelessWidget {
  const TaskSchedule({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [

        ///==========================Add Task====================
        GestureDetector(
          onTap: () {
            Get.toNamed(AppRoutes.createTask);
          },
          child: Container(
            padding: const EdgeInsets.all(10),
            margin: const EdgeInsets.all(20),
            color: AppColors.blue50,
            child:  Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const CustomImage(imageSrc: AppIcons.add),
                CustomText(
                  left: 10,
                  text: AppStrings.addTask.tr,
                  fontSize: 24,
                  fontWeight: FontWeight.w400,
                  color: AppColors.dark400,
                )
              ],
            ),
          ),
        ),

        ///========================All task ======================
        CustomMenuItem(
            image: AppIcons.allTask,
            text: AppStrings.allTasks.tr,
            onTap: () {
              Get.toNamed(AppRoutes.allTaskScreen);
            }),

        ///=============================Completed task===============
        CustomMenuItem(
            image: AppIcons.completeTask,
            text: AppStrings.completedTask.tr,
            onTap: () {
              Get.toNamed(AppRoutes.completedScreen);

            }),

        ///==================================Ongoing Task==============
        CustomMenuItem(
            image: AppIcons.ongoing,
            text: AppStrings.ongoingTask.tr,
            onTap: () {
              Get.toNamed(AppRoutes.ongoingTask);

            }),

        ///=============================Pending ==================
        CustomMenuItem(
            image: AppIcons.ongoing,
            text: AppStrings.pendingTask.tr,
            onTap: () {
              Get.toNamed(AppRoutes.pendingTask);

            }),

        ///==============================Grocery====================
        CustomMenuItem(
            image: AppIcons.grocery,
            text: AppStrings.groceryList.tr,
            onTap: () {
              Get.toNamed(AppRoutes.groceryTask);

            }),
      ],
    );
  }
}
