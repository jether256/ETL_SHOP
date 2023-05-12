
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
//
List<UserModel> userModelFromJson(dynamic str) => List<UserModel>.from(
    (str).map(
          (x)=>UserModel.fromJson(x),
    ));

//
// List<UserModel> userModelFromJson(String str) => List<UserModel>.from(json.decode(str).map((x) => UserModel.fromJson(x)));
//
String userModelToJson(List<UserModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));





class UserModel {

  final String id;
  final String fnem;
  final String lnem;
  final String mail;
  final String phon;
  final String loc;
  final String photo;
  final String pass;
  final String count;
  final String date;

  UserModel(
      {required this.id, required this.fnem, required this.lnem, required this.mail, required this.phon, required this.loc, required this.photo, required this.pass, required this.count, required this.date, });
  static UserModel? sessionUser;
  factory UserModel.fromJson(Map<String,dynamic> json){
    return UserModel(
      id: json['cust_id'],
      fnem: json['cust_fname'],
      lnem: json['cust_lname'],
      mail: json['cust_email'],
      phon: json['cust_phone'],
      loc: json['cust_location'],
      photo: json['cust_photo'],
      pass: json['cust_password'],
      count: json['cust_country'],
      date: json['cust_created_on'],
    );
  }

  factory UserModel.fromMap(Map<String,dynamic> json){
    return UserModel(
      id: json['cust_id'],
      fnem: json['cust_fname'],
      lnem: json['cust_lname'],
      mail: json['cust_email'],
      phon: json['cust_phone'],
      loc: json['cust_location'],
      photo: json['cust_photo'],
      pass: json['cust_password'],
      count: json['cust_country'],
      date: json['cust_created_on'],
    );
  }

  //
  // Map<String, dynamic> toJson() =>
  //     {
  //       "cust_id": id,
  //       "cust_fname": fnem,
  //       "cust_lname":lnem,
  //       "cust_email":mail,
  //       "cust_phone": phon,
  //       "cust_location":loc,
  //       "cust_photo":photo,
  //       "cust_password":pass,
  //       "cust_country":count,
  //       "cust_created_on":date,
  //     };


  String toJson() => json.encode(toMap());

  Map<String, dynamic> toMap() {
    return {
      "cust_id": id,
      "cust_fname": fnem,
      "cust_lname":lnem,
      "cust_email":mail,
      "cust_phone": phon,
      "cust_location":loc,
      "cust_photo":photo,
      "cust_password":pass,
      "cust_country":count,
      "cust_created_on":date,
    };
  }

  // static void saveUser(UserModel user) async{
  //   SharedPreferences pref = await SharedPreferences.getInstance();
  //   var data = json.encode(user.toMap());
  //   pref.setString("user", data);
  //   pref.commit();
  // }
  //
  // static void getUser() async{
  //   SharedPreferences pref = await SharedPreferences.getInstance();
  //   var data = pref.getString("user");
  //   if(data != null){
  //     var decode = json.decode(data);
  //     var user = await UserModel.fromJson(decode);
  //     sessionUser = user;
  //   }else{
  //     sessionUser = null;
  //   }
  // }
  //
  // static void logOut() async{
  //   SharedPreferences p = await SharedPreferences.getInstance();
  //   p.setString("user", "");
  //   sessionUser = null;
  //   p.commit();
  // }

}




