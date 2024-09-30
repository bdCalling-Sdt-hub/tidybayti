import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tidybayte/core/app_routes/app_routes.dart';
import 'package:tidybayte/utils/app_const/app_const.dart';
import 'package:tidybayte/utils/app_strings/app_strings.dart';
import 'package:tidybayte/view/components/custom_menu_appbar/custom_menu_appbar.dart';
import 'package:tidybayte/view/components/custom_netwrok_image/custom_network_image.dart';

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
            children:  [
              CustomMenuAppbar(
                title: 'Recipe Details',
                onBack: () {
                  Get.back();
                },
                isEdit: true,
                onTap: (){
                  Get.toNamed(AppRoutes.addNewRecipe);
                },
              ),
              SizedBox(height: 25,),
              CustomNetworkImage(imageUrl: AppConstants.fruits, height: 191, width: 375),
              SizedBox(height: 25,),

              RecipeTitle(title: 'Idlis Steamed Rice Cake'),
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

class RecipeTitle extends StatelessWidget {
  final String title;
  const RecipeTitle({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
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
        Text(
          '$label ',
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          value,
          style: const TextStyle(
            fontSize: 16,
          ),
        ),
      ],
    );
  }
}

class RecipeSectionTitle extends StatelessWidget {
  final String title;
  const RecipeSectionTitle({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}

class RecipeDescription extends StatelessWidget {
  final String description;
  const RecipeDescription({Key? key, required this.description}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      description,
      style: const TextStyle(
        fontSize: 16,
      ),
    );
  }
}

class RecipeIngredients extends StatelessWidget {
  final String ingredients;
  const RecipeIngredients({Key? key, required this.ingredients}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      ingredients,
      style: const TextStyle(
        fontSize: 16,
      ),
    );
  }
}

class RecipeSteps extends StatelessWidget {
  final String steps;
  const RecipeSteps({Key? key, required this.steps}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      steps,
      style: const TextStyle(
        fontSize: 16,
      ),
    );
  }
}
