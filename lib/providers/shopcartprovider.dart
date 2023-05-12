
import 'dart:io';

import 'package:edge_app/api/services/ecom.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../dashboard+Screens/ecommerce/shippingdetails/shipping.dart';
import '../models/cartmodel.dart';

class ShoppingCartProvider extends ChangeNotifier{

 ApiCall _service= new ApiCall();

 bool isLoading=false;


 bool noNet=false;
 String _resMessage = '';

 bool cod=false;

 List<CartModel> _cart=[];

 List<CartModel> get cart => _cart;


 List<CartModel> _mane=[];

 List<CartModel> get mane => _mane;


 Map<String,dynamic>? _add;
 Map<String,dynamic> get data =>_add!;

 Map<String,dynamic>? _update;
 Map<String,dynamic> get update =>_update!;

 Map<String,dynamic>? _delete;
 Map<String,dynamic> get delete =>_delete!;

 Map<String,dynamic>? _total;
 Map<String,dynamic>? get total => _total;

 Map<String,dynamic>? _check;
 Map<String,dynamic>? get check => _check;


 Map<String,dynamic>? _checkout;
 Map<String,dynamic>? get checkout => _checkout;

 var _sumPrice=0;
  get sumPrice => _sumPrice;

 var _count;
 get count => _count;


 var _totalSum=0;
  get totalSum => _totalSum;



 String get resMessage => _resMessage;




 ///get all cart products
 Future <void> getAllCart()async {

  try{

   //_cart.clear();
   //isLoading=true;
   noNet=false;
   notifyListeners();
   final response= await _service.getCart();
   _cart=response!;
   noNet=false;
   notifyListeners();

   count2();
   notifyListeners();

   getTotal();
   //isLoading=false;
   notifyListeners();



  }on SocketException catch (_) {

   isLoading= false;
   noNet=true;
   _resMessage = "Internet connection is not available`";
   notifyListeners();

  } catch (e) {

   isLoading = false;
   noNet=false;
   _resMessage = "Please try again`";
   notifyListeners();
   print(":::: $e");

  }

 }



 ///add to cart
 CartAdd({
  required String id,
  required String selp,
  required String regp,
  required String promoid,
  required BuildContext context,
 }) async {
  isLoading = true;
  notifyListeners();

  final response = await _service.addToCart(id,selp,regp,promoid,context);
  _add=response;
  notifyListeners();

  count2();
  notifyListeners();

  refresh();
  notifyListeners();

  getTotal();
  notifyListeners();

  isLoading=false;
  notifyListeners();
 }





  refresh(){
  getAllCart();
 }

 refreshTotal(){
  getTotal();
 }


 count2(){
  getCartCount();
 }


 ///update quantity
 updateQuanity({
  required String catid,
  required String quant,
  required BuildContext context,
 }) async{

  final response = await _service.updateQaunt(catid,quant,context);
  _update=response;
  notifyListeners();

  refresh();
  notifyListeners();

  count2();
  notifyListeners();

  getTotal();
  notifyListeners();
 }


 ///delete from cart
 deleteCartItem({
  required String catid,
  required BuildContext context,
 }) async{

  final response = await _service.delCart(catid,context);
  _delete=response;
  notifyListeners();

  refresh();
  notifyListeners();

  count2();
  notifyListeners();

  getTotal();
  notifyListeners();
 }





 ///Total cart
 getTotal() async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  String? ID = pref.getString('cust_id');

  if (ID != null) {
   final response = await _service.getCartTotal();
   if(response != null){

    _sumPrice  = response;
    notifyListeners();

   }else{
    _sumPrice=0;
    notifyListeners();
   }
   //
   // notifyListeners();
  }else{
   _sumPrice=0;
   notifyListeners();
  }


 }


///cart count
 getCartCount() async{

  SharedPreferences pref= await SharedPreferences.getInstance();
  String? ID=pref.getString('cust_id');

  if(ID != null){
   final response= await _service.getCount();
   _count=response;
   notifyListeners();
  }else{
   _count=0;
   notifyListeners();
  }


 }


 //choose payment method on cart page
 getPaymentMethod(positive){
  if(positive== false){

 cod=true;
 notifyListeners();

  }else{

cod=false;
notifyListeners();
  }


 }


 //check shipment address
 checkSip({
  required BuildContext context,
 }) async{

  isLoading = true;
  notifyListeners();


  final response = await _service.checkShip(context);





  _check=response;
  notifyListeners();

  isLoading=false;
  notifyListeners();

 }


 //add shipping details
 addShip({
 required String firstName,required String lastName,required String email,required String address,
  required String phone,required String country,required BuildContext context,
}) async {

final response = await _service.saveShip(firstName,lastName,email,address,phone,country,context);
_add=response;
notifyListeners();

isLoading=false;
notifyListeners();

}


 ///checkOut
 checkOut({
  required BuildContext context, required String method,
 }) async {
  // isLoading = true;
  // notifyListeners();

  final response = await _service.Check(context,method);

  if(response != null){

   _checkout=response;
   notifyListeners();
   //
   // isLoading=false;
   // notifyListeners();

   refresh();
   notifyListeners();

   refreshTotal();
   notifyListeners();

  }else{

   if(context.mounted){

    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
         content: const Text("Please Cart is empty"),
         backgroundColor: Colors.green.withOpacity(0.9),
         elevation: 10, //shadow
        )
    );
   }

   _sumPrice=0;
   notifyListeners();

  }

 }



}

