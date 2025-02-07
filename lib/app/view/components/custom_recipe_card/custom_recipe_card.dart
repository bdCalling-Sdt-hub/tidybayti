import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tidybayte/app/utils/app_icons/app_icons.dart';
import 'package:tidybayte/app/view/components/custom_image/custom_image.dart';
import 'package:tidybayte/app/view/components/custom_netwrok_image/custom_network_image.dart';
import 'package:tidybayte/app/utils/app_colors/app_colors.dart';
import 'package:tidybayte/app/view/components/custom_text/custom_text.dart';


class CustomRecipeCard extends StatelessWidget {
  final String title;
  final String cuisine;
  final String cookTime;
  final String imageUrl;
  final bool isFavorite;

  const CustomRecipeCard({
    super.key,
    required this.title,
    required this.cuisine,
    required this.cookTime,
    required this.imageUrl, required this.isFavorite,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
            child:
                CustomNetworkImage(imageUrl: imageUrl, height: 65, width: 67),
          ),
          const SizedBox(width: 10), // Add space between image and text
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: CustomText(
                        text: title,
                        color: AppColors.dark400,
                        fontWeight: FontWeight.w400,
                        fontSize: 18,
                        // overflow: TextOverflow.ellipsis, // Prevent text overflow
                      ),
                    ),
                    IconButton(
                      icon: isFavorite? Icon(Icons.favorite_border):Icon(Icons.favorite),
                      onPressed: () {
                        // Handle favorite button pressed
                      },
                    ),
                    const CustomImage(
                      imageSrc:AppIcons.delete,
                      imageType: ImageType.svg,
                      imageColor: AppColors.dark400,
                    ),
                    SizedBox(width: 10.w,)
                  ],
                ),
                CustomText(
                  textAlign: TextAlign.start,
                  text: '$cuisine \nCooking time: $cookTime',
                  color: AppColors.dark300,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
