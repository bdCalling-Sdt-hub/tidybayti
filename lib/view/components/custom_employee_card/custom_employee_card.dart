import 'package:flutter/material.dart';
import 'package:tidybayte/utils/app_colors/app_colors.dart';
import 'package:tidybayte/utils/app_icons/app_icons.dart';
import 'package:tidybayte/utils/app_strings/app_strings.dart';
import 'package:tidybayte/view/components/custom_image/custom_image.dart';
import 'package:tidybayte/view/components/custom_netwrok_image/custom_network_image.dart';
import 'package:tidybayte/view/components/custom_text/custom_text.dart';

class CustomEmployeeCard extends StatelessWidget {
  final String imageUrl;
  final String name;
  final String designation;
  final VoidCallback onSelect;
  final VoidCallback onInfo;

  const CustomEmployeeCard({
    super.key,
    required this.imageUrl,
    required this.name,
    required this.designation,
    required this.onSelect,
    required this.onInfo,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20), // For spacing between cards
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color:const Color(0xCCE8F3FA),
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 6,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Employee Image
          CustomNetworkImage(
            imageUrl: imageUrl,
            height: 53,
            width: 53,
            boxShape: BoxShape.circle,
          ),
          const SizedBox(width: 16),
          // Employee Details (Name & Designation)
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      name,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    GestureDetector(
                      onTap: onInfo,
                      child: const CustomImage(
                        imageSrc:AppIcons.details,
                        imageType: ImageType.svg,
                        imageColor: AppColors.dark400,
                      ),
                    ),

                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  'Designation: $designation',
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.black54,
                  ),
                ),
                const SizedBox(height: 16),
                // Select Employee Button

                GestureDetector(
                  onTap: onSelect,
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    color: AppColors.blue900,
                    child: const CustomText(
                      text: AppStrings.selectEmployee,
                      fontWeight: FontWeight.w300,
                      fontSize: 16,
                      color: AppColors.blue50,
                    ),
                  ),
                )
              ],
            ),
          ),

        ],
      ),
    );
  }
}
