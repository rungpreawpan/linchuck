class OrderModel {
  int? orderId;
  int? paymentId;

  OrderModel({
    this.orderId,
    this.paymentId,
  });

  factory OrderModel.fromJSON(Map<String, dynamic> json) {
    return OrderModel(
      orderId: json['order_id'] ?? 0,
      paymentId: json['payment_id'] ?? 0,
    );
  }
}
