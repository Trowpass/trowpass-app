// ignore_for_file: avoid_print, unnecessary_string_interpolations
import 'package:app/controllers/bloc/user_controller.dart';
import 'package:app/widgets/currency_format.dart';
import 'package:get/get.dart';

import '../shareds/managers/get_session_manager.dart';
import '../widgets/app_dialog.dart';

class DashboardController extends GetxController {
  final showBalance = true.obs;
  final userName = Rx<String>('');
  final fullName = Rx<String>('');
  final accountNumber = Rx<String>('');
  final balance = Rx<String>('');
  final qrCodeUrl = Rx<String>('');
  final isLoaded = Rx<bool>(false);

  GetSessionManager session = GetSessionManager();
  UserController userController = UserController();

  @override
  void onInit() {
    isLoaded.value = true;
    fullName.value = '';
    balance.value = '';
    accountNumber.value = '';
    userProfile();
    userWallet();
    super.onInit();
  }

  void toggleBalanceVisibility() {
    showBalance.toggle();
  }

  Future userProfile() async {
    var response = await userController.userProfileAsync();
    if (response.status) {
      fullName.value = session.readRiderFullName()!;
    }
  }

  Future userWallet() async {
    var response = await userController.userWalletAsync();
    if (response.status) {
      accountNumber.value = response.data!.accountNumber;
      balance.value = formatCurrency(response.data!.balance);
    }
  }

  Future<dynamic> displayPlaceholderDialog(String pageTitle) {
    return showAppDialog(
      title: pageTitle,
      subtitle: 'We have you in mind. In the main time, explore the available features. Thank you.',
      type: DialogType.warning,
    );
  }
}
