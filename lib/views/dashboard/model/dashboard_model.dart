class DashboardModel {
  int? allOrder;
  double? sales;
  double? allCosts;
  double? profit;
  List<SellProductModel>? sellProduct;
  List<SellTypesModel>? sellTypes;
  List<SummaryOrderModel>? order;

  DashboardModel({
    this.allOrder,
    this.sales,
    this.allCosts,
    this.profit,
    this.sellProduct,
    this.sellTypes,
    this.order,
  });

  factory DashboardModel.fromJSON(Map<String, dynamic> json) {
    double? sales;
    double? allCosts;
    double? profit;

    sales = double.parse(json['sales'].toString());
    allCosts = double.parse(json['allCost'].toString());
    profit = double.parse(json['profit'].toString());

    return DashboardModel(
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
      order: List.from(json['order'])
          .map((e) => SummaryOrderModel.fromJSON(e))
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

class SummaryOrderModel {
  int? id;
  String? orderDate;
  String? receiptNo;
  String? paymentType;
  String? username;
  int? total;

  SummaryOrderModel({
    this.id,
    this.orderDate,
    this.receiptNo,
    this.paymentType,
    this.username,
    this.total,
  });

  factory SummaryOrderModel.fromJSON(Map<String, dynamic> json) {
    return SummaryOrderModel(
      id: json['id'] ?? 0,
      orderDate: json['order_date'] ?? '',
      paymentType: json['payment_type'] ?? '',
      receiptNo: json['receipt_no'] ?? '',
      username: json['user_name'] ?? '',
      total: json['total'] ?? 0,
    );
  }
}
