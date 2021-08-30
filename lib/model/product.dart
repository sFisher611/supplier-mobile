import 'dart:convert';

Product productFromJson(String str) => Product.fromJson(json.decode(str));

String productToJson(Product data) => json.encode(data.toJson());

class Product {
  Product({
    this.id,
    this.phone,
    this.addres,
    this.product,
    this.amount,
    this.status,
    this.branchId,
    this.userId,
    this.deliveryTime,
    this.customer,
    this.productId,
    this.orderId,
    this.comment,
    this.customerAddres,
    this.finishedTime,
    this.acceptedTime,
  });

  int id;
  String phone;
  String addres;
  String product;
  int amount;
  String status;
  int branchId;
  int userId;
  String deliveryTime;
  String customer;
  int productId;
  int orderId;
  String comment;
  String customerAddres;
  String finishedTime;
  String acceptedTime;

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json["id"],
        phone: json["phone"],
        addres: json["addres"],
        product: json["product"],
        amount: json["amount"],
        status: json["status"],
        branchId: json["branch_id"],
        userId: json["user_id"],
        deliveryTime: json["delivery_time"],
        customer: json["customer"],
        productId: json["product_id"],
        orderId: json["order_id"],
        comment: json["comment"],
        customerAddres: json["customer_addres"],
        finishedTime: json["finished_time"],
        acceptedTime: json["accepted_time"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "phone": phone,
        "addres": addres,
        "product": product,
        "amount": amount,
        "status": status,
        "branch_id": branchId,
        "user_id": userId,
        "delivery_time": deliveryTime,
        "customer": customer,
        "product_id": productId,
        "order_id": orderId,
        "comment": comment,
        "customer_addres": customerAddres,
        "finished_time": finishedTime,
        "accepted_time": acceptedTime,
      };
}
