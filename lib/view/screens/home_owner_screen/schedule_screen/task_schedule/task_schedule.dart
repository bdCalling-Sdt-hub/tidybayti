import 'package:flutter/material.dart';
import 'package:tidybayte/utils/app_icons/app_icons.dart';
import 'package:tidybayte/utils/app_strings/app_strings.dart';
import 'package:tidybayte/view/components/custom_menu_item/custom_menu_item.dart';

class TaskSchedule extends StatelessWidget {
  const TaskSchedule({super.key});

  @override 
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomMenuItem(
            image: AppIcons.allTask, text: AppStrings.allTasks, onTap: () {}),
        CustomMenuItem(
            image: AppIcons.completeTask,
            text: AppStrings.completedTask,
            onTap: () {}),
        CustomMenuItem(
            image: AppIcons.ongoing,
            text: AppStrings.ongoingTask,
            onTap: () {}),
        CustomMenuItem(
            image: AppIcons.ongoing, text: AppStrings.allTasks, onTap: () {}),
        CustomMenuItem(
            image: AppIcons.grocery, text: AppStrings.grocery, onTap: () {}),
      ],
    );
  }
}
