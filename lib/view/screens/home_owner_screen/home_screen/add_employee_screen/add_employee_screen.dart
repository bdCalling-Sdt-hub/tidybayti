import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:tidybayte/utils/app_strings/app_strings.dart';
import 'package:tidybayte/view/components/custom_menu_appbar/custom_menu_appbar.dart';
import 'package:tidybayte/view/components/nav_bar/nav_bar.dart';

class AddEmployeeScreen extends StatelessWidget {
  const AddEmployeeScreen({super.key});

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
              CustomMenuAppbar(
                title: AppStrings.addEmployee,
                onBack: () {
                  Get.back();
                },
              ),

              ///=============================== Employee List ========================
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.all(16.0),
                  children: [


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
