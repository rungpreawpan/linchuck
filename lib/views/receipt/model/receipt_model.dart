class ReceiptModel {
  int? receiptId;
  int? userId;
  String? createOn;

  ReceiptModel({
    this.receiptId,
    this.userId,
    this.createOn,
  });

  factory ReceiptModel.fromJSON(Map<String, dynamic> json) {
    return ReceiptModel(
      receiptId: json['receipt_id'] ?? 0,
      userId: json['user_id'] ?? 0,
      createOn: json['create_on'] ?? '',
    );
  }
}
