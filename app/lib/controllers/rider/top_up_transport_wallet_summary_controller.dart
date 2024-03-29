import 'package:get/get.dart';

class TopUpTransportWalletSummaryController extends GetxController {
  final amount = Rx<double>(0);
  final paymentId = Rx<String>('');
  final title = Rx<String>('Payment Summary');
  final summaryTitle = Rx<String>('');

  final setPaymentId = '#1234567';
  final double setAmount = 5000;

  @override
  void onInit() {
    paymentId.value = setPaymentId;
    amount.value = setAmount;
    super.onInit();
  }

  void trySubmit() {
    // Get.to(TopUpTransportWalletDoneScreen());
  }
}
