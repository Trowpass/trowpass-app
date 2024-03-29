// ignore_for_file: unnecessary_string_interpolations

import 'dart:io';

import 'package:app/services/requests/rider/post_requests/topup_transport_wallet_request.dart';
import 'package:app/services/requests/rider/post_requests/user_by_account_number_request.dart';
import 'package:app/services/responses/rider/all_expense_types_response.dart';
import 'package:app/services/responses/rider/get_all_banks_reponse.dart';
import 'package:app/services/responses/rider/get_all_transport_company_response.dart';
import 'package:app/services/responses/rider/get_user_by_account_response.dart';
import 'package:app/services/responses/rider/topup_transport_wallet_response.dart';
import 'package:app/shareds/managers/rider/get_session_manager.dart';
import 'package:dio/dio.dart';

import '../../services/exceptions/dio_exceptions.dart';
import '../../shareds/constants/endpoints.dart';
import '../../shareds/helpers/api_connection_helper.dart';

class TopupTransportWalletRepository {
  GetSessionManager session = GetSessionManager();
  var apiConnectionHelper = ApiConnectionHelper();
  dynamic response;

  Future<BanksResponse> getallBanksAsync() async {
    try {
      var url = Endpoints.banks;
      //
      var response = await apiConnectionHelper.getDataAsync(
        url: url,
      );
      //
      if (response.data != null) {
        return BanksResponse.fromJson(response.data);
      } else {
        throw Exception('Unable to fetch banks');
      }
    } on DioException catch (e) {
      return Future.error(DioExceptions.fromDioError(e));
    } on SocketException catch (e) {
      return Future.error(e);
    } catch (e) {
      return Future.error(e);
    }
  }

  Future<AllExpenseTypeResponse> getAllExpenseTypesAsync() async {
    try {
      var url = Endpoints.expenseTypes;
      var response = await apiConnectionHelper.getDataAsync(
        url: url,
      );
      if (response.data != null) {
        return AllExpenseTypeResponse.fromJson(response.data);
      } else {
        throw Exception('Unable to fetch expense types');
      }
    } on DioException catch (e) {
      return Future.error(DioExceptions.fromDioError(e));
    } on SocketException catch (e) {
      return Future.error(e);
    } catch (e) {
      return Future.error(e);
    }
  }

  Future<TransportCompanyResponse> getallTransportCompanyAsync() async {
    try {
      var url = Endpoints.transportCompany;
      //
      var response = await apiConnectionHelper.getDataAsync(
        url: url,
      );
      //
      if (response.data != null) {
        return TransportCompanyResponse.fromJson(response.data);
      } else {
        throw Exception('Unable to fetch transport companies');
      }
    } on DioException catch (e) {
      return Future.error(DioExceptions.fromDioError(e));
    } on SocketException catch (e) {
      return Future.error(e);
    } catch (e) {
      return Future.error(e);
    }
  }

  Future<TopUpTransportWalletResponse> topupTransportWalletAsync(
      TopupTransportWalletRequest request) async {
    try {
      var response = await apiConnectionHelper.postDataAsync(
          requestData: request, path: Endpoints.transportWallet);
      if (response.data != null) {
        return TopUpTransportWalletResponse.fromJson(response.data);
      } else {
        throw Exception('Transaction Failed');
      }
    } on DioException catch (e) {
      return Future.error(DioExceptions.fromDioError(e));
    } on SocketException catch (e) {
      return Future.error(e);
    } catch (e) {
      return Future.error(e);
    }
  }

  Future<UserByAccountNumberResponse> getUserByAccountNumberAsync(
      UserByAccountNumberRequest request) async {
    try {
      var response = await apiConnectionHelper.postDataAsync(
          requestData: request, path: Endpoints.userByAccountNumber);
      if (response.data != null) {
        return UserByAccountNumberResponse.fromJson(response.data);
      } else {
        throw Exception('Unable to get user with account number');
      }
    } on DioException catch (e) {
      return Future.error(DioExceptions.fromDioError(e));
    } on SocketException catch (e) {
      return Future.error(e);
    } catch (e) {
      return Future.error(e);
    }
  }
}
