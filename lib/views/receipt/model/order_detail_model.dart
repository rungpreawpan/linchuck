class OrderDetailModel {
  int? orderDetailId;
  int? orderId;
  int? productId;
  int? sweetId;
  int? quantity;

  OrderDetailModel({
    this.orderDetailId,
    this.orderId,
    this.productId,
    this.sweetId,
    this.quantity,
  });

  factory OrderDetailModel.fromJSON(Map<String, dynamic> json) {
    return OrderDetailModel(
      orderDetailId: json['order_detail_id'] ?? 0,
      orderId: json['order_id'],
      productId: json['product_id'],
      sweetId: json['sweet_id'],
      quantity: json['quantity'] ?? 0,
    );
  }
}
