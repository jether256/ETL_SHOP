import 'dart:convert';

List<CartModel> cartsFromJson(dynamic str) => List<CartModel>.from(
    (str).map(
          (x)=>CartModel.fromJson(x),
    ));
//
// String cartToJson(List<CartModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));
//


class CartModel {

  final String id;
  final String proid;
  final String slp;
  final String rp;
  final String q;
  final String cuid;
  final String promid;
  final String other;
  final String im;
  final String name;

  CartModel(
      {required this.name, required this.im, required this.id, required this.proid, required this.slp, required this.rp, required this.q, required this.cuid, required this.promid, required this.other,});

  factory CartModel.fromJson(Map<String, dynamic> json){
    return CartModel(
      id: json['cart_id'],
      proid: json['product_id'],
      slp: json['sale_price'],
      rp: json['regular_price'],
      q: json['quantity'],
      cuid: json['customer_id'],
      promid: json['promotion_id'],
      other: json['other_note'],
      im: json['pimage1'],
      name: json['pname'],
    );
  }

  factory CartModel.fromMap(Map<String, dynamic> json){
    return CartModel(
      id: json['cart_id'],
      proid: json['product_id'],
      slp: json['sale_price'],
      rp: json['regular_price'],
      q: json['quantity'],
      cuid: json['customer_id'],
      promid: json['promotion_id'],
      other: json['other_note'],
      im: json['pimage1'],
      name: json['pname'],
    );
  }


  Map<String, dynamic> toJson() =>
      {
        "cart_id": id,
        "product_id": proid,
        "sale_price": slp,
        "regular_price": rp,
        "quantity": q,
        "customer_id": cuid,
        "promotion_id": promid,
        "other_note": other,
        "pimage1": im,
        "pname": name,
      };

  Map<String, dynamic> toMap() {
    return {
      "cart_id": id,
      "product_id": proid,
      "sale_price": slp,
      "regular_price": rp,
      "quantity": q,
      "customer_id": cuid,
      "promotion_id": promid,
      "other_note": other,
      "pimage1": im,
      "pname": name,
    };
  }

}



