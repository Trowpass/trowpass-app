import 'package:app/repositories/cards_repository.dart';
import 'package:app/services/requests/post_requests/create_virtual_card_request.dart';
import 'package:app/shareds/managers/get_session_manager.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../screens/get_transport_card/card_request_successful.dart';
import '../shareds/utils/app_colors.dart';

class VirtualCardDesignController extends GetxController {
  final cardsRepository = CardsRepository();
  final isLoaded = false.obs;
  final session = GetSessionManager();

  Future<void> createVirtualCard() async {
    isLoaded.value = true;
    Get.focusScope!.unfocus();

    try {
      final request = CreateVirtualCardRequest(userId: session.readUserId());
      final response = await cardsRepository.createVirtualCardAsync(request);
      if (response.status) {
        isLoaded.value = false;
        Get.to(() => const CardRequestSuccessfulScreen(message: 'Congratulations your card has been created!'));
      } else {
        Get.defaultDialog(title: 'Information', content: Text(response.message));
        isLoaded.value = false;
      }
    } catch (e) {
      Get.snackbar(
        'Information',
        e.toString(),
        backgroundColor: validationErrorColor,
        snackPosition: SnackPosition.BOTTOM,
      );
      isLoaded.value = false;
    }
  }
}