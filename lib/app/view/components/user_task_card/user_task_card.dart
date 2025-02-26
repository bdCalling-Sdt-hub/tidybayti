import 'package:flutter/material.dart';
import 'package:tidybayte/app/utils/app_colors/app_colors.dart';
import 'package:tidybayte/app/utils/app_icons/app_icons.dart';
import 'package:tidybayte/app/view/components/custom_image/custom_image.dart';
import 'package:tidybayte/app/view/components/custom_netwrok_image/custom_network_image.dart';
import 'package:tidybayte/app/view/components/custom_text/custom_text.dart';

class UserTaskCard extends StatelessWidget {
  final String name;
  final String role;
  final String workTitle;
  final String workDetails;
  final String time;
  final String imageUrl;

  const UserTaskCard({
    super.key,
    required this.name,
    required this.role,
    required this.workTitle,
    required this.workDetails,
    required this.time,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.only(top: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Profile Image
          CustomNetworkImage(
            boxShape: BoxShape.circle,
            imageUrl: imageUrl,
            height: 40,
            width: 40,
          ),
          const SizedBox(width: 10),

          // User Details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  textAlign: TextAlign.start,
                  text: name,
                  color: AppColors.dark400,
                  fontWeight: FontWeight.w400,
                  fontSize: 18,
                ),
                CustomText(
                  textAlign: TextAlign.start,
                  text: role,
                  color: AppColors.dark200,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
                const SizedBox(height: 10),

                // Task Card
                Container(
                  margin: const EdgeInsets.only(right: 10),
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: AppColors.blue100,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(
                        textAlign: TextAlign.start,
                        text: workTitle,
                        color: AppColors.dark500,
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                      ),
                      const SizedBox(height: 5),
                      CustomText(
                        textAlign: TextAlign.start,
                        text: workDetails,
                        color: AppColors.dark300,
                        fontWeight: FontWeight.w400,
                        fontSize: 14,

                      ),
                      Row(
                        children: [
                          const CustomImage(
                            imageSrc: AppIcons.calendar,
                            imageType: ImageType.svg,
                            imageColor: AppColors.dark400,
                          ),
                          CustomText(
                            left: 5,
                            textAlign: TextAlign.start,
                            text: time,
                            color: AppColors.dark400,
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
