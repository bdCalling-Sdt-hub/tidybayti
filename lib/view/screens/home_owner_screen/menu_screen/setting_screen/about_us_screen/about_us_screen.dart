import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tidybayte/utils/app_colors/app_colors.dart';
import 'package:tidybayte/utils/app_strings/app_strings.dart';

import 'package:tidybayte/view/components/custom_menu_appbar/custom_menu_appbar.dart';
import 'package:tidybayte/view/components/custom_text/custom_text.dart';
import 'package:tidybayte/view/components/nav_bar/nav_bar.dart';

class AboutUsScreen extends StatelessWidget {
  const AboutUsScreen({super.key});

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
          child: SingleChildScrollView(
            child: Column(
              // crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ///=============================== aboutUs ========================
                CustomMenuAppbar(
                  title: AppStrings.aboutUs,
                  onBack: () {
                    Get.back();
                  },
                ),

                ///=============================== aboutUs ========================
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: CustomText(
                    textAlign: TextAlign.start,
                    maxLines: 100,
                    color: AppColors.dark300,
                    text:
                    'When you use our App, we collect and store your personal information which is provided by you from time to time. Our primary goal in doing so is to provide you a safe, efficient, smooth and customized experience. This allows us to provide services and features that most likely meet your needs, and to customize our website to make your experience safer and easier. More importantly, while doing so, we collect personal information from you that we consider necessary for achieving this purpose.    Below are some of the ways in which we collect and store your information:   We receive and store any information you enter on our website or give us in any other way. We use the information that you provide for such purposes as responding to your requests, customizing future shopping for you, improving our stores, and communicating with you. We also store certain types of information whenever you interact with us. For example, like many websites, we use "cookies," and we obtain certain types of information when your web browser accesses Chaldal.com or advertisements and other content served by or on behalf of Chaldal.com on other websites. When signing up via Facebook, we collect your Name and Email (provided by Facebook) as part of your Chaldal account Information. To help us make e-mails more useful and interesting, we often receive a confirmation when you open e-mail from Chaldal if your computer supports such capabilities.  Changes To Your Information:  The information you provide us isn’t set in stone. You may review, update, correct or delete the personal information in your profile at any time.   If you would like us to remove your information from our records, please create a request at the Contact Us page.  To Delete your Facebook login, visit the Contact Us page while logged in via Facebook. You should see a "Delete Facebook Login" option to create a request to remove Facebook login from your account.  Information about our customers is an important part of our business, and we are not in the business of selling it to others.   We release account and other personal information when we believe release is appropriate to comply with the law; enforce or apply our Terms of Use and other agreements; or protect the rights, property, or safety of Chaldal.com, our users, or others. This includes exchanging information with other companies and organizations for fraud protection.',
                    fontWeight: FontWeight.w400,
                    fontSize: 16,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
