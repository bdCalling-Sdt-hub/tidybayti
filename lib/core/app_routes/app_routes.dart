

import 'package:get/get.dart';
import 'package:tidybayte/view/screens/authentication/sign_in_screen/sign_in_screen.dart';

class AppRoutes {
  static const String signInScreen = "/SignInScreen";

  static List<GetPage> routes = [
    GetPage(name: signInScreen, page: () => const SignInScreen()),
  ];
}
