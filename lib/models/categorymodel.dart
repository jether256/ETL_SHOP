import 'dart:convert';

List<CategoryModel> categoriesFromJson(dynamic str) => List<CategoryModel>.from(
    (str).map(
            (x)=>CategoryModel.fromJson(x),
    ));

String categoryToJson(List<CategoryModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CategoryModel{

  final String  id;
  final String  nem;
  final String  slag;
  final String  date;

  CategoryModel({required this.id, required this.nem, required this.slag, required this.date, });

  factory CategoryModel.fromJson(Map<String,dynamic>json){
    return   CategoryModel(
        id:json['category_id'],
        nem:json['category_name'],
        slag:json['category_slag'],
        date:json['date_created'],
    );
  }

  factory CategoryModel.fromMap(Map<String,dynamic> json){
    return   CategoryModel(
      id:json['category_id'],
      nem:json['category_name'],
      slag:json['category_slag'],
      date:json['date_created'],
    );
  }



  Map<String, dynamic> toJson() => {
    "category_id":id,
    "category_name":nem,
    "category_slag":slag,
    "date_created":date,
  };

  Map<String, dynamic> toMap() {
    return {
      "category_id":id,
      "category_name":nem,
      "category_slag":slag,
      "date_created":date,
    };
  }





}