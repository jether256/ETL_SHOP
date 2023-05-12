List<ShippingModel> shippingFromJson(dynamic str) => List<ShippingModel>.from(
    (str).map(
          (x)=>ShippingModel.fromJson(x),
    ));





class ShippingModel{

  final String  id;
  final String  custid;
  final String  det;
  final String  mail;
  final String  phon;
  final String  ad1;
  final String  ad2;
  final String  city;
  final String  fnem;
  final String  lnem;
  final String  cont;
  final String  amt;


  ShippingModel({required this.id, required this.custid, required this.det, required this.mail,required this.phon, required this.ad1, required this.ad2, required this.city, required this.fnem, required this.lnem, required this.cont, required this.amt,  });

  factory ShippingModel.fromJson(Map<String,dynamic> json){
    return   ShippingModel(
      id:json['shipping_id'],
      custid:json['customer_id'],
      det:json['shipping_details'],
      mail:json['email'],
      phon:json['phone'],
      ad1:json['address1'],
      ad2:json['address2'],
      city:json['city'],
      fnem:json['fname'],
      lnem:json['lname'],
      cont:json['country'],
      amt:json['amount'],
    );
  }

  factory ShippingModel.fromMap(Map<String,dynamic> json){
    return   ShippingModel(
      id:json['shipping_id'],
      custid:json['customer_id'],
      det:json['shipping_details'],
      mail:json['email'],
      phon:json['phone'],
      ad1:json['address1'],
      ad2:json['address2'],
      city:json['city'],
      fnem:json['fname'],
      lnem:json['lname'],
      cont:json['country'],
      amt:json['amount'],
    );
  }



  Map<String, dynamic> toJson() => {
    "shipping_id":id,
    "customer":custid,
    "shipping_details":det,
    "email":mail,
    "phone":phon,
    "address1":ad1,
    "address2":ad2,
    "city":city,
    "fname":fnem,
    "lname":lnem,
    "country":cont,
    "amount":amt,
  };

  Map<String, dynamic> toMap() {
    return {
      "shipping_id":id,
      "customer":custid,
      "shipping_details":det,
      "email":mail,
      "phone":phon,
      "address1":ad1,
      "address2":ad2,
      "city":city,
      "fname":fnem,
      "lname":lnem,
      "country":cont,
      "amount":amt,
    };
  }





}