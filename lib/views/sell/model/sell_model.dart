class SellModel {
  int? allOrder;
  double? sales;
  double? allCosts;
  double? profit;
  List<SellProductModel>? sellProduct;
  List<SellTypesModel>? sellTypes;

  SellModel({
    this.allOrder,
    this.sales,
    this.allCosts,
    this.profit,
    this.sellProduct,
    this.sellTypes,
  });

  factory SellModel.fromJSON(Map<String, dynamic> json) {
    double? sales;
    double? allCosts;
    double? profit;

    sales = double.parse(json['sales'].toString());
    allCosts = double.parse(json['allCost'].toString());
    profit = double.parse(json['profit'].toString());

    return SellModel(
      allOrder: json['allOrder'] ?? 0,
      sales: sales,
      allCosts: allCosts,
      profit: profit,
      sellProduct: List.from(json['products'])
          .map((e) => SellProductModel.fromJSON(e))
          .toList(),
      sellTypes: List.from(json['types'])
          .map((e) => SellTypesModel.fromJSON(e))
          .toList(),
    );
  }
}

class SellProductModel {
  int? id;
  String? name;
  double? cost;
  int? count;

  SellProductModel({
    this.id,
    this.name,
    this.cost,
    this.count,
  });

  factory SellProductModel.fromJSON(Map<String, dynamic> json) {
    double? cost;
    cost = double.parse(json['cost'].toString());

    return SellProductModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      cost: cost,
      count: json['count'] ?? 0,
    );
  }
}

class SellTypesModel {
  int? id;
  String? name;
  int? count;

  SellTypesModel({
    this.id,
    this.name,
    this.count,
  });

  factory SellTypesModel.fromJSON(Map<String, dynamic> json) {
    return SellTypesModel(
      id: json['id'] ?? 0,
      name: json['type'] ?? '',
      count: json['count'] ?? 0,
    );
  }
}
