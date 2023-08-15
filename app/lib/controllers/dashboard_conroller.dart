// ignore_for_file: avoid_print

import 'package:app/controllers/bloc/user_controller.dart';
import 'package:app/extensions/string_casting_extension.dart';
import 'package:app/screens/auth/login.dart';
import 'package:app/shareds/managers/set_session_manager.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../shareds/utils/app_colors.dart';

class DashboardController extends GetxController {
  final showBalance = true.obs;
  final userName = Rx<String>('');
  final fullName = Rx<String>('');
  final accountNumber = Rx<String>('');
  final qrCodeUrl = Rx<String>('');
  final isLoaded = Rx<bool>(false);

  SetSessionManager session = SetSessionManager();
  UserController userController = UserController();

  @override
  void onInit() {
    isLoaded.value = false;
    userProfile();
    super.onInit();
  }

  void toggleBalanceVisibility() {
    showBalance.toggle();
  }

  Future userProfile() async {
    try {
      isLoaded.value = true;
      var response = await userController.userProfileAsync();
      if (response.status) {
        userName.value = response.data!.firstName!.toTitleCase();
        qrCodeUrl.value = response.data!.privateQRCode!;
        fullName.value =
            '${response.data!.firstName!.toTitleCase()} ${response.data!.lastName!.toCapitalized()}';
        accountNumber.value = response.data!.accountDetail != null
            ? response.data!.accountDetail!.accountNumber!
            : '';
        session.writeUserFullName(fullName.value);
        session.writeUserAccountNumber(accountNumber.value);
      } else {
        Get.defaultDialog(
            title: 'Information',
            content: const Text('Unable to fetch profile'));
        Get.to(LoginScreen());
      }
    } catch (e) {
      Get.snackbar('Information', e.toString(),
          backgroundColor: validationErrorColor,
          snackPosition: SnackPosition.BOTTOM);
      isLoaded.value = false;
    }
  }
}
