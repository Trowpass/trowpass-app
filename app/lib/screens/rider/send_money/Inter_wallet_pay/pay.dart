// ignore_for_file: prefer_const_constructors
import 'package:app/shareds/utils/app_colors.dart';
import 'package:app/widgets/all_exepnse_types_list.dart';
import 'package:app/widgets/app_styles.dart';
import 'package:app/widgets/standard_button.dart';
import 'package:app/widgets/text_form_input.dart';
import 'package:app/widgets/text_label.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../../controllers/rider/inter_wallet_transfer_controller/pay_screen_controller.dart';
import '../../../../shareds/utils/images.dart';
import '../../../../widgets/overlay_indeterminate_progress.dart';

class InterWalletPayScreen extends StatelessWidget {
  InterWalletPayScreen({super.key});
  final payController = Get.put(PayController());

  @override
  Widget build(BuildContext context) {
    payController.clearTextFields();
    return Obx(() => OverlayIndeterminateProgress(
          isLoading: payController.isLoaded.value,
          overlayBackgroundColor: background,
          progressColor: primaryColor,
          child: GestureDetector(
            onTap: () => Get.focusScope!.unfocus(),
            child: Scaffold(
              resizeToAvoidBottomInset: true,
              backgroundColor: background,
              appBar: AppBar(
                systemOverlayStyle: const SystemUiOverlayStyle(
                  statusBarColor: primaryColor,
                  statusBarBrightness: Brightness.light, // For iOS
                  statusBarIconBrightness: Brightness.light, // For Android
                  systemNavigationBarColor: navigationBarBackground,
                  systemNavigationBarIconBrightness: Brightness.light,
                ),
                backgroundColor: background,
                elevation: 0.0,
                title: Text(
                  "Trowpass",
                  style: appStyles(18, titleActive, FontWeight.w600),
                ),
                centerTitle: true,
                actions: [
                  IconButton(
                    icon: SvgPicture.asset(notificationIcon),
                    onPressed: () {
                      Get.back();
                    },
                  )
                ],
                leading: IconButton(
                  icon: const Icon(Icons.arrow_back, color: Colors.black),
                  onPressed: () {
                    Get.back();
                  },
                ),
              ),
              body: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      const SizedBox(height: 12),
                      PayForm(),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ));
  }
}

class PayForm extends StatelessWidget {
  final payController = Get.put(PayController());
  PayForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Form(
        key: payController.formKey,
        child: Column(
          children: [
            LabelText(textLabel: "Expense Type"),
            const SizedBox(height: 10),
            TextInputForm(
              onTap: () => showExpenseTypeList(context),
              enabled: true,
              readOnly: true,
              inputController: payController.expenseTypeController,
              textHint: 'Select Type',
              validatorMessage: 'Please expense type',
              isPassword: false,
              autoCorrect: false,
              suffixIcon: InkWell(
                onTap: () => showExpenseTypeList(context),
                child: Icon(Icons.arrow_drop_down),
              ),
              initialValue: payController.expenseTypeController.text,
            ),
            const SizedBox(height: 10),
            LabelText(textLabel: "Recipient Phone Number"),
            const SizedBox(height: 10),
            TextInputForm(
              inputType: TextInputType.number,
              enabled: true,
              inputController: payController.phoneNumberController,
              onChanged: (value) {
                if (value.trim().length == 11) {
                  payController.fetchUserDataByPhoneNumber();
                }
              },
              textHint: 'Recipient Phone Number',
              isPassword: false,
              autoCorrect: false,
              validatorMessage: 'Please enter recipient number',
            ),
            const SizedBox(height: 10),
            LabelText(textLabel: "Recipient Name"),
            const SizedBox(height: 16),
            TextInputForm(
              enabled: false,
              inputController: payController.fullNameController,
              textHint: 'Recipient Name',
              isPassword: false,
              autoCorrect: false,
            ),
            const SizedBox(height: 10),
            LabelText(textLabel: "Amount"),
            const SizedBox(height: 16),
            TextInputForm(
              inputType: TextInputType.number,
              enabled: true,
              inputController: payController.amountController,
              // textLabel: 'Amount',
              textHint: 'N1200',
              validatorMessage: 'Please enter an amount',
              isPassword: false,
              autoCorrect: false,
            ),
            const SizedBox(height: 10),
            LabelText(textLabel: "Narration"),
            const SizedBox(height: 16),
            TextInputForm(
              enabled: true,
              inputController: payController.narrationController,
              // textLabel: 'Narration',
              textHint: 'Narration',
              isPassword: false,
              autoCorrect: false,
              validatorMessage: 'Please enter a narration',
            ),
            const SizedBox(height: 10),
            LabelText(textLabel: "PIN"),
            const SizedBox(height: 16),
            TextInputForm(
                enabled: true,
                inputType: TextInputType.number,
                inputController: payController.pinController,
                // textLabel: 'Pin',
                textHint: '0000',
                validatorMessage: 'Enter your pin',
                isPassword: true,
                autoCorrect: false),
            const SizedBox(height: 25),
            StandardButton(
              text: 'Pay Now',
              onPressed: () {
                if (payController.formKey.currentState!.validate()) {
                  payController.interWalletPay();
                }
              },
            ),
          ],
        ));
  }

  void showExpenseTypeList(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(16.0), topRight: Radius.circular(16.0)),
      ),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      builder: (BuildContext context) {
        return ExpenseTypeModalSheet(
          onExpenseSelected: (selectedExpenseType) {
            payController.onSetSelectedExpenseTypeName(selectedExpenseType);
            payController.expenseTypeController.text = selectedExpenseType;
            Navigator.pop(context);
          },
          allExpenseTypes: payController.allExpenseTypes,
          initialSelectedType: payController.selectedExpenseTypeName.value,
        );
      },
    );
  }
}
