import 'package:flutter/material.dart';
import 'package:tidybayte/utils/app_strings/app_strings.dart';
import 'package:tidybayte/view/components/custom_appbar/custom_appbar.dart';
import 'package:tidybayte/view/components/employee_nav_bar/employee_navbar.dart';

class EmployeeHomeScreen extends StatelessWidget {
  const EmployeeHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
    bottomNavigationBar: EmployeeNavbar(currentIndex: 0),
      appBar: CustomAppBar(appBarContent: 'Employee Home',),

    );
  }
}
