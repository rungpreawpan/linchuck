class ProductTypeModel {
  int? id;
  String? name;
  int? quantity;

  ProductTypeModel({
    this.id,
    this.name,
    this.quantity,
  });

  factory ProductTypeModel.fromJSON(Map<String, dynamic> json) {
    return ProductTypeModel(
      id: json['product_type_id'],
      name: json['product_type'],
      quantity: json['count'],
    );
  }
}
