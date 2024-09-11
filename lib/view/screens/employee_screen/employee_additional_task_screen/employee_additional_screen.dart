import 'package:flutter/material.dart';
import 'package:tidybayte/utils/app_strings/app_strings.dart';
import 'package:tidybayte/view/components/custom_appbar/custom_appbar.dart';
import 'package:tidybayte/view/components/employee_nav_bar/employee_navbar.dart';

class EmployeeAdditionalScreen extends StatelessWidget {
  const EmployeeAdditionalScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      bottomNavigationBar: EmployeeNavbar(currentIndex: 1),
      appBar: CustomAppBar(appBarContent: AppStrings.additionalMessage,),
    );
  }
}
