import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:tidybayte/app/core/dependency/path.dart';
import 'package:tidybayte/app/data/model/owner_model/get_room_model.dart';
import 'package:tidybayte/app/data/model/owner_model/my_house_model.dart';
import 'package:tidybayte/app/data/service/api_check.dart';
import 'package:tidybayte/app/data/service/api_client.dart';
import 'package:tidybayte/app/data/service/api_url.dart';
import 'package:tidybayte/app/utils/app_const/app_const.dart';
import 'package:tidybayte/app/utils/app_icons/app_icons.dart';
import 'package:tidybayte/app/utils/app_images/app_images.dart';

class HomeController extends GetxController {
  ApiClient apiClient = serviceLocator();
  final houseNameController = TextEditingController();
  final roomNameController = TextEditingController();

  /// ✅ List of Available Icons
  List<String> icons = [
    AppIcons.villa,
    AppIcons.appartMent,
    AppIcons.addRoom,
  ];

  String selectedIconPath =
      AppImages.apartMent;

  List<String> images = [
    AppImages.apartMent,
    AppImages.villa,
    AppImages.bungalow,
    AppImages.mansion,
  ];

  final RxBool isExpanded = false.obs;
  final RxString selectedHouseId = ''.obs;
  final RxString selectedHouseName = 'Add House'.obs;

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

  var isRoomLoading = false.obs;

  void setRoomLoading(bool value) {
    isRoomLoading.value = value;
  }

  Rx<File?> profileImage = Rx<File?>(null);

  Future<void> pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      profileImage.value = File(pickedFile.path);
      print("✅ Selected Image: ${profileImage.value!.path}");
    } else {
      print("❌ No Image Selected");
    }
  }

  ///==================================✅✅get House Room✅✅=======================
  void setRxRequestStatus(Status value) => rxRequestStatus.value = value;
  final rxRequestStatus = Status.loading.obs;
  Rx<HouseRoomData> houseRoomData = HouseRoomData().obs;

  getHouseRoom({required String houseId}) async {
    setRxRequestStatus(Status.loading);
    refresh();
    try {
      final response =
          await apiClient.get(url: ApiUrl.getMyRoom(houseId), showResult: true);

      if (response.statusCode == 200) {
        houseRoomData.value = HouseRoomData.fromJson(response.body["data"]);

        print('otp==================${response.statusCode}');
        print(
            'rooms Length==================${houseRoomData.value.rooms?.length}');
        setRxRequestStatus(Status.completed);
        refresh();
      } else {
        setRxRequestStatus(Status.error);
        ApiChecker.checkApi(response);
      }
    } catch (e) {
      setRxRequestStatus(Status.error);
    }
  }

  ///==================================✅✅MY house Data✅✅=======================

  Rx<MyHouseData> myHouseData = MyHouseData().obs;

  myAllHouse() async {
    setRxRequestStatus(Status.loading);
    refresh();
    try {
      final response =
          await apiClient.get(url: ApiUrl.myAllHouse, showResult: true);

      if (response.statusCode == 200) {
        myHouseData.value = MyHouseData.fromJson(response.body["data"]);

        print('statusCode==================${response.statusCode}');
        print(
            'House Length==================${myHouseData.value.houses?.length}');
        setRxRequestStatus(Status.completed);
        refresh();
      } else {
        setRxRequestStatus(Status.error);
        ApiChecker.checkApi(response);
      }
    } catch (e) {
      setRxRequestStatus(Status.error);
    }
  }

  @override
  void onInit() {
    myAllHouse();
    super.onInit();
  }
}
