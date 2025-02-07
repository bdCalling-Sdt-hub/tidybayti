import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tidybayte/app/core/app_routes/app_routes.dart';
import 'package:tidybayte/app/utils/app_colors/app_colors.dart';
import 'package:tidybayte/app/utils/app_const/app_const.dart';
import 'package:tidybayte/app/utils/app_icons/app_icons.dart';
import 'package:tidybayte/app/utils/app_images/app_images.dart';
import 'package:tidybayte/app/utils/app_strings/app_strings.dart';
import 'package:tidybayte/app/view/components/custom_button/custom_button.dart';
import 'package:tidybayte/app/view/components/custom_image/custom_image.dart';
import 'package:tidybayte/app/view/components/custom_menu_appbar/custom_menu_appbar.dart';
import 'package:tidybayte/app/view/components/custom_menu_item/custom_menu_item.dart';
import 'package:tidybayte/app/view/components/custom_netwrok_image/custom_network_image.dart';
import 'package:tidybayte/app/view/components/custom_room_card/custom_room_card.dart';
import 'package:tidybayte/app/view/components/custom_task_details_dialoge/custom_task_details_dialoge.dart';
import 'package:tidybayte/app/view/components/custom_text/custom_text.dart';
import 'package:tidybayte/app/view/components/custom_text_field/custom_text_field.dart';
import 'package:tidybayte/app/view/components/nav_bar/nav_bar.dart';
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
            child: const Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomImage(imageSrc: AppIcons.add),
                CustomText(
                  left: 10,
                  text: AppStrings.addTask,
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
            text: AppStrings.allTasks,
            onTap: () {
              Get.toNamed(AppRoutes.allTaskScreen);
            }),

        ///=============================Completed task===============
        CustomMenuItem(
            image: AppIcons.completeTask,
            text: AppStrings.completedTask,
            onTap: () {
              Get.toNamed(AppRoutes.completedScreen);

            }),

        ///==================================Ongoing Task==============
        CustomMenuItem(
            image: AppIcons.ongoing,
            text: AppStrings.ongoingTask,
            onTap: () {
              Get.toNamed(AppRoutes.ongoingTask);

            }),

        ///=============================Pending ==================
        CustomMenuItem(
            image: AppIcons.ongoing,
            text: AppStrings.pendingTask,
            onTap: () {
              Get.toNamed(AppRoutes.pendingTask);

            }),

        ///==============================Grocery====================
        CustomMenuItem(
            image: AppIcons.grocery,
            text: 'Grocery list',
            onTap: () {
              Get.toNamed(AppRoutes.groceryTask);

            }),
      ],
    );
  }
}
