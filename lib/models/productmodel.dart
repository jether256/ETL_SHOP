import 'dart:convert';

List<ProductModel> productFromJson(dynamic str) => List<ProductModel>.from(
    (str).map(
          (x)=>ProductModel.fromJson(x),
    ));


String productToJson(List<ProductModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));


class ProductModel{

  final String id;
  final String nem;
  final String regp;
  final String selp;
  final String catid;
  final String disr;
  final String ratin;
  final String im1;
  final String im2;
  final String im3;
  final String manid;
  final String storeid;
  final String ava;
  final String desc;
  final String promoid;
  final String create;
  final String subid;
  final String modoid;
  final String fe;
  final String retun;
  final String psdec;
  final String end;

  ProductModel( {required this.id, required this.nem, required this.regp, required this.selp, required this.catid, required this.disr, required this.ratin, required this.im1, required this.im2, required this.im3, required this.manid, required this.storeid, required this.ava, required this.desc, required this.promoid, required this.create, required this.subid, required this.modoid, required this.fe, required this.retun, required this.psdec, required this.end,});


  factory   ProductModel.fromJson(Map<dynamic,dynamic> json){
    return     ProductModel(
      id:json['pid'],
      nem:json['pname'],
      regp:json['pregular_price'].toString(),
      selp:json['psale_price'].toString(),
      catid:json['category_id'],
      disr:json['pdiscount_rate'],
      ratin:json['prating'],
      im1:json['pimage1'],
      im2:json['pimage2'],
      im3:json['pimage3'],
      manid:json['manufacturer_id'],
      storeid:json['store_id'],
      ava:json['pavailability'],
      desc:json['pdescription'],
      promoid:json['promotion_id'],
      create:json['pdate_created'],
      subid:json['subcategory_id'],
      modoid:json['model_id'],
      fe:json['featured'],
      retun:json['return_policy'],
      psdec:json['psdescription'],
      end:json['end'],
    );
  }

  factory ProductModel.fromMap(Map<String,dynamic> json){
    return   ProductModel(
      id:json['pid'],
      nem:json['pname'],
      regp:json['pregular_price'].toString(),
      selp:json['psale_price'].toString(),
      catid:json['category_id'],
      disr:json['pdiscount_rate'],
      ratin:json['prating'],
      im1:json['pimage1'],
      im2:json['pimage2'],
      im3:json['pimage3'],
      manid:json['manufacturer_id'],
      storeid:json['store_id'],
      ava:json['pavailability'],
      desc:json['pdescription'],
      promoid:json['promotion_id'],
      create:json['pdate_created'],
      subid:json['subcategory_id'],
      modoid:json['model_id'],
      fe:json['featured'],
      retun:json['return_policy'],
      psdec:json['psdescription'],
      end:json['end'],
    );
  }



  Map<String, dynamic> toJson() => {
    "pid":id,
    "pname":nem,
    "pregular_price":regp,
    "psale_price":selp,
    "category_id":catid,
    "pdiscount_rate":disr,
    "prating":ratin,
    "pimage1":im1,
    "pimage2":im2,
    "pimage3":im3,
    "manufacturer_id":manid,
    "store_id":storeid,
    "pavailability":ava,
    "pdescription":desc,
    "promotion_id":promoid,
    "pdate_created":create,
    "subcategory_id":subid,
    "model_id":modoid,
    "featured":fe,
    "return policy":retun,
    "psdescription":psdec,
    "end":end,
  };

  Map<String, dynamic> toMap() {
    return {
      "pid":id,
      "pname":nem,
      "pregular_price":regp,
      "psale_price":selp,
      "category_id":catid,
      "pdiscount_rate":disr,
      "prating":ratin,
      "pimage1":im1,
      "pimage2":im2,
      "pimage3":im3,
      "manufacturer_id":manid,
      "store_id":storeid,
      "pavailability":ava,
      "pdescription":desc,
      "promotion_id":promoid,
      "pdate_created":create,
      "subcategory_id":subid,
      "model_id":modoid,
      "featured":fe,
      "return policy":retun,
      "psdescription":psdec,
      "end":end,
    };
  }

}