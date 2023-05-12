
List<PartnersModel> partnersFromJson(dynamic str) => List<PartnersModel>.from(
    (str).map(
          (x)=>PartnersModel.fromJson(x),
    ));


class PartnersModel{

  final String id;
  final String logo;
  final String nem;


  PartnersModel({required this.id, required this.logo, required this.nem});


  factory PartnersModel.fromJson(Map<String,dynamic> json){
    return   PartnersModel(
      id:json['id'],
      logo:json['logo'],
      nem:json['names'],
    );
  }

  factory PartnersModel.fromMap(Map<String,dynamic> json){
    return   PartnersModel(
      id:json['id'],
      logo:json['logo'],
      nem:json['names'],
    );
  }



  Map<String, dynamic> toJson() => {
    "id":id,
    "logo":logo,
    "names":nem,
  };

  Map<String, dynamic> toMap() {
    return {
      "id":id,
      "logo":logo,
      "names":nem
    };
  }
}