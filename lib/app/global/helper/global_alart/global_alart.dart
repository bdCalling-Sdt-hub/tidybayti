import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tidybayte/app/utils/app_colors/app_colors.dart';
import 'package:tidybayte/app/utils/app_strings/app_strings.dart';

class GlobalAlert{

//Delete Dialog
  static showDeleteDialog(BuildContext context, VoidCallback onConfirm,String title) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title:  Text(AppStrings.confirmDelete.tr),
          content:  Text(title),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child:  Text(AppStrings.cancel.tr, style: const TextStyle(color: Colors.grey)),
            ),
            ElevatedButton(
              onPressed: () {
                onConfirm();
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(backgroundColor: AppColors.addedColor),
              child:  Text(AppStrings.delete.tr),
            ),
          ],
        );
      },
    );
  }

}