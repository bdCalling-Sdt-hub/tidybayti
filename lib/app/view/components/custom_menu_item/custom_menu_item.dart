import 'package:flutter/material.dart';
import 'package:tidybayte/app/utils/app_colors/app_colors.dart';
import 'package:tidybayte/app/view/components/custom_image/custom_image.dart';
import 'package:tidybayte/app/view/components/custom_text/custom_text.dart';

import '../custom_text/custom_text.dart';

class CustomMenuItem extends StatelessWidget {
  final String image;
  final String text;
  final VoidCallback onTap;

  const CustomMenuItem({
    super.key,
    required this.image,
    required this.text,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 64,
        margin: const EdgeInsets.all(10),
        padding: const EdgeInsets.symmetric(horizontal: 16,),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            // Leading Icon
            CustomImage(imageSrc: image, imageType: ImageType.svg,imageColor: Colors.black,),

            // Spacer between icon and text
            const SizedBox(width: 16),

            // Text
            Expanded(
              child: CustomText(
                textAlign: TextAlign.start,
                text: text,
                fontWeight: FontWeight.w300,
                fontSize: 24,
                color: AppColors.dark300,
              ),
            ),


          ],
        ),
      ),
    );
  }
}