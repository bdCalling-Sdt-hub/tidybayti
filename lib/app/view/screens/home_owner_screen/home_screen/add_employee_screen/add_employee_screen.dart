
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tidybayte/app/controller/owner_controller/add_employee_controller/add_employee.dart';
import 'package:tidybayte/app/controller/owner_controller/add_employee_controller/add_employee_controller.dart';
import 'package:tidybayte/app/utils/ToastMsg/toast_message.dart';
import 'package:tidybayte/app/utils/app_colors/app_colors.dart';
import 'package:tidybayte/app/utils/app_images/app_images.dart';
import 'package:tidybayte/app/utils/app_strings/app_strings.dart';
import 'package:tidybayte/app/view/components/custom_button/custom_button.dart';
import 'package:tidybayte/app/view/components/custom_loader/custom_loader.dart';
import 'package:tidybayte/app/view/components/custom_menu_appbar/custom_menu_appbar.dart';
import 'package:tidybayte/app/view/components/custom_text_field/custom_text_field.dart';

class AddEmployeeScreen extends StatefulWidget {
  const AddEmployeeScreen({super.key});

  @override
  State<AddEmployeeScreen> createState() => _AddEmployeeScreenState();
}

class _AddEmployeeScreenState extends State<AddEmployeeScreen> {
  final AddEmployeeController controller = Get.find<AddEmployeeController>();



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xCCE8F3FA), // First color (with opacity)
              Color(0xFFB5D8EE),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              ///==================================✅✅Add Employee Tiitle✅✅=======================
              CustomMenuAppbar(
                title: AppStrings.addEmployee.tr,
                onBack: () {
                  Get.back();
                },
              ),

              ///==================================✅✅Employee Image✅✅=======================
              Expanded(
                child: Obx(
                 () {
                    return ListView(
                      padding: const EdgeInsets.all(16.0),
                      children: [
                        ///==================================✅✅Employee Image✅✅=======================
                        AddEmployeeImage(controller: controller),
                        SizedBox(
                          height: 20.h,
                        ),

                        ///==================================✅✅Employee Personal List✅✅=======================

                        CustomTextField(
                          hintText: AppStrings.firstName.tr,
                          fillColor: AppColors.employeeCardColor,
                          textEditingController: controller.firstNameController,
                        ),
                        SizedBox(
                          height: 8.h,
                        ),
                        CustomTextField(
                          hintText: AppStrings.lastName.tr,
                          fillColor: AppColors.employeeCardColor,
                          textEditingController: controller.lastNameController,
                        ),
                        SizedBox(
                          height: 8.h,
                        ),

                        ///==================================✅✅jobType✅✅=======================

                        JobType(controller: controller),
                        SizedBox(
                          height: 8.h,
                        ),

                        ///==================================✅✅cPR✅✅=======================

                        CustomTextField(
                          readOnly: true,
                          onTap: () {
                            controller.isCprOpen.value = !controller.isCprOpen.value;
                          },
                          suffixIcon: Icon(
                            controller.isCprOpen.value
                                ? Icons.keyboard_arrow_up_rounded
                                : Icons.keyboard_arrow_down_rounded,
                          ),
                          hintText: AppStrings.cPR.tr,
                          fillColor: AppColors.employeeCardColor,
                        ),
                        SizedBox(
                          height: 8.h,
                        ),
                        CprOption(controller: controller),
                        SizedBox(
                          height: 8.h,
                        ),

                        ///==================================✅✅passport✅✅=======================

                        CustomTextField(
                          readOnly: true,
                          onTap: () {
                            controller.isPassportOpen.value = !controller.isPassportOpen.value;
                          },
                          suffixIcon: Icon(
                            controller.isPassportOpen.value
                                ? Icons.keyboard_arrow_up_rounded
                                : Icons.keyboard_arrow_down_rounded,
                          ),
                          hintText: AppStrings.passport.tr,
                          fillColor: AppColors.employeeCardColor,
                        ),
                        SizedBox(
                          height: 8.h,
                        ),
                        PassportOption(controller: controller),
                        SizedBox(
                          height: 8.h,
                        ),
                        ///==================================✅✅Note✅✅=======================
                        CustomTextField(
                          textEditingController: controller.noteController,
                          hintText: AppStrings.note.tr,
                          fillColor: AppColors.employeeCardColor,
                        ),
                        SizedBox(
                          height: 8.h,
                        ),
                        ///==================================✅✅Phone✅✅=======================
                        CustomTextField(
                          textEditingController: controller.phoneNumberController,
                          hintText: AppStrings.contactNumber.tr,
                          fillColor: AppColors.employeeCardColor,
                        ),

                        ///==================================✅✅email✅✅=======================

                        SizedBox(
                          height: 8.h,
                        ),
                        CustomTextField(
                          textEditingController: controller.emailController,
                          hintText: AppStrings.email.tr,
                          fillColor: AppColors.employeeCardColor,
                        ),
                        SizedBox(
                          height: 8.h,
                        ),

                        ///==================================✅✅temporaryPassword✅✅=======================

                        CustomTextField(
                          textEditingController: controller.passwordController,
                          hintText: AppStrings.temporaryPassword.tr,
                          fillColor: AppColors.employeeCardColor,
                          isPassword: true,
                        ),
                        SizedBox(
                          height: 15.h,
                        ),
                        ///==================================✅✅Duty Time✅✅=======================

                        ///==================================✅✅addNewEmployee Button✅✅=======================
                      controller.isLoading.value?const CustomLoader():
                        CustomButton(
                          onTap: () {
                            if (controller.profileImage.value == null) {
                              toastMessage(message: "Please select a profile image.");
                              print("❌ Please select a profile image.");
                              return;
                            }

                            AddEmployee.addEmployee(
                              firstName: controller.firstNameController.text.trim(),
                              lastName: controller.lastNameController.text.trim(),
                              email: controller.emailController.text.trim(),
                              password: controller.passwordController.text.trim(),
                              profileImage: controller.profileImage.value!,
                              phoneNumber: controller.phoneNumberController.text.trim(),
                              jobType: controller.selectedJobType.value,
                              cprNumber: controller.cprNumberController.text.trim(),
                              cprExpDate: controller.cprExpireDateController.text.trim(),
                              passportNumber: controller.passportController.text.trim(),
                              passportExpDate: controller.passportExpireDateController.text.trim(),
                              note: controller.noteController.text.trim(),
                              dutyTime: "9 AM - 5 PM",
                              workingDay: ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday"],
                              offDay: "Saturday", context: context,
                            );
                          },
                          fillColor: Colors.white,
                          title: AppStrings.addNewEmployee.tr,
                        )

                      ],
                    );
                  }
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}





























class PassportOption extends StatelessWidget {
  const PassportOption({
    super.key,
    required this.controller,
  });

  final AddEmployeeController controller;

  @override
  Widget build(BuildContext context) {
    return Obx(() => controller.isPassportOpen.value
        ? Column(
            children: [
              CustomTextField(
                textEditingController:
                    controller.passportController,
                hintText: AppStrings.passportNumber.tr,
                fillColor: Colors.white,
              ),
              SizedBox(
                height: 8.h,
              ),
              CustomTextField(
                textEditingController: controller.passportExpireDateController,
                readOnly: true,
                hintText: AppStrings.expireDate.tr,
                fillColor: Colors.white,
                suffixIcon: const Icon(Icons.calendar_month),
                onTap: () async {
                  DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2100),
                  );

                  if (pickedDate != null) {
                    String formattedDate = "${pickedDate.year}-${pickedDate.month}-${pickedDate.day}";
                    controller.passportExpireDateController.text = formattedDate;
                  }
                },
              ),
            ],
          )
        : const SizedBox());
  }
}

