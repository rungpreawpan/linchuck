class CreatePaymentModel {
  int? receiptId;
  int? paymentId;
  int? totalPrice;
  String? payType;
  String? payImage;
  String? createOn;

  CreatePaymentModel({
    this.receiptId,
    this.paymentId,
    this.totalPrice,
    this.payType,
    this.payImage,
    this.createOn,
  });

  factory CreatePaymentModel.fromJSON(Map<String, dynamic> json) {
    return CreatePaymentModel(
      receiptId: json['receipt_id'] ?? 0,
      paymentId: json['payment_id'] ?? 0,
      totalPrice: json['total_price'] ?? 0,
      payType: json['pay_type'] ?? '',
      payImage: json['pay_img'] ?? '',
    );
  }
}

class CreateOrderModel {
  int? productId;
  int? sweetId;
  int? quantity;
  int? orderId;
  int? orderDetailId;

  CreateOrderModel({
    this.productId,
    this.sweetId,
    this.quantity,
    this.orderId,
    this.orderDetailId,
  });

  factory CreateOrderModel.fromJSON(Map<String, dynamic> json) {
    return CreateOrderModel(
      productId: json['product_id'] ?? 0,
      sweetId: json['sweet_id'],
      quantity: json['quantity'] ?? 0,
      orderId: json['order_id'] ?? 0,
      orderDetailId: json['order_detail_id'] ?? 0,
    );
  }
}
