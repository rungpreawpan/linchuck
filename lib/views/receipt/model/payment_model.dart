class PaymentModel {
  int? paymentId;
  int? receiptId;
  int? totalPrice;
  String? payType;
  String? payImage;
  int? cashReceive;
  int? cashReturn;
  String? createOn;

  PaymentModel({
    this.paymentId,
    this.receiptId,
    this.totalPrice,
    this.payType,
    this.payImage,
    this.cashReceive,
    this.cashReturn,
    this.createOn,
  });

  factory PaymentModel.fromJSON(Map<String, dynamic> json) {
    return PaymentModel(
      paymentId: json['payment_id'] ?? 0,
      receiptId: json['receipt_id'] ?? 0,
      totalPrice: json['total_price'] ?? 0,
      payType: json['pay_type'] ?? '',
      payImage: json['pay_img'] ?? '',
      cashReceive: json['cash_receive'] ?? 0,
      cashReturn: json['cash_return'] ?? 0,
      createOn: json['create_on'] ?? '',
    );
  }
}