class CprOption extends StatelessWidget {
  const CprOption({
    super.key,
    required this.controller,
  });

  final AddEmployeeController controller;

  @override
  Widget build(BuildContext context) {
    return Obx(() => controller.isCprOpen.value
        ? Column(
            children: [
              CustomTextField(
                textEditingController:
                    controller.cprNumberController,
                hintText: AppStrings.cprNumber.tr,
                fillColor: Colors.white,
              ),
              SizedBox(
                height: 8.h,
              ),
              CustomTextField(
                textEditingController: controller.cprExpireDateController,
                readOnly: true,
                hintText: AppStrings.expireDate.tr,
                fillColor: Colors.white,
                suffixIcon: const Icon(Icons.calendar_month),
                onTap: () async {
                  DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2100),
                  );

                  if (pickedDate != null) {
                    String formattedDate = "${pickedDate.year}-${pickedDate.month}-${pickedDate.day}";
                    controller.cprExpireDateController.text = formattedDate;
                  }
                },
              ),

            ],
          )
        : const SizedBox());
  }
}

class JobType extends StatelessWidget {
  const JobType({
    super.key,
    required this.controller,
  });

  final AddEmployeeController controller;

  @override
  Widget build(BuildContext context) {
    return Obx(() => CustomTextField(
          textEditingController: controller.jobTypeController,
          suffixIcon: PopupMenuButton<String>(
            icon: const Icon(Icons.keyboard_arrow_down_rounded),
            onSelected: (value) {
              controller.updateJobType(value);
            },
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: "Full Time",
                child: Text("Full Time"),
              ),
              const PopupMenuItem(
                value: "Part Time",
                child: Text("Part Time"),
              ),
            ],
          ),
          hintText: controller.selectedJobType.value.isEmpty
              ? AppStrings.jobType.tr
              : controller.selectedJobType.value,
          readOnly: true,
          fillColor: AppColors.employeeCardColor,
        ));
  }
}

class AddEmployeeImage extends StatelessWidget {
  const AddEmployeeImage({
    super.key,
    required this.controller,
  });

  final AddEmployeeController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: () {
            controller.pickImage();
          },
          child: Obx(() {
            return CircleAvatar(
              radius: 58.5, // Adjust based on your design
              backgroundImage: controller.profileImage.value != null
              // Show the selected image if available
                  ? FileImage(controller.profileImage.value!)
              // Use the default image as an AssetImage
                  : const AssetImage(AppImages.avatar) as ImageProvider<Object>,
              child: controller.profileImage.value == null
              // Show an "add a photo" icon when no image is selected
                  ? const Icon(Icons.add_a_photo, size: 30, color: Colors.white)
                  : null,
            );
          }),
        )


      ],
    );
  }
}

