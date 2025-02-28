import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tidybayte/app/core/dependency/path.dart';
import 'package:tidybayte/app/data/model/owner_model/profile_model.dart';
import 'package:tidybayte/app/data/service/api_check.dart';
import 'package:tidybayte/app/data/service/api_client.dart';
import 'package:tidybayte/app/data/service/api_url.dart';
import 'package:tidybayte/app/global/helper/local_db/local_db.dart';
import 'package:tidybayte/app/utils/ToastMsg/toast_message.dart';
import 'package:tidybayte/app/utils/app_const/app_const.dart';

class ProfileController extends GetxController {
  ApiClient apiClient = serviceLocator();
  DBHelper dbHelper = serviceLocator();
final firstNameController = TextEditingController();
final lastNameController = TextEditingController();
final phoneNumberController = TextEditingController();
final addressController = TextEditingController();

  void setRxRequestStatus(Status value) => rxRequestStatus.value = value;
  final rxRequestStatus = Status.loading.obs;

  ///==================================✅✅get Profile✅✅=======================

  Rx<ProfileData> profileModel = ProfileData().obs;

  getProfile() async {
    setRxRequestStatus(Status.loading);
    refresh();
    try {
      final response = await apiClient.get(url:
      ApiUrl.getOwnerProfile,showResult: true);

      if (response.statusCode == 200) {
        profileModel.value = ProfileData.fromJson(response.body["data"]);

       print('otp==================${response.statusCode}');
       print('Message==================${profileModel.value.firstName}');
       print('FirstName==================${profileModel.value.lastName}');
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

  ///==================================✅✅Profile Update✅✅=======================
  RxString image = "".obs;

  Future<void> selectImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      image.value = pickedFile.path;
      print("✅ Selected Image Path: ${pickedFile.path}");
    } else {
      print("❌ No Image Selected");
    }
  }

  RxBool updateProfileLoading = false.obs;
  updateProfile() async {
    updateProfileLoading.value = true;

    var body = {
      "firstName": firstNameController.text,
      "lastName": lastNameController.text,
      "phoneNumber": phoneNumberController.text,
      "address": addressController.text,
    };

    String imagePath = image.value;

    // Check if image path is local or from server
    bool isLocalImage = imagePath.startsWith('/data') || imagePath.startsWith('/storage');

    if (isLocalImage) {
      File file = File(imagePath);

      if (!file.existsSync()) {
        print("🚨 File Not Found:=========== $imagePath");
        updateProfileLoading.value = false;
        return;
      }
    } else {
      print("📡 Using server image, no need to check locally: $imagePath");
    }

    var response = isLocalImage
        ? await apiClient.multipartRequest(
      multipartBody: [MultipartBody("profile_image", File(imagePath))],
      url: ApiUrl.updateProfile,
      reqType: "PATCH",
    )
        : await apiClient.patch(
      body: body,
      url: ApiUrl.updateProfile,
    );

    if (response.statusCode == 200) {
      getProfile();
      Get.back();
      toastMessage(message: 'Profile updated successfully');
    } else {
      ApiChecker.checkApi(response);
    }

    updateProfileLoading.value = false;
  }





  @override
  void onInit() {
    getProfile();
    super.onInit();
  }
}
