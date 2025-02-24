import 'package:get/get.dart';
import 'package:tidybayte/app/core/dependency/path.dart';
import 'package:tidybayte/app/data/model/owner_model/manage/terms_model.dart';
import 'package:tidybayte/app/data/service/api_check.dart';
import 'package:tidybayte/app/data/service/api_client.dart';
import 'package:tidybayte/app/data/service/api_url.dart';
import 'package:tidybayte/app/utils/app_const/app_const.dart';

class InfoController extends GetxController{
  ApiClient apiClient = serviceLocator();
  void setRxRequestStatus(Status value) => rxRequestStatus.value = value;
  final rxRequestStatus = Status.loading.obs;

  ///==================================✅✅Get Employee✅✅=======================


  Rx<TermsData> termsData = TermsData().obs;

  getTerms() async {
    setRxRequestStatus(Status.loading);
    refresh();
    try {
      final response =
      await apiClient.get(url: ApiUrl.terms, showResult: true);

      if (response.statusCode == 200) {
        termsData.value = TermsData.fromJson(response.body["data"]);

        print('StatusCode==================${response.statusCode}');
        print('description==================${termsData.value.description}');

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



}