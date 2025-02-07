import 'package:flutter/material.dart';
import 'package:tidybayte/app/utils/app_colors/app_colors.dart';
import 'package:tidybayte/app/view/components/custom_text/custom_text.dart';

class RecipeButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const RecipeButton({
    super.key,
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(14),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      height: 64,
      width: MediaQuery.of(context).size.width,
      color: AppColors.blue50,
      child: GestureDetector(
        onTap: onPressed,
        child: CustomText(
          textAlign: TextAlign.center,
          text: text,
          fontWeight: FontWeight.w300,
          fontSize: 24,
          color: AppColors.dark500,
        ),
      ),
    );
  }
}
