

import 'package:get/get.dart';
import 'package:tidybayte/view/screens/home_owner_screen/authentication/sign_in_screen/sign_in_screen.dart';

class AppRoutes {
  static const String signInScreen = "/SignInScreen";

  static List<GetPage> routes = [
    GetPage(name: signInScreen, page: () => const SignInScreen()),
  ];
}
