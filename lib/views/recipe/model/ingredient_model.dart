class IngredientModel {
  int? productId;
  String? productName;
  int? ingredientId;
  String? ingredientName;
  int? amount;
  int? unitId;
  String? unit;

  IngredientModel({
    this.productId,
    this.productName,
    this.ingredientId,
    this.ingredientName,
    this.amount,
    this.unitId,
    this.unit,
  });

  Map<String, dynamic> toJSON() {
    return {
      "product_id": productId,
      "product_name": productName,
      "ingredients_id": ingredientId,
      "ingredients_name": ingredientName,
      "amount": amount,
      "unit_id": unitId,
      "unit": unit,
    };
  }
}
