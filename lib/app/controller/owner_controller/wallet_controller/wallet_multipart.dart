import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart'as http;
import 'package:http_parser/http_parser.dart';
import 'package:tidybayte/app/controller/owner_controller/wallet_controller/wallet_controller.dart';
import 'package:tidybayte/app/data/service/api_url.dart';
import 'package:tidybayte/app/global/helper/shared_prefe/shared_prefe.dart';
import 'package:tidybayte/app/utils/ToastMsg/toast_message.dart';
import 'package:tidybayte/app/utils/app_const/app_const.dart';

class WalletMultipartApi {
  ///==================================✅✅Add Employee✅✅=======================

  static Future<void> walletCreate({
    required BuildContext context, // Add this line
    required String category,
    required String currency,
    required String budgetDateStr,
    required String amount,
    required File budgetImage,

  }) async {
    WalletController walletController = Get.find();
    walletController.setLoading(true);

    var url = Uri.parse(ApiUrl.budgetCreate);

    var request = http.MultipartRequest("POST", url);

    request.fields["category"] = category;
    request.fields["currency"] = currency;
    request.fields["budgetDateStr"] = budgetDateStr;
    request.fields["amount"] = amount;


    request.files.add(await http.MultipartFile.fromPath(
      "budgetImage",
      budgetImage.path,
      contentType: MediaType('image', 'jpeg'),
    ));

    String? savedToken = await SharePrefsHelper.getString(AppConstants.token);
    var token = savedToken;

    request.headers.addAll({
      "Authorization": "Bearer $token",
      "Content-Type": "multipart/form-data",
    });

    try {
      var response = await request.send();
      var responseData = await response.stream.bytesToString();

      walletController.setLoading(false);

      if (response.statusCode == 200) {

        toastMessage(message: "✅Budget created successfully ");
        print("✅ Budget created successfully");
        print(responseData);
      } else {
        print("❌ Failed: ${response.statusCode}");
        print("❌ Error Response: $responseData");

        String errorMessage = "Something went wrong!";
        try {
          var decodedData = json.decode(responseData);
          if (decodedData["message"] != null) {
            errorMessage = decodedData["message"];
          }
        } catch (e) {
          print("❌ JSON Parsing Error: $e");
        }

        toastMessage(message: "❌ $errorMessage");
      }
    } catch (e) {
      walletController.setLoading(false);
      toastMessage(
          message: "❌ An error occurred. Please check your connection.");
      print("❌ Error: $e");
    }
  }
}