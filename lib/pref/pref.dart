

import 'dart:convert';

import 'package:edge_app/models/usermodel.dart';
import 'package:shared_preferences/shared_preferences.dart';
//
// class LoginPref{
//
//
//   static Future<Future<bool>> setLoginDetails(
//       UserModel userModel,
//       ) async{
//
//     final prefs= await SharedPreferences.getInstance();
//
//     return prefs.setString(
//         "userD",
//       userModel != null ? jsonEncode(userModel.toJson()) : "null",
//     );
//
//   }
//
//
//   static Future<UserModel?> getLog() async{
//     final prefs= await SharedPreferences.getInstance();
//
//     return (prefs.getString("userD") != null && prefs.getString("userD") !=null) ?
//         UserModel.fromJson(jsonDecode(prefs.getString("userD")!)): null;
//
//   }
//
//   static Future<bool> isLoggedIn() async {
//     final prefs = await SharedPreferences.getInstance();
//
//     return (prefs.getString("userD") != null && prefs.getString("userD") !=null) ? true:false;
//   }
//
//   static Future<void> logout() async{
//     await setLoginDetails(null);
//
//   }
// }