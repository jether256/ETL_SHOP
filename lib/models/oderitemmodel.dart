List<OrderItemsModel> oderitemsFromJson(dynamic str) => List<OrderItemsModel>.from(
    (str).map(
          (x)=>OrderItemsModel.fromJson(x),
    ));



class OrderItemsModel {

  final String id;
  final String odid;
  final String proid;
  final String q;
  final String up;
  final String name;
  final String im;


  OrderItemsModel(
      {required this.name, required this.im,required this.id, required this.odid, required this.proid, required this.q, required this.up});

  factory OrderItemsModel.fromJson(Map<String,dynamic> json){
    return OrderItemsModel(
      id: json['id'],
      odid: json['order_id'],
      proid: json['product_id'],
      q: json['quantity'],
      up: json['unit_price'],
      name:json['pname'],
      im:json['pimage1'],
    );
  }

  factory OrderItemsModel.fromMap(Map<String,dynamic> json){
    return OrderItemsModel(
      id: json['id'],
      odid: json['order_id'],
      proid: json['product_id'],
      q: json['quantity'],
      up: json['unit_price'],
      name:json['pname'],
      im:json['pimage1'],
    );
  }


  Map<String, dynamic> toJson() =>
      {
        "id": id,
        "order_id": odid,
        "product_id": proid,
        "quantity": q,
        "unit_price": up,
      };

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "order_id": odid,
      "product_id": proid,
      "quantity": q,
      "unit_price": up,
    };
  }


}
