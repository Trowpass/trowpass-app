// ignore_for_file: prefer_const_constructors

import 'package:app/controllers/rider/bloc/inter_wallet_transfer_controller.dart';
import 'package:app/controllers/rider/bloc/user_controller.dart';
import 'package:app/controllers/rider/dashboard_controller.dart';
import 'package:app/screens/rider/send_money/Inter_wallet_pay/receipt.dart';
import 'package:app/services/requests/rider/post_requests/inter_wallet_transfer_request.dart';
import 'package:app/services/requests/rider/post_requests/view_user_by_phone_request.dart';
import 'package:app/services/responses/rider/inter_wallet_transfer_response.dart';
import 'package:app/shareds/managers/rider/get_session_manager.dart';
import 'package:app/shareds/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PayController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController narrationController = TextEditingController();
  final TextEditingController amountController = TextEditingController();
  final TextEditingController pinController = TextEditingController();
  final TextEditingController expenseTypeController = TextEditingController();
  final selectedExpenseTypeName = 'Select expense type'.obs;

  List<String> allExpenseTypes = [];
  List<String> allExpenseTypeNames = [];
  Map<String, int> expenseTypeIdMap = {};

  final isLoaded = false.obs;

  @override
  void onInit() {
    isLoaded.value = false;
    phoneNumberController.addListener(() {
      if (phoneNumberController.text.trim().length == 11) {
        fetchUserDataByPhoneNumber();
      }
    });
    super.onInit();
  }

  @override
  void onReady() {
    fetchExpenseTypeDetailsFromSessionStorage();
    super.onReady();
  }

  void onSetSelectedExpenseTypeName(Object? value) {
    selectedExpenseTypeName.value = value.toString();
  }

  int getSelectedExpenseTypeId() {
    return expenseTypeIdMap[selectedExpenseTypeName.value] ?? 0;
  }

  void fetchExpenseTypeDetailsFromSessionStorage() {
    try {
      // Retrieve bank details from session storage
      List<String> storedExpenseTypes =
          session.readAllExpenseTypes('allExpenseTypes');
      String storedselectedExpenseTypeName =
          session.readSelectedExpenseTypeName('selectedExpenseTypeName') ??
              'Select expense type';
      Map<String, int> storedexpenseTypeIdMap =
          session.readExpenseTypeIdMap('expenseTypeIdMap');
      // Update controller's variables with retrieved values
      allExpenseTypes = storedExpenseTypes;
      selectedExpenseTypeName.value = storedselectedExpenseTypeName;
      expenseTypeIdMap = storedexpenseTypeIdMap;
    } catch (e) {
      print('Error fetching bank details from: $e');
    }
  }

  void clearTextFields() {
    phoneNumberController.clear();
    fullNameController.clear();
    amountController.clear();
    narrationController.clear();
    pinController.clear();
    expenseTypeController.clear();
  }

  GetSessionManager session = GetSessionManager();
  InterwalletController interwalletController = InterwalletController();
  UserController userController = UserController();

  // Get user by phone number
  void fetchUserDataByPhoneNumber() async {
    if (phoneNumberController.text.trim().length == 11) {
      isLoaded.value = true;
      try {
        var phoneNumber = phoneNumberController.text.trim();
        var response = await userController
            .userByPhoneAsync(UserByPhoneRequest(phoneNumber: phoneNumber));

        if (response.status) {
          String fullName =
              "${response.data!.firstName} ${response.data!.lastName}";
          fullNameController.text = fullName;
        } else {
          Get.defaultDialog(
              title: 'Information', content: Text(response.message));
        }
        isLoaded.value = false;
      } catch (e) {
        Get.snackbar('Information', e.toString(),
            backgroundColor: dialogInfoBackground,
            snackPosition: SnackPosition.BOTTOM);
        isLoaded.value = false;
      }
    }
  }

  Future<void> interWalletPay() async {
    isLoaded.value = true;
    Get.focusScope!.unfocus();
    try {
      int expenseTypeId = getSelectedExpenseTypeId();
      int senderUserId = session.readUserId() as int;
      var response = await interwalletController
          .interWalletTransferAsync(InterWalletTransferRequest(
        senderUserId: senderUserId,
        recipientPhoneNumber: phoneNumberController.text.trim(),
        narration: narrationController.text.trim(),
        amount: int.parse(amountController.text),
        transportExpenseId: expenseTypeId,
        pin: pinController.text.trim(),
      ));
      if (response.status) {
        TransferResponseData transactionDetails = response.data!;
        InterWalletTransferResponse parsedResponse =
            InterWalletTransferResponse(
          status: response.status,
          message: response.message,
          responseCode: response.responseCode,
          data: transactionDetails,
        );
        Get.find<DashboardController>().userWallet();
        Get.offAll(InterWalletTransferReceiptScreen(
          transactionDetails: parsedResponse,
        ));
      } else {
        if (response.responseCode == "11") {
          Get.defaultDialog(
              title: 'Failed',
              content: Text(
                response.message,
                style: TextStyle(color: Colors.white),
              ));
        } else {
          Get.defaultDialog(
              title: 'Information', content: Text(response.message));
        }
        isLoaded.value = false;
      }
    } catch (e) {
      Get.snackbar('Information', e.toString(),
          backgroundColor: dialogInfoBackground,
          snackPosition: SnackPosition.BOTTOM);
      isLoaded.value = false;
    }
  }
}
