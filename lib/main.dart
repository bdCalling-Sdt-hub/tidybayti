

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tidybayte/app/core/dependency/dependency_injection.dart';
import 'package:tidybayte/app/view/components/device_utils/device_utils.dart';

import 'app/core/app_routes/app_routes.dart';
import 'app/core/dependency/path.dart';
import 'app/global/language/language_transalator.dart';


void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  DeviceUtils.lockDevicePortrait();

  await initDependencies();
  runApp(
    const MyApp(), // Wrap your app
  );
  // const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      minTextAdapt: true,
      splitScreenMode: true,
      designSize: const Size(375, 812),
      child: GetMaterialApp(
        initialBinding: DependencyInjection(),
        debugShowCheckedModeBanner: false,
        defaultTransition: Transition.fadeIn,
        transitionDuration: const Duration(milliseconds: 200),
        initialRoute: AppRoutes.splashScreen ,
        navigatorKey: Get.key,
        getPages: AppRoutes.routes,   locale: const Locale("en","US"),
        translations: Language(),
      ),
    );
  }
}


