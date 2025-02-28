import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:tidybayte/app/core/dependency/path.dart';
import 'package:tidybayte/app/data/model/owner_model/get_room_model.dart';
import 'package:tidybayte/app/data/model/owner_model/my_house_model.dart';
import 'package:tidybayte/app/data/model/owner_model/single_room_model.dart';
import 'package:tidybayte/app/data/service/api_check.dart';
import 'package:tidybayte/app/data/service/api_client.dart';
import 'package:tidybayte/app/data/service/api_url.dart';
import 'package:tidybayte/app/utils/ToastMsg/toast_message.dart';
import 'package:tidybayte/app/utils/app_const/app_const.dart';
import 'package:tidybayte/app/utils/app_images/app_images.dart';

class HomeController extends GetxController {
  ApiClient apiClient = serviceLocator();
  final houseNameController = TextEditingController();
  final roomNameController = TextEditingController();



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

  RxList<Map<String, dynamic>> rooms = <Map<String, dynamic>>[].obs;

  Future<File> convertIconToFile(String assetPath) async {
    ByteData byteData = await rootBundle.load(assetPath);
    Uint8List uint8List = byteData.buffer.asUint8List();

    Directory tempDir = await getTemporaryDirectory();
    String tempPath = "${tempDir.path}/icon.png";

    File file = File(tempPath);
    await file.writeAsBytes(uint8List);

    return file;
  }

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
          await apiClient.get(url: ApiUrl.myAllHouse, showResult: true,);
      print('Before 200==================${response.statusCode}');

      if (response.statusCode == 200) {
        myHouseData.value = MyHouseData.fromJson(response.body["data"]);

        print('After 200==================${response.statusCode}');
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
  ///==================================✅✅SingleRoom Data✅✅=======================

  Rx<SingleRoomModels> singleRoomModels = SingleRoomModels().obs;

  getSingleRoomTask({required String roomId}) async {
    setRxRequestStatus(Status.loading);
    refresh();
    try {
      final response =
      await apiClient.get(url: ApiUrl.roomTaskSingle(roomId), showResult: true);

      if (response.statusCode == 200) {
        singleRoomModels.value = SingleRoomModels.fromJson(response.body["data"]);

        print('statusCode==================${response.statusCode}');
        print(
            'singleRoomModels Length==================${singleRoomModels.value.result?.length}');
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

  ///==================================✅✅Remove task✅✅=======================
  RxBool isRemoveTask = false.obs;

  removeTask({ required String taskId,required String roomId}) async {
    isRemoveTask.value = true;
    var body = {
      "taskId": taskId
    };

    var response = await apiClient.delete(body: body, url: ApiUrl.taskDelete);
    if (response.statusCode == 200) {
         getSingleRoomTask(roomId: roomId);
      toastMessage(message: response.body["message"]);
    } else if (response.statusCode == 400) {
      toastMessage(message: response.body["message"]);
    } else {
      ApiChecker.checkApi(response);
    }
    isRemoveTask.value = false;
    isRemoveTask.refresh();
  }

  @override
  void onInit() {
    myAllHouse();
    super.onInit();
  }
}
