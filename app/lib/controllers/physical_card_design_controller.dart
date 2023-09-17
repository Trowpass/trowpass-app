import 'package:app/screens/get_transport_card/card_request_successful.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PhysicalCardDesignController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final TextEditingController fullNameController = TextEditingController();

  void trySubmit() {
    Get.to(() => const CardRequestSuccessfulScreen(
          message: 'Card request successful! You will be notified when its ready for pickup.',
        ));
  }
}