class ProductModel {
  int? id;
  String? name;
  int? productPrice;
  int? productCost;
  int? productTypeId;
  String? productImage;
  int? promotionId;

  ProductModel({
    this.id,
    this.name,
    this.productPrice,
    this.productCost,
    this.productTypeId,
    this.productImage,
    this.promotionId,
  });

  factory ProductModel.fromJSON(Map<String, dynamic> json) {
    return ProductModel(
      id: json['product_id'] ?? 0,
      name: json['product_name'] ?? '',
      productPrice: json['product_price'] ?? 0,
      productCost: json['product_cost'] ?? 0,
      productTypeId: json['product_type_id'] ?? 0,
      productImage: json['product_image'] ?? '',
      promotionId: json['promotion_id'],
    );
  }
}
