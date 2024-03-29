class UserWalletResponse {
  String message;
  bool status;
  String responseCode;
  WalletData? data;

  UserWalletResponse({
    required this.message,
    required this.status,
    required this.responseCode,
    required this.data,
  });
  factory UserWalletResponse.fromJson(Map<String, dynamic> json) =>
      UserWalletResponse(
        status: json['status'],
        message: json['message'],
        responseCode: json['responseCode'],
        data: json['data'] != null ? WalletData.fromJson(json['data']) : null,
      );
}

class WalletData {
  int id;
  int accountUserId;
  String? name;
  String? accountNumber;
  String? bankName;
  String? phoneNumber;
  double balance;
  bool isActive;
  String? serviceWalletId;

  WalletData({
    required this.id,
    required this.accountUserId,
    required this.name,
    required this.accountNumber,
    required this.bankName,
    required this.phoneNumber,
    required this.balance,
    required this.isActive,
    required this.serviceWalletId,
  });

  factory WalletData.fromJson(Map<String, dynamic> json) => WalletData(
        id: json['id'] ?? 0,
        accountUserId: json['accountUserId'] ?? 0,
        name: json['name'] ?? '',
        accountNumber: json['accountNumber'] ?? '',
        bankName: json['bankName'] ?? '',
        phoneNumber: json['phoneNumber'] ?? '',
        balance: (json['balance'] ?? 0.0).toDouble(),
        isActive: json['isActive'],
        serviceWalletId: json['serviceWalletId'] ?? '',
      );
}
