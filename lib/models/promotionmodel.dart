
List<PromotionModel> promotionFromJson(dynamic str) => List<PromotionModel>.from(
    (str).map(
          (x)=>PromotionModel.fromJson(x),
    ));




class PromotionModel{

  final String  id;
  final String  nem;
  final String  off;
  final String  date;


  PromotionModel({required this.id, required this.nem, required this.off, required this.date });

  factory PromotionModel.fromJson(Map<String,dynamic> json){
    return   PromotionModel(
      id:json['promotion_id'],
      nem:json['promotion_name'],
      off:json['offer'],
      date:json['promotion_date_created'],
    );
  }

  factory PromotionModel.fromMap(Map<String,dynamic> json){
    return   PromotionModel(
      id:json['promotion_id'],
      nem:json['promotion_name'],
      off:json['offer'],
      date:json['promotion_date_created'],
    );
  }



  Map<String, dynamic> toJson() => {
    "promotion_id":id,
    "promotion_name":nem,
    "offer":off,
    "promotion_date_created":date,
  };

  Map<String, dynamic> toMap() {
    return {
      "promotion_id":id,
      "promotion_name":nem,
      "offer":off,
      "promotion_date_created":date,
    };
  }





}