
List<ManModel> mafucFromJson(dynamic str) => List<ManModel>.from(
    (str).map(
          (x)=>ManModel.fromJson(x),
    ));



class ManModel{

  final String id;
  final String nem;
  final String logo;
  final String loc;
  final String dec;
  final String date;

  ManModel({required this.id, required this.nem, required this.logo, required this.loc,required this.dec, required this.date, });


  factory ManModel.fromJson(Map<String,dynamic> json){
    return   ManModel(
      id:json['manufacturer_id'],
      nem:json['manufacturer_name'],
      logo:json['manufacturer_logo'],
      loc:json['manufacturer_location'],
      dec:json['manufacturer_desc'],
      date:json['manufacturer_date_created'],
    );
  }

  factory ManModel.fromMap(Map<String,dynamic> json){
    return   ManModel(
      id:json['manufacturer_id'],
      nem:json['manufacturer_name'],
      logo:json['manufacturer_logo'],
      loc:json['manufacturer_location'],
      dec:json['manufacturer_desc'],
      date:json['manufacturer_date_created'],
    );
  }



  Map<String, dynamic> toJson() => {
    "manufacturer_id":id,
    "manufacturer_name":nem,
    "manufacturer_logo":logo,
    "manufacturer_location":loc,
    "manufacturer_desc":dec,
    "manufacturer_date_created":date,
  };

  Map<String, dynamic> toMap() {
    return {
      "manufacturer_id":id,
      "manufacturer_name":nem,
      "manufacturer_logo":logo,
      "manufacturer_location":loc,
      "manufacturer_desc":dec,
      "manufacturer_date_created":date,
    };
  }
}