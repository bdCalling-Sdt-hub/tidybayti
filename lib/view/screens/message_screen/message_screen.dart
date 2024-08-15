import 'package:flutter/material.dart';
import 'package:tidybayte/view/components/nav_bar/nav_bar.dart';

class MessageScreen extends StatelessWidget {
  const MessageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: NavBar(currentIndex: 1),

      appBar: AppBar(title: Text("MessageScreen"),),
    );
  }
}
