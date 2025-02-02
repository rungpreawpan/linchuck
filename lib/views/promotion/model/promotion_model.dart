class PromotionModel {
  int? promotionId;
  String? promotionName;
  int? promotionAmount;
  String? startDate;
  String? endDate;

  PromotionModel({
    this.promotionId,
    this.promotionName,
    this.promotionAmount,
    this.startDate,
    this.endDate,
  });

  factory PromotionModel.fromJSON(Map<String, dynamic> json) {
    return PromotionModel(
      promotionId: json['promotion_id'] ?? 0,
      promotionName: json['promotion_name'] ?? '',
      promotionAmount: json['discount_amount'] ?? 0,
      startDate: json['start_date'] ?? '',
      endDate: json['end_date'] ?? '',
    );
  }
}
