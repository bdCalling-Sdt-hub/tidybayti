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

  Rx<File> imageFile = File("").obs;

  selectImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? getImages =
    await picker.pickImage(source: ImageSource.gallery, imageQuality: 15);
    if (getImages != null) {
      imageFile.value = File(getImages.path);
      image.value = getImages.path;
    }
  }

  RxBool updateProfileLoading = false.obs;

  updateProfile() async {

    updateProfileLoading.value = true;

    var body = {
      "firstName": firstNameController.value.text,
      "lastName": lastNameController.value.text,
      "phoneNumber": phoneNumberController.value.text,
      "address": addressController.value.text,
    };

    var response = image.isEmpty
        ? await apiClient.patch(
        body: body,
        url:  ApiUrl.updateProfile)
        : await apiClient.multipartRequest(
        multipartBody: [
          MultipartBody("profile_image", File(image.value))
        ],
      url: ApiUrl.updateProfile,
        reqType: "PATCH");

    if (response.statusCode == 200) {
      getProfile();
      Get.back();
    toastMessage(message: 'message');
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
