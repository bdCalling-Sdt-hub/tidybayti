import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:tidybayte/app/utils/app_strings/app_strings.dart';

import 'package:tidybayte/app/view/components/custom_menu_appbar/custom_menu_appbar.dart';
import 'package:tidybayte/app/view/components/custom_room_card/custom_room_card.dart';

class PendingTask extends StatefulWidget {
  const PendingTask({super.key});

  @override
  State<PendingTask> createState() => _AllTaskScreenState();
}

class _AllTaskScreenState extends State<PendingTask> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
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
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ///=============================== Menu Title ========================
              CustomMenuAppbar(
                title: AppStrings.pendingTask.tr,
                onBack: () {
                  Get.back();
                },
              ),

              ///=============================== Settings Items ========================
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  children: [
                    Column(
                      children: List.generate(4, (index) {
                        return CustomRoomCard(
                            taskName: 'Clean Car',
                            assignedTo: 'Annette Black',
                            time: '10 Aug,2024',
                            onInfoPressed: () {},
                            onDeletePressed: () {});
                      }),
                    )
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
