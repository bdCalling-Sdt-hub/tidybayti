import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tidybayte/app/core/app_routes/app_routes.dart';
import 'package:tidybayte/app/utils/app_colors/app_colors.dart';
import 'package:tidybayte/app/utils/app_const/app_const.dart';
import 'package:tidybayte/app/utils/app_icons/app_icons.dart';
import 'package:tidybayte/app/utils/app_images/app_images.dart';
import 'package:tidybayte/app/utils/app_strings/app_strings.dart';
import 'package:tidybayte/app/view/components/custom_button/custom_button.dart';
import 'package:tidybayte/app/view/components/custom_image/custom_image.dart';
import 'package:tidybayte/app/view/components/custom_menu_appbar/custom_menu_appbar.dart';
import 'package:tidybayte/app/view/components/custom_netwrok_image/custom_network_image.dart';
import 'package:tidybayte/app/view/components/custom_room_card/custom_room_card.dart';
import 'package:tidybayte/app/view/components/custom_task_details_dialoge/custom_task_details_dialoge.dart';
import 'package:tidybayte/app/view/components/custom_text/custom_text.dart';
import 'package:tidybayte/app/view/components/custom_text_field/custom_text_field.dart';
import 'package:tidybayte/app/view/components/nav_bar/nav_bar.dart';
class WorkSchedule extends StatefulWidget {
  const WorkSchedule({super.key});

  @override
  State<WorkSchedule> createState() => _WorkScheduleState();
}

class _WorkScheduleState extends State<WorkSchedule> {
  final List<String> dayName = [
    'All',
    'Sunday',
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday'
  ];

  // To track selected day index
  int? selectedDayIndex;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: List.generate(dayName.length, (index) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedDayIndex = index;
                    });
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: selectedDayIndex == index
                          ? AppColors.blue900
                          : Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: selectedDayIndex == index
                            ? AppColors.blue900
                            : AppColors.blue50,
                      ),
                    ),
                    padding: const EdgeInsets.all(10),
                    margin: const EdgeInsets.only(right: 10),
                    child: CustomText(
                      text: dayName[index],
                      color: selectedDayIndex == index
                          ? Colors.white
                          : AppColors.blue900,
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                    ),
                  ),
                );
              }),
            ),
          ),
          const SizedBox(height: 20),
          selectedDayIndex != null
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      textAlign: TextAlign.start,
                      text: 'Selected Day: ${dayName[selectedDayIndex!]}',
                      color: AppColors.dark300,
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                    ),
                    const SizedBox(height: 10),
                    Column(
                      children: List.generate(4, (index) {
                        return Container(
                          color: Colors.white,
                          padding: const EdgeInsets.all(10),
                          margin: const EdgeInsets.only(top: 10),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomNetworkImage(
                                boxShape: BoxShape.circle,
                                imageUrl: AppConstants.userNtr,
                                height: 40,
                                width: 40,
                              ),
                              SizedBox(
                                width: 10.w,
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        CustomText(
                                          textAlign: TextAlign.start,
                                          text: 'Sadhu',
                                          color: AppColors.dark400,
                                          fontWeight: FontWeight.w400,
                                          fontSize: 18,
                                        ),
                                        Spacer(),
                                        CustomText(
                                          textAlign: TextAlign.start,
                                          text: 'Working Day',
                                          color: AppColors.dark500,
                                          fontWeight: FontWeight.w400,
                                          fontSize: 18,
                                        ),
                                      ],
                                    ),
                                    CustomText(
                                      textAlign: TextAlign.start,
                                      text: 'Assistant',
                                      color: AppColors.dark200,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 14,
                                    ),
                                    const SizedBox(height: 10),
                                    SingleChildScrollView(
                                      scrollDirection: Axis.horizontal,
                                      child: Row(
                                        children: List.generate(4, (index) {
                                          return Container(
                                            margin: EdgeInsets.only(right: 10),
                                            padding: const EdgeInsets.all(8),
                                            decoration: BoxDecoration(
                                              color: AppColors.blue100,
                                              borderRadius:
                                                  BorderRadius.circular(6),
                                            ),
                                            child: const Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                CustomText(
                                                  textAlign: TextAlign.start,
                                                  text: 'Work',
                                                  color: AppColors.dark500,
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 14,
                                                ),
                                                SizedBox(height: 5),
                                                CustomText(
                                                  textAlign: TextAlign.start,
                                                  text: 'Arrange Appointment',
                                                  color: AppColors.dark300,
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 14,
                                                ),
                                                Row(
                                                  children: [
                                                    CustomImage(
                                                      imageSrc:AppIcons.watch,
                                                      imageType: ImageType.svg,
                                                      imageColor: AppColors.dark400,
                                                    ),
                                                    CustomText(
                                                      left: 5,
                                                      textAlign:
                                                          TextAlign.start,
                                                      text: '10:00am - 11:00am',
                                                      color: AppColors.dark400,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      fontSize: 14,
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          );
                                        }),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      }),
                    )
                  ],
                )
              : const SizedBox(), // Empty placeholder
        ],
      ),
    );
  }
}

