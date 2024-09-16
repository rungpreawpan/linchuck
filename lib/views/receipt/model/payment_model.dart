class PaymentModel {
  int? paymentId;
  int? receiptId;
  double? totalPrice;
  String? payType;
  String? payImage;
  double? cashReceive;
  double? cashReturn;
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
      cashReceive: json['cash_receive'],
    );
  }
}
