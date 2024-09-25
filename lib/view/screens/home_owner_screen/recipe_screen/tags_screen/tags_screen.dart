import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tidybayte/utils/app_const/app_const.dart';
import 'package:tidybayte/utils/app_strings/app_strings.dart';
import 'package:tidybayte/view/components/custom_menu_appbar/custom_menu_appbar.dart';
import 'package:tidybayte/view/components/nav_bar/nav_bar.dart';

class TagsScreen extends StatelessWidget {
  TagsScreen({super.key});

  final List<Map<String, String>> categories = [
    {
      'title': 'Appetizers',
      'imageUrl': AppConstants.fruits, // Replace with actual image URL
    },
    {
      'title': 'Asian',
      'imageUrl': AppConstants.fruits, // Replace with actual image URL
    },
    {
      'title': 'Breakfast',
      'imageUrl': AppConstants.fruits, // Replace with actual image URL
    },
    {
      'title': 'Dessert',
      'imageUrl': AppConstants.fruits, // Replace with actual image URL
    },{
      'title': 'Dessert',
      'imageUrl': AppConstants.fruits, // Replace with actual image URL
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const NavBar(currentIndex: 4),
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
        child: SafeArea(
          child: Column(
            children: [
              ///=============================== Menu Title ========================
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CustomMenuAppbar(
                    title: AppStrings.tags,
                    onBack: () {
                      Get.back();
                    },
                  ),
                ],
              ),

              ///=============================== Menu Items ========================
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.all(16.0),
                  children: [
                    /// Fix: Wrap GridView.builder in a SizedBox with a fixed height
                    SizedBox(
                      // height: MediaQuery.of(context).size.height * 0.5, // Fix the height
                      child: GridView.builder(
                        shrinkWrap: true, // Allows GridView to shrink within the available space
                        physics: const NeverScrollableScrollPhysics(), // Disable GridView scrolling
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2, // Number of columns
                          crossAxisSpacing: 10.0, // Spacing between columns
                          mainAxisSpacing: 10.0, // Spacing between rows
                          childAspectRatio: 1.0, // Aspect ratio of each grid item (1.0 for square)
                        ),
                        itemCount: categories.length,
                        itemBuilder: (context, index) {
                          return CategoryCard(
                            title: categories[index]['title']!,
                            imageUrl: categories[index]['imageUrl']!,
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CategoryCard extends StatelessWidget {
  final String title;
  final String imageUrl;

  const CategoryCard({
    super.key,
    required this.title,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        image: DecorationImage(
          image: NetworkImage(imageUrl),
          fit: BoxFit.cover,
        ),
      ),
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.4), // Dark overlay
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          Center(
            child: Text(
              title,
              style: TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
