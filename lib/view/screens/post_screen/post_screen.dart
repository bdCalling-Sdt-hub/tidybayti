import 'package:flutter/material.dart';
import 'package:tidybayte/view/components/nav_bar/nav_bar.dart';

class PostScreen extends StatelessWidget {
  const PostScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: NavBar(currentIndex: 3),

      appBar: AppBar(title: Text("PostScreen"),),
    );
  }
}
