import 'package:flutter/material.dart';
import 'package:tidybayte/view/components/nav_bar/nav_bar.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: NavBar(currentIndex: 2),

      appBar: AppBar(title: Text("CategoryScreen"),),
    );
  }
}
