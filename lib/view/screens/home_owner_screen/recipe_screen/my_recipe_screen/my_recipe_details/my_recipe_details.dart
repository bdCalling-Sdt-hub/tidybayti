import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tidybayte/core/app_routes/app_routes.dart';
import 'package:tidybayte/utils/app_colors/app_colors.dart';
import 'package:tidybayte/utils/app_const/app_const.dart';
import 'package:tidybayte/view/components/custom_menu_appbar/custom_menu_appbar.dart';
import 'package:tidybayte/view/components/custom_netwrok_image/custom_network_image.dart';
import 'package:tidybayte/view/components/custom_text/custom_text.dart';

class MyRecipeDetails extends StatelessWidget {
  const MyRecipeDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xCCE8F3FA), // First color (with opacity)
              Color(0xFFB5D8EE),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomMenuAppbar(
                title: 'Recipe Details',
                onBack: () {
                  Get.back();
                },
                isEdit: true,
                onTap: () {
                  Get.toNamed(AppRoutes.addNewRecipe);
                },
              ),
              SizedBox(
                height: 15,
              ),
              CustomNetworkImage(
                  imageUrl: AppConstants.fruits, height: 191, width: 375),
              SizedBox(
                height: 25,
              ),
              const CustomText(
                text: 'Idlis Steamed Rice Cake',
                fontWeight: FontWeight.w500,
                fontSize: 20,
                color: AppColors.dark400,
              ),
              SizedBox(height: 8),
              RecipeInfoRow(label: 'Cooking time:', value: '30 min'),
              SizedBox(height: 8),
              RecipeInfoRow(label: 'Tag:', value: 'Asian / Indian'),
              SizedBox(height: 8),
              RecipeInfoRow(label: 'Email:', value: 'sadhu@gmail.com'),
              SizedBox(height: 16),
              RecipeSectionTitle(title: 'Description:'),
              SizedBox(height: 8),
              RecipeDescription(
                description:
                    'Mix chicken pieces with yogurt, ginger-garlic paste, biryani spice mix, chopped green chilies, a squeeze of lemon juice, and salt.',
              ),
              SizedBox(height: 16),
              RecipeSectionTitle(title: 'Ingredients:'),
              SizedBox(height: 8),
              RecipeIngredients(
                ingredients:
                    '· 3 cups rice\n· 1 cup skinless black gram urad daal\n· 1/4 teaspoon salt\n· 2 tablespoons vegetable oil, or canola oil',
              ),
              SizedBox(height: 16),
              RecipeSectionTitle(title: 'Describe steps:'),
              SizedBox(height: 8),
              RecipeSteps(
                steps:
                    '1. Wash the rice and urad daal separately and soak them overnight.\n'
                    '2. Grind each separately, into thick pastes (adding a little water at a time) in a blender.\n'
                    '3. Mix the pastes together and add salt to taste.\n'
                    '4. Set the batter aside overnight to ferment.\n'
                    '5. Grease the molds on an idli tray with cooking oil. Pour enough batter into each mold to fill it three-fourths full.\n'
                    '6. Pour 2 cups of water into a large pot and heat. Put the idli tray into the pot and steam for 20 minutes.\n'
                    '7. Check the idlis by poking each with a toothpick. If the toothpick comes out clean, the idlis are done.',
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class RecipeInfoRow extends StatelessWidget {
  final String label;
  final String value;

  const RecipeInfoRow({Key? key, required this.label, required this.value})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CustomText(
          text: '$label ',
          fontSize: 16,
          fontWeight: FontWeight.w400,
          color: AppColors.dark300,
          right: 30,
        ),
        CustomText(
          text: '$value ',
          fontSize: 16,
          fontWeight: FontWeight.w400,
          color: AppColors.dark300,
          right: 30,
        ),
      ],
    );
  }
}

class RecipeSectionTitle extends StatelessWidget {
  final String title;

  const RecipeSectionTitle({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return CustomText(
      text: '$title ',
      fontSize: 16,
      fontWeight: FontWeight.w400,
      color: AppColors.dark300,
      right: 30,
    );
  }
}

class RecipeDescription extends StatelessWidget {
  final String description;

  const RecipeDescription({super.key, required this.description});

  @override
  Widget build(BuildContext context) {
    return CustomText(
      text: '$description ',
      fontSize: 16,
      maxLines: 8,
      textAlign: TextAlign.start,
      fontWeight: FontWeight.w400,
      color: AppColors.dark300,
      right: 30,
    );
  }
}

class RecipeIngredients extends StatelessWidget {
  final String ingredients;

  const RecipeIngredients({super.key, required this.ingredients});

  @override
  Widget build(BuildContext context) {
    return CustomText(
      text: '$ingredients ',
      fontSize: 16,
      textAlign: TextAlign.start,
      fontWeight: FontWeight.w400,
      color: AppColors.dark300,
    );
  }
}

class RecipeSteps extends StatelessWidget {
  final String steps;

  const RecipeSteps({super.key, required this.steps});

  @override
  Widget build(BuildContext context) {
    return CustomText(
      textAlign: TextAlign.start,
      text: '$steps ',
      fontSize: 16,
      maxLines: 10,
      fontWeight: FontWeight.w400,
      color: AppColors.dark300,
      right: 30,
    );
  }
}
