// ignore_for_file: avoid_print

import 'dart:io';

import 'package:app/services/requests/post_requests/user_login_request.dart';
import 'package:app/shareds/managers/get_session_manager.dart';
import 'package:dio/dio.dart';

import '../services/exceptions/dio_exceptions.dart';
import '../services/requests/post_requests/rider_registration_request.dart';
import '../services/requests/post_requests/verify_otp_request.dart';
import '../services/responses/base_response.dart';
import '../services/responses/user_login_response.dart';
import '../services/responses/view_profile_response.dart';

import '../shareds/constants/endpoints.dart';
import '../shareds/helpers/api_connection_helper.dart';

class UserRepository {
  GetSessionManager session = GetSessionManager();
  var apiConnectionHelper = ApiConnectionHelper();
  dynamic response;

  Future<UserLoginResponse> userLoginAsync(UserLoginRequest request) async {
    try {
      var response = await apiConnectionHelper.postDataAsync(
          requestData: request, path: Endpoints().login);
      if (response.data != null) {
        return UserLoginResponse.fromJson(response.data);
      } else {
        throw Exception('Unable to login');
      }
    } on DioError catch (e) {
      return Future.error(DioExceptions.fromDioError(e));
    } on SocketException catch (e) {
      return Future.error(e);
    } catch (e) {
      return Future.error(e);
    }
  }

  Future<BaseResponse> createRiderAccountAsync(
      RiderRegistrationRequest request) async {
    try {
      var response = await apiConnectionHelper.postDataAsync(
          requestData: request, path: Endpoints().riderRegister);
      if (response.data != null) {
        return BaseResponse.fromJson(response.data);
      } else {
        throw Exception('Unable to create rider\'s account');
      }
    } on DioError catch (e) {
      return Future.error(DioExceptions.fromDioError(e));
    } on SocketException catch (e) {
      return Future.error(e);
    } catch (e) {
      return Future.error(e);
    }
  }

  Future<BaseResponse> verifyOtpAsync(VerifyOtpRequest request) async {
    try {
      var response = await apiConnectionHelper.postDataAsync(
          requestData: request, path: Endpoints().verifyOtp);
      if (response.data != null) {
        return BaseResponse.fromJson(response.data);
      } else {
        throw Exception('Unable to verify account');
      }
    } on DioError catch (e) {
      return Future.error(DioExceptions.fromDioError(e));
    } on SocketException catch (e) {
      return Future.error(e);
    } catch (e) {
      return Future.error(e);
    }
  }

  Future<ViewProfileResponse> getUserProfileAsync() async {
    try {
      var userId = session.readUserId();
      var url = '${Endpoints().userProfile}/$userId';
      //
      var response = await apiConnectionHelper.getDataAsync(
          url: url,
         );
      //
      if (response.data != null) {
        return ViewProfileResponse.fromJson(response.data);
      } else {
        throw Exception('Unable to get user profile');
      }
    } on DioError catch (e) {
      return Future.error(DioExceptions.fromDioError(e));
    } on SocketException catch (e) {
      return Future.error(e);
    } catch (e) {
      return Future.error(e);
    }
  }
}
