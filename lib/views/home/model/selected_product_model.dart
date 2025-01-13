import 'package:lin_chuck/views/home/model/product_model.dart';
import 'package:lin_chuck/views/home/model/sweet_model.dart';
import 'package:lin_chuck/views/login/model/user_model.dart';

class SelectedProductModel {
  ProductModel? product;
  SweetModel? sweet;
  int? quantity;

  SelectedProductModel({
    this.product,
    this.sweet,
    this.quantity,
  });
}

class SelectedPaymentModel {
  UserModel? user;
  double? totalPrice;
  String? payType;
  double? cashReceive;
  double? cashReturn;
  String payImage;

  SelectedPaymentModel({
    this.user,
    this.totalPrice,
    this.payType,
    this.cashReceive,
    this.cashReturn,
    this.payImage = '',
  });
}

class OrderPaymentModel {
  int? productId;
  int? sweetId;
  int? quantity;

  OrderPaymentModel({
    this.productId,
    this.sweetId,
    this.quantity,
  });

  Map<String, dynamic> toJson() {
    return {
      'product_id': productId,
      'sweet_id': sweetId,
      'quantity': quantity,
    };
  }
}
