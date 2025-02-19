import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:tidybayte/app/utils/app_icons/app_icons.dart';

class HomeController extends GetxController {
  /// ✅ Controllers for House & Room Names
  final houseNameController = TextEditingController();
  final roomNameController = TextEditingController();

  /// ✅ List of Available Icons
  List<String> icons = [
    AppIcons.villa,
    AppIcons.appartMent,
    AppIcons.addRoom,
  ];

  /// ✅ List of Added Rooms (Stored in `RxList` for global state)
  RxList<Map<String, dynamic>> rooms = <Map<String, dynamic>>[].obs;

  /// ✅ Convert an Icon (Asset Image) to a File
  Future<File> convertIconToFile(String assetPath) async {
    ByteData byteData = await rootBundle.load(assetPath);
    Uint8List uint8List = byteData.buffer.asUint8List();

    Directory tempDir = await getTemporaryDirectory();
    String tempPath = "${tempDir.path}/icon.png";

    File file = File(tempPath);
    await file.writeAsBytes(uint8List);

    return file;
  }

  /// ✅ Add a New Room (Ensures only one room can be created)
  void addRoom(String roomName, String iconName) async {
    if (rooms.isEmpty) {
      File iconFile = await convertIconToFile(iconName); // Convert icon to file
      rooms.add({'name': roomName, 'icon': iconFile.path});
    }
  }


  var isLoading = false.obs;

  void setLoading(bool value) {
    isLoading.value = value;
  }

}
