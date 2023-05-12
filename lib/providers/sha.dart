//
// import 'package:edge_app/models/usermodel.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter_easyloading/flutter_easyloading.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//
// import '../dashboard+Screens/dashboard.dart';
//
// class SharedProvider with ChangeNotifier {
//
//
//   final Future<SharedPreferences> _pref = SharedPreferences.getInstance();
//   String _id='';
//   String _fnem='';
//   String _lnem='';
//   String _mail='';
//   String _phone='';
//   String _loc='';
//   String _phot='';
//   String _pass='';
//   String _count='';
//   String _date='';
//
//
//   String get id => _id;
//   String get fnem => _fnem;
//   String get lnem => _lnem;
//   String get mail => _mail;
//   String get phone => _phone;
//   String get loc => _loc;
//   String get phot => _phot;
//   String get pass => _pass;
//   String get count => _count;
//   String get date => _date;
//
//
//
//   void saveUserId(String id) async {
//     SharedPreferences value = await _pref;
//
//     value.setString('cust_id', id);
//   }
//
//   void saveUserFnem(String fnem) async {
//     SharedPreferences value = await _pref;
//
//     value.setString('cust_fname', fnem);
//   }
//
//   void saveUserLnem(String lnem) async {
//     SharedPreferences value = await _pref;
//
//     value.setString('cust_lname', lnem);
//   }
//
//   void saveUserEmail(String email) async {
//     SharedPreferences value = await _pref;
//
//     value.setString('cust_email', email);
//   }
//
//   void saveUserPhone(String phone) async {
//     SharedPreferences value = await _pref;
//
//     value.setString('cust_phone', phone);
//   }
//
//
//   void saveUserLocation(String loc) async {
//     SharedPreferences value = await _pref;
//
//     value.setString('cust_location', loc);
//   }
//
//
//   void saveUserPhoto(String pass) async {
//     SharedPreferences value = await _pref;
//
//     value.setString('cust_photo', pass);
//   }
//
//   void saveUserPass(String fnem) async {
//     SharedPreferences value = await _pref;
//
//     value.setString('cust_password', fnem);
//   }
//
//   void saveUserCount(String count) async {
//     SharedPreferences value = await _pref;
//
//     value.setString('cust_country', count);
//   }
//
//   void saveUserCreated(String create) async {
//     SharedPreferences value = await _pref;
//
//     value.setString('cust_created_on', create);
//   }
//
//
//
//
//
//
//
//   ///get shared data
//
//   Future<String> getUserID() async {
//     SharedPreferences value = await _pref;
//
//     if (value.containsKey('cust_id')) {
//       String data = value.getString('cust_id')!;
//       _id = data;
//       notifyListeners();
//       return data;
//     } else {
//       _id = '';
//       notifyListeners();
//       return '';
//     }
//   }
//
//   Future<String> getUserFnem() async {
//     SharedPreferences value = await _pref;
//
//     if (value.containsKey('cust_fname')) {
//       String data = value.getString('cust_fname')!;
//       _fnem = data;
//       notifyListeners();
//       return data;
//     } else {
//       _fnem = '';
//       notifyListeners();
//       return '';
//     }
//   }
//
//   Future<String> getUserLnem() async {
//     SharedPreferences value = await _pref;
//
//     if (value.containsKey('cust_lname')) {
//       String data = value.getString('cust_lname')!;
//       _lnem = data;
//       notifyListeners();
//       return data;
//     } else {
//       _lnem = '';
//       notifyListeners();
//       return '';
//     }
//   }
//
//   Future<String> getUserEmail() async {
//     SharedPreferences value = await _pref;
//
//     if (value.containsKey('cust_email')) {
//       String data = value.getString('cust_email')!;
//       _mail = data;
//       notifyListeners();
//       return data;
//     } else {
//       _mail = '';
//       notifyListeners();
//       return '';
//     }
//   }
//
//   Future<String> getUserPhone() async {
//     SharedPreferences value = await _pref;
//
//     if (value.containsKey('cust_phone')) {
//       String data = value.getString('cust_phone')!;
//       _phone = data;
//       notifyListeners();
//       return data;
//     } else {
//       _phone = '';
//       notifyListeners();
//       return '';
//     }
//   }
//
//   Future<String> getUserLocation() async {
//     SharedPreferences value = await _pref;
//
//     if (value.containsKey('cust_location')) {
//       String data = value.getString('cust_location')!;
//       _loc = data;
//       notifyListeners();
//       return data;
//     } else {
//       _loc = '';
//       notifyListeners();
//       return '';
//     }
//   }
//
//   Future<String> getUserPhoto() async {
//     SharedPreferences value = await _pref;
//
//     if (value.containsKey('cust_photo')) {
//       String data = value.getString('cust_photo')!;
//       _phot = data;
//       notifyListeners();
//       return data;
//     } else {
//       _phot = '';
//       notifyListeners();
//       return '';
//     }
//   }
//
//   Future<String> getUserPass() async {
//     SharedPreferences value = await _pref;
//
//     if (value.containsKey('cust_password')) {
//       String data = value.getString('cust_password')!;
//       _pass = data;
//       notifyListeners();
//       return data;
//     } else {
//       _pass = '';
//       notifyListeners();
//       return '';
//     }
//   }
//
//   Future<String> getUserCountry() async {
//     SharedPreferences value = await _pref;
//
//     if (value.containsKey('cust_country')) {
//       String data = value.getString('cust_country')!;
//       _count = data;
//       notifyListeners();
//       return data;
//     } else {
//       _count = '';
//       notifyListeners();
//       return '';
//     }
//   }
//
//   Future<String> getUserDate() async {
//     SharedPreferences value = await _pref;
//
//     if (value.containsKey('cust_created_on')) {
//       String data = value.getString('cust_created_on')!;
//       _date = data;
//       notifyListeners();
//       return data;
//     } else {
//       _date = '';
//       notifyListeners();
//       return '';
//     }
//   }
//
//
//   void logOut(BuildContext context) async {
//     final value = await _pref;
//
//     value.clear();
//
//     EasyLoading.showSuccess("You have Logged out");
//
//     out(context);
//
//   }
//
// }
//
// out(BuildContext context){
//   Navigator.pushReplacementNamed(context, Dashboard.id);
//
// }
