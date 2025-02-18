import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tidybayte/app/controller/owner_controller/add_employee_controller/add_employee_controller.dart';
import 'package:tidybayte/app/data/service/api_url.dart';
import 'package:tidybayte/app/utils/app_colors/app_colors.dart';
import 'package:tidybayte/app/utils/app_const/app_const.dart';
import 'package:tidybayte/app/view/components/custom_loader/custom_loader.dart';
import 'package:tidybayte/app/view/components/custom_netwrok_image/custom_network_image.dart';
import 'package:tidybayte/app/view/components/custom_text/custom_text.dart';

class EmployeeShow extends StatelessWidget {
  const EmployeeShow({
    super.key,
    required this.employeeController,
  });

  final AddEmployeeController employeeController;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      switch (employeeController.rxRequestStatus.value) {
        case Status.loading:
          return const CustomLoader(); // Show loading indicator

        case Status.internetError:
          return GestureDetector(
            onTap: () {
              employeeController.getEmployee();
            },
            child: const CustomText(
              textAlign: TextAlign.center,
              top: 25,
              fontWeight: FontWeight.w500,
              fontSize: 16,
              text: 'No Internet',
              color: Colors.black,

            ),
          );

        case Status.error:
          return GestureDetector(
            onTap: () {
              employeeController.getEmployee();
            },
            child: const CustomText(
              top: 20,
              fontWeight: FontWeight.w500,
              fontSize: 16,
              text: 'Try Again',
              color: Colors.black,

            ),
          );

        case Status.completed:
          var employeeList =
              employeeController.employeeData.value.result ??
                  [];

          if (employeeList.isEmpty) {
            return  Padding(
              padding: EdgeInsets.symmetric(vertical: 50.h),
              child: const CustomText(
                text: "No Employee Found",
                fontWeight: FontWeight.w500,
                color: Colors.black,
                fontSize: 16,
              ),
            );
          }
          return SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,

              children: List.generate(
                  employeeController
                      .employeeData.value.result?.length ??
                      0, (index) {
                final data = employeeController
                    .employeeData.value.result?[index];
                return Padding(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 10),
                  child: Container(
                    color: Colors.white,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,                                  children: [
                      CustomNetworkImage(
                          imageUrl:
                          "${ApiUrl.networkUrl}${data?.profileImage ?? ""}",
                          height: 181,
                          width: 152),
                      SizedBox(
                        width: 152,
                        child: CustomText(
                          left: 10,
                          text: "${data?.firstName ?? " "} ${data?.lastName}",
                          color: AppColors.dark400,
                          fontSize: 19,
                          fontWeight: FontWeight.w500,
                        ),
                      )
                    ],
                    ),
                  ),
                );
              }),
            ),
          );
      }
    });
  }
}
