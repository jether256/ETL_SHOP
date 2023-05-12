
List<OrderModel> orderFromJson(dynamic str) => List<OrderModel>.from(
    (str).map(
          (x)=>OrderModel.fromJson(x),
    ));



class OrderModel {

  final String id;
  final String custid;
  final String mtd;
  final String status;
  final String transid;
  final String amnt;
  final String create;
  final String shipd;


  OrderModel(
      {required this.id, required this.custid, required this.mtd, required this.status, required this.transid, required this.amnt, required this.create, required this.shipd,});

  factory OrderModel.fromJson(Map<String,dynamic> json){


    return OrderModel(
      id: json['order_id'],
      custid: json['customer_id'],
      mtd: json['payment_method_id'],
      status: json['order_status'],
      transid: json['transaction_id'],
      amnt: json['amount'],
      create: json['date_created'],
      shipd: json['shipping_id'],
          );
  }

}





