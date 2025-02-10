import 'package:get/get.dart';
import 'package:tidybayte/app/core/dependency/path.dart';
import 'package:tidybayte/app/data/model/owner_model/profile_model.dart';
import 'package:tidybayte/app/data/service/api_check.dart';
import 'package:tidybayte/app/data/service/api_client.dart';
import 'package:tidybayte/app/data/service/api_url.dart';
import 'package:tidybayte/app/global/helper/local_db/local_db.dart';
import 'package:tidybayte/app/utils/app_const/app_const.dart';

class ProfileController extends GetxController {
  ApiClient apiClient = serviceLocator();
  DBHelper dbHelper = serviceLocator();
  final rxRequestStatus = Status.loading.obs;

  void setRxRequestStatus(Status value) => rxRequestStatus.value = value;

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

  @override
  void onInit() {
    getProfile();
    super.onInit();
  }
}
