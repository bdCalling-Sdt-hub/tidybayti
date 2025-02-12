import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tidybayte/app/core/dependency/path.dart';
import 'package:tidybayte/app/data/service/api_check.dart';
import 'package:tidybayte/app/data/service/api_client.dart';
import 'package:tidybayte/app/data/service/api_url.dart';
import 'package:tidybayte/app/global/helper/local_db/local_db.dart';
import 'package:tidybayte/app/utils/ToastMsg/toast_message.dart';

class AddEmployeeController extends GetxController {
  ApiClient apiClient = serviceLocator();
  DBHelper dbHelper = serviceLocator();
  RxString image = "".obs;
  final RxBool isCprOpen = false.obs;
  final RxBool isPassportOpen = false.obs;
  final RxString selectedJobType = ''.obs;
  ///==================================✅✅updateJobType✅✅=======================
  void updateJobType(String jobType) {
    selectedJobType.value = jobType;
    jobTypeController.text = jobType;
    debugPrint("Selected Job Type: =======================$jobType");
  }
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

  ///==================================✅✅Profile Update✅✅=======================
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final jobTypeController = TextEditingController();
  final cprNumberController = TextEditingController();
  final cprExpireDateController = TextEditingController();
  final passportController = TextEditingController();
  final noteController = TextEditingController();
  final passportExpireDateController = TextEditingController();

  RxBool isAddEmployeeLoading = false.obs;

  addEmployee() async {
    isAddEmployeeLoading.value = true;

    var body = {
      "firstName": firstNameController.text,
      "lastName": lastNameController.text,
      "jobType": jobTypeController.text,
      "CPR":cprNumberController.text,
      "CPRExpireDate":cprExpireDateController.text,
      "passport":passportController.text,
      "passportExpire":passportExpireDateController.text,
      "note":noteController.text,
      "phoneNumber": phoneNumberController.text,
      "email": emailController.text,
      "password": passwordController.text,
    };

    var response = image.isEmpty
        ? await apiClient.post(body: body, url: ApiUrl.addEmployee)
        : await apiClient.multipartRequest(
            multipartBody: [MultipartBody("profile_image", File(image.value))],
            url: ApiUrl.addEmployee,
            reqType: "Post");

    if (response.statusCode == 200) {
      toastMessage(message: 'message');
    } else {
      ApiChecker.checkApi(response);
    }

    isAddEmployeeLoading.value = false;
  }


}
