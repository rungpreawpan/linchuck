class RecipeModel {
  int? recipeId;
  int? productId;
  String? productName;
  int? ingredientId;
  String? ingredientName;
  int? amount;
  int? unitId;
  String? unitName;

  RecipeModel({
    this.recipeId,
    this.productId,
    this.productName,
    this.ingredientId,
    this.ingredientName,
    this.amount,
    this.unitId,
    this.unitName,
  });

  factory RecipeModel.fromJSON(Map<String, dynamic> json) {
    return RecipeModel(
      recipeId: json['recipe_id'] ?? 0,
      productId: json['product_id'] ?? 0,
      productName: json['product_name'] ?? '',
      ingredientId: json['ingredients_id'] ?? 0,
      ingredientName: json['ingredients_name'] ?? '',
      amount: json['amount'] ?? 0,
      unitId: json['unit_id'] ?? 0,
      unitName: json['unit'] ?? '',
    );
  }
}
