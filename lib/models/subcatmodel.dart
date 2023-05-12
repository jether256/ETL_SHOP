
import 'dart:convert';

List<SubCategoryModel> subcatFromJson(dynamic str) => List<SubCategoryModel>.from(
    (str).map(
          (x)=>SubCategoryModel.fromJson(x),
    ));


String subCategoryToJson(List<SubCategoryModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));


class SubCategoryModel{

  final String id;
  final String catid;
  final String sub;
  final String cre;

  SubCategoryModel({required this.id, required this.catid, required this.sub, required this.cre,});


  factory SubCategoryModel.fromJson(Map<String,dynamic> json){
    return   SubCategoryModel(
      id:json['sub_id'],
      catid:json['category_id'],
      sub:json['sub_name'],
      cre:json['date_created'],
    );
  }

  factory SubCategoryModel.fromMap(Map<String,dynamic> json){
    return   SubCategoryModel(
      id:json['sub_id'],
      catid:json['category_id'],
      sub:json['sub_name'],
      cre:json['date_created'],
    );
  }



  Map<String, dynamic> toJson() => {
    "sub_id":id,
    "category_id":catid,
    "sub_name":sub,
    "date_created":cre,
  };

  Map<String, dynamic> toMap() {
    return {
      "sub_id":id,
      "category_id":catid,
      "sub_name":sub,
      "date_created":cre,
    };
  }
}