import 'package:app/shareds/managers/get_session_manager.dart';

import '../../repositories/payment_repository.dart';
import '../../services/requests/post_requests/top_up_wallet_request.dart';
import '../../services/requests/post_requests/verify_paystack_transaction_request.dart';
import '../../services/responses/top_up_wallet_response.dart';
import '../../services/responses/verify_paystack_transaction_response.dart';

class PaymentController {
  final paymentRepository = PaymentRepository();
  GetSessionManager session = GetSessionManager();

  Future<VerifyPaystackTransactionResponse> verifyPaystackTransactionAsync(
      String reference) async {
    try {
      var userId = session.readUserId();
      var request = VerifyPaystackTransactionRequest(
          userId: userId!, reference: reference);
      final response =
          await paymentRepository.verifyPaystackTransactionAsync(request);
      if (response.status) {
        return response;
      }
      return Future.error(response.message!);
    } catch (e) {
      return Future.error(e);
    }
  }

  Future<TopUpWalletResponse> topUpWalletAsync(
      TopUpWalletRequest request) async {
    try {
      final response = await paymentRepository.topUpWalletAsync(request);
      if (response.status) {
        return response;
      }
      return Future.error(response.message!);
    } catch (e) {
      return Future.error(e);
    }
  }
}
