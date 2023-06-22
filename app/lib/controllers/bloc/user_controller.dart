import 'package:app/repositories/user_repository.dart';
import 'package:app/services/requests/post_requests/user_login_request.dart';
import 'package:app/services/requests/post_requests/verify_otp_request.dart';

import '../../services/requests/post_requests/rider_registration_request.dart';
import '../../services/responses/base_response.dart';
import '../../services/responses/user_login_response.dart';

class UserController {
  final userRepository = UserRepository();

  Future<UserLoginResponse> loginAsync(UserLoginRequest request) async {
    try {
      final response = await userRepository.userLoginAsync(request);
      if (response.status) {
        return response;
      }
      return Future.error(response.message);
    } catch (e) {
      return Future.error(e);
    }
  }

  Future<BaseResponse> riderRegistrationAsync(
      RiderRegistrationRequest request) async {
    try {
      final response = await userRepository.createRiderAccountAsync(request);
      if (response.status) {
        return response;
      }
      return Future.error(response.message);
    } catch (e) {
      return Future.error(e);
    }
  }

  Future<BaseResponse> verifyOtpAsync(VerifyOtpRequest request) async {
    try {
      final response = await userRepository.verifyOtpAsync(request);
      if (response.status) {
        return response;
      }
      return Future.error(response.message);
    } catch (e) {
      return Future.error(e);
    }
  }
}