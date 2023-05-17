import 'package:edge_app/models/usermodel.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../api/services/ecom.dart';
import '../dashboard+Screens/dashboard.dart';
import '../encryption/encrypt.dart';
import '../models/productmodel.dart';
import '../sharedprefrences/usershare.dart';

class UserProvider with ChangeNotifier {

  ApiCall _service = new ApiCall();
  String _uid='';
  String _fnem='';
  String _lnem='';
  String _mail='';
  String _phone='';
  String _loc='';
  String _photo='';
  String _pass='';
  String _count='';
  String _date='';
  String _cart='';
  String _bal='';

  late String maile;

  bool isLoading = false;

  bool verifyButton=false;

  Map<String,dynamic>? _reg;
  Map<String,dynamic> get data =>_reg!;

  Map<String,dynamic>? _login;
  Map<String,dynamic> get login =>_login!;

  Map<String,dynamic>? _reset;
  Map<String,dynamic> get reset =>_reset!;



  Map<String,dynamic>? _verify;
  Map<String,dynamic> get verify =>_verify!;


  Map<String,dynamic>? _sendmail;
  Map<String,dynamic> get sendmail =>_sendmail!;


  Map<String,dynamic>? _passOTP;
  Map<String,dynamic> get passOTP =>_passOTP!;



  String get fnem => _fnem;
  String get uid => _uid;
  String get lnem => _lnem;
  String get mail => _mail;
  String get phone => _phone;
  String get loc => _loc;
  String get photo => _photo;
  String get pass => _pass;
  String get count => _count;
  String get date => _date;
  String get cart => _cart;
  String get bal => _bal;


  getselectedEmail(Email){
    maile=Email;
    notifyListeners();
  }

 registerUser({
    required String email,
    required String password,
    required String firstName,
    required String lastName,
    required String address,
    required String phone,
    required String country,
    required BuildContext context,
  }) async {
    isLoading = true;
    notifyListeners();
    //
    // verifyButton=false;
    // notifyListeners();


  final response = await _service.Register(email,password,firstName,lastName,address,phone,context,country);
    _reg=response as Map<String, dynamic>?;
    notifyListeners();
    //
    // verifyButton=true;
    // notifyListeners();

    isLoading=false;
    notifyListeners();
  }




//verify registration otp
  verifyOtp({
    required String email,
    required BuildContext context,
    required String code,
  }) async {
    isLoading = true;
    notifyListeners();

    final response = await _service.MailVeri(email,code,context);
    _verify=response as Map<String, dynamic>?;
    notifyListeners();

    isLoading=false;
    notifyListeners();
  }



  //verify forgot password otp
  sendMail({
    required String email,
    required BuildContext context,
  }) async {
    isLoading = true;
    notifyListeners();

    final response = await _service.sentMail(email,context);
    _sendmail=response as Map<String, dynamic>?;
    notifyListeners();

    isLoading=false;
    notifyListeners();
  }


  //verify password otp
  verifyPassOtp({
    required String email,
    required BuildContext context,
    required String code,
  }) async {
    isLoading = true;
    notifyListeners();

    final response = await _service.PassVeri(email,code,context);
    _verify=response as Map<String, dynamic>?;
    notifyListeners();

    isLoading=false;
    notifyListeners();
  }







  //Login
  void loginUser({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    isLoading = true;
    notifyListeners();

    // final bodya={
    //   "ema": encryp(email),
    //   "pass": encryp(password),
    // };

    final response = await _service.LoginUz(email,password, context);
    _login=response as Map<String, dynamic>?;
    isLoading=false;
    notifyListeners();
  }


  //Login
  passReset({
    required String password,
    required BuildContext context, required String email
  }) async {
    isLoading = true;
    notifyListeners();

    final response = await _service.Reset(password, context,email);
    _reset=response;
    isLoading=false;
    notifyListeners();
  }



  logOUT({required BuildContext context}) async {

    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.remove("cust_id");
    sharedPreferences.remove("cust_fname");
    sharedPreferences.remove("cust_lname");
    sharedPreferences.remove("cust_email");
    sharedPreferences.remove("cust_phone");
    sharedPreferences.remove("cust_location");
    sharedPreferences.remove("cust_photo");
    sharedPreferences.remove("cust_password");
    sharedPreferences.remove("cust_country");
    sharedPreferences.remove("cust_created_on");

   if(context.mounted){
     Navigator.pushReplacementNamed(context, Dashboard.id);
   }

    notifyListeners();
  }





  void setfNem(String fnem) {
    _fnem = fnem;
    notifyListeners();
  }

  void setLNem(String lnem) {
    _lnem = lnem;
    notifyListeners();
  }

  void setMail(String mail) {
    _mail = mail;
    notifyListeners();
  }

  void setPhone(String num) {

    _phone = num;
    notifyListeners();
  }

  void setLoc(String loc) {

    _loc = loc;
    notifyListeners();
  }

  void setPic(String pic) {
    _photo = pic;
    notifyListeners();
  }

  void setPass(String pass) {
    _pass = pass;
    notifyListeners();
  }

  void setCount(String count) {
    _count = count;
    notifyListeners();
  }

  void setDate(String date) {
    _date = date;
    notifyListeners();
  }


  void setUserId(String userid) {
    _uid = userid;
    notifyListeners();
  }



 }


