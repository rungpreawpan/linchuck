class StockModel {
  int? ingredientsId;
  String? ingredientType;
  String? ingredientName;
  int? unitId;
  String? unitName;
  int? orderAmount;
  int? remain;
  String? lotNumber;
  String? orderDate;
  String? expireDate;
  int recipeQty;

  StockModel({
    this.ingredientsId,
    this.ingredientType,
    this.ingredientName,
    this.unitId,
    this.unitName,
    this.orderAmount,
    this.remain,
    this.lotNumber,
    this.orderDate,
    this.expireDate,
    this.recipeQty = 1,
  });

  factory StockModel.fromJSON(Map<String, dynamic> json) {
    return StockModel(
      ingredientsId: json['ingredients_id'] ?? 0,
      ingredientType: json['ingredients_type'] ?? '',
      ingredientName: json['ingredients_name'] ?? '',
      unitId: json['unit_id'] ?? 0,
      unitName: json['unit_name'] ?? '',
      orderAmount: json['order_amount'] ?? 0,
      remain: json['remain'] ?? 0,
      lotNumber: json['lot_number'] ?? '',
      orderDate: json['order_date'] ?? '',
      expireDate: json['expire_date'] ?? '',
    );
  }
}
