
import 'package:flutter/material.dart';
import 'package:tidybayte/app/utils/app_colors/app_colors.dart';
import 'package:tidybayte/app/utils/app_icons/app_icons.dart';
import 'package:tidybayte/app/utils/app_images/app_images.dart';
import 'package:tidybayte/app/view/components/custom_button/custom_button.dart';
import 'package:tidybayte/app/view/components/custom_image/custom_image.dart';
import 'package:tidybayte/app/view/components/custom_text/custom_text.dart';


class NoInternetScreen extends StatelessWidget {
  const NoInternetScreen({super.key, required this.onTap});
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.blue500,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: SingleChildScrollView(

          child: Column(
            children: [
              const SizedBox(height: 121,),

              const CustomImage(imageSrc: AppImages.noInternet),


              const CustomText(
                top: 12,
                text: 'Whoops!!',
                fontSize: 20,
                fontWeight: FontWeight.w500,
                color: Colors.black,
                bottom:12 ,
              ), const CustomText(
                text: 'No internet connection was found. Check your connection or try again.',
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: Colors.black,
                maxLines: 2,
              ),
              const SizedBox(height: 24,),
              ///=====================TryAgain Button===================
              CustomButton(
                onTap:onTap,
                title: 'Try Again',
              )
            ],
          ),
        ),
      ),
    );
  }
}
