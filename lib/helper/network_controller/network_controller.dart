import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NetworkController extends GetxController {
  final Connectivity _connectivity = Connectivity();

  @override
  void onInit() {
    super.onInit();
    _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
  }

  void _updateConnectionStatus(ConnectivityResult connectivityResult) {
    if (connectivityResult == ConnectivityResult.none) {
      Get.snackbar(
        'No Internet Connection',
        'PLEASE CONNECT TO THE INTERNET',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red[400]!,
        colorText: Colors.white,
        icon: const Icon(Icons.wifi_off, color: Colors.white, size: 35),
        margin: EdgeInsets.zero,
        isDismissible: false,
        duration: const Duration(days: 1),
      );
    } else {
      if (Get.isSnackbarOpen) {
        Get.closeCurrentSnackbar();
      }
      Get.snackbar(
        'Internet Connected',
        'You are connected to the internet',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.green[400]!,
        colorText: Colors.white,
        icon: const Icon(Icons.wifi, color: Colors.white, size: 35),
        margin: EdgeInsets.zero,
        isDismissible: true,
        duration: const Duration(seconds: 3),
      );
    }
  }
}