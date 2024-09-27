class PaymentModel {
  int? paymentId;
  int? receiptId;
  double? totalPrice;
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
    double? totalPrice;
    if (json['total_price'].runtimeType == int) {
      totalPrice = double.parse(json['total_price'].toString());
    } else {
      totalPrice = json['total_price'];
    }

    return PaymentModel(
      paymentId: json['payment_id'] ?? 0,
      receiptId: json['receipt_id'] ?? 0,
      totalPrice: totalPrice,
      payType: json['pay_type'] ?? '',
      payImage: json['pay_img'] ?? '',
      cashReceive: json['cash_receive'],
      cashReturn: json['cash_return'],
      createOn: json['create_on'] ?? '',
    );
  }
}
