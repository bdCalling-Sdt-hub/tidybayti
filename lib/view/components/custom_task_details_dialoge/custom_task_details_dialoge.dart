import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tidybayte/utils/app_colors/app_colors.dart';
import 'package:tidybayte/view/components/custom_text/custom_text.dart';

class CustomTaskDetailsDialoge extends StatelessWidget {
  final String task;
  final String assignTo;
  final String recurrence;
  final String date;
  final String time;
  final String taskDetails;
  final String additionalMessage;

  const CustomTaskDetailsDialoge({
    super.key,
    required this.task,
    required this.assignTo,
    required this.recurrence,
    required this.date,
    required this.time,
    required this.taskDetails,
    required this.additionalMessage,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.r),
      ),
      titlePadding: EdgeInsets.only(top: 20.h),
      contentPadding: EdgeInsets.symmetric(horizontal: 20.w),
      actionsPadding: EdgeInsets.all(10.w),
      title: DialogTitle(onClose: () => Navigator.of(context).pop()),
      content: SizedBox(
        width: double.maxFinite,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            DetailRow(label: 'Task', value: task),
            DetailRow(label: 'Assign to', value: assignTo),
            DetailRow(label: 'Recurrence', value: recurrence),
            DetailRow(label: 'Date', value: date),
            DetailRow(label: 'Time', value: time),
            SizedBox(height: 20.h),
            DetailDescription(title: 'Task details:', description: taskDetails),
            SizedBox(height: 15.h),
            DetailDescription(
                title: 'Additional message:', description: additionalMessage),
            SizedBox(height: 25.h),

          ],
        ),
      ),

    );
  }
}






















// Custom Widget for Dialog Title with Close Icon
class DialogTitle extends StatelessWidget {
  final VoidCallback onClose;

  const DialogTitle({super.key, required this.onClose});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        const CustomText(
          text: 'Task schedule details',
          fontSize: 20,
          left: 25,
          fontWeight: FontWeight.w500,
          color: AppColors.dark500,
          bottom: 15,
        ),
        const Spacer(),
        GestureDetector(
          onTap: onClose,
          child: const Icon(
            Icons.close,
            size: 24,
            color: Colors.black,
          ),
        ),
        SizedBox(
          width: 10.w,
        ),
      ],
    );
  }
}

// Custom Widget for Row Displaying Task Detail
class DetailRow extends StatelessWidget {
  final String label;
  final String value;

  const DetailRow({Key? key, required this.label, required this.value})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 8.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CustomText(
            text: '$label',
            color: AppColors.dark300,
            fontWeight: FontWeight.w500,
            fontSize: 16,
          ),
          CustomText(
            text: '$value',
            color: AppColors.dark300,
            fontWeight: FontWeight.w500,
            fontSize: 16,
          ),

        ],
      ),
    );
  }
}

class DetailDescription extends StatelessWidget {
  final String title;
  final String description;

  const DetailDescription({
    super.key,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
    CustomText(text: title,fontWeight: FontWeight.w500,fontSize: 16,color: AppColors.dark400,),
        Text(
          description,
          style: TextStyle(
            fontSize: 12.sp,
            color: Colors.grey[600],
          ),
        ),
      ],
    );
  }
}
