class PaymentMethod {
  String? method;

  static PaymentMethod card = PaymentMethod.from(method: "Card");
  static PaymentMethod bankTransfer = PaymentMethod.from(method: "Bank Transfer");
  static PaymentMethod ussd = PaymentMethod.from(method: "USSD");
  static PaymentMethod nqr = PaymentMethod.from(method: "NQR");
  static PaymentMethod internalTransfer = PaymentMethod.from(method: "Internal Transfer");
  static PaymentMethod externalTransfer = PaymentMethod.from(method: "External Transfer");

  PaymentMethod.from({this.method});

  @override
  String toString() {
    if (this == PaymentMethod.card) {
      return "Credit/Debit Card";
    } else if (this == PaymentMethod.bankTransfer) {
      return "Bank Transfer";
    } else if (this == PaymentMethod.ussd) {
      return "USSD";
    } else if (this == PaymentMethod.nqr) {
      return "NQR";
    } else if (this == PaymentMethod.internalTransfer) {
      return "Internal Transfer";
    } else if (this == PaymentMethod.externalTransfer) {
      return "External Transfer";
    } else {
      return "Unknown";
    }
  }

  @override
  bool operator ==(covariant PaymentMethod other) {
    if (identical(this, other)) return true;

    return other.method == method;
  }

  @override
  int get hashCode => method.hashCode;
}
