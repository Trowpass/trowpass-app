// ignore_for_file: prefer_const_constructors
import 'package:app/shareds/utils/app_colors.dart';
import 'package:app/widgets/app_logo.dart';
import 'package:app/widgets/app_styles.dart';
import 'package:app/widgets/standard_button.dart';
import 'package:app/widgets/text_form_input.dart';
import 'package:app/widgets/text_label.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:overlay_loader_with_app_icon/overlay_loader_with_app_icon.dart';

import '../../controllers/inter_wallet_transfer_controller/pay_screen_controller.dart';

class InterWalletPayScreen extends StatelessWidget {
  InterWalletPayScreen({super.key});
  final payController = Get.put(PayController());

  @override
  Widget build(BuildContext context) {
    payController.clearTextFields();
    return Obx(() => OverlayLoaderWithAppIcon(
          isLoading: payController.isLoaded.value,
          overlayBackgroundColor: background,
          circularProgressColor: primaryColor,
          appIcon: appLogo(70, 70),
          child: GestureDetector(
            onTap: () => Get.focusScope!.unfocus(),
            child: Scaffold(
              backgroundColor: background,
              appBar: AppBar(
                backgroundColor: background,
                elevation: 0.0,
                title: Text(
                  "Trowpass",
                  style: appStyles(18, titleActive, FontWeight.w600),
                ),
                centerTitle: true,
                actions: [
                  IconButton(
                    icon: const Icon(Icons.notifications_outlined,
                        color: Colors.black),
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
            LabelText(textLabel: "Receipient Phone Number"),
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
              // textLabel: '08134678957462',
              textHint: 'Recipient Phone Number',
              isPassword: false,
              autoCorrect: false,
              validatorMessage: 'Please enter recepient number',
            ),
            const SizedBox(height: 10),
            LabelText(textLabel: "Recipient Name"),
            const SizedBox(height: 16),
            TextInputForm(
              enabled: false,
              inputController: payController.fullNameController,
              initialValue: payController.fullNameController.text,
              // textLabel: 'Receipient Name',
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
                  payController.InterWalletPay();
                }
              },
            ),
          ],
        ));
  }
}