
import 'dart:io';

import 'package:edge_app/api/services/ecom.dart';
import 'package:edge_app/models/productmodel.dart';
import 'package:flutter/cupertino.dart';

import '../models/categorymodel.dart';

class CategoriesProvider with ChangeNotifier{

   final ApiCall _service=new  ApiCall();


  bool isLoading=false;

  bool noNet=false;
   String _resMessage = '';


  List<CategoryModel> _categs=[];
  List<CategoryModel> get categs =>_categs;

   String? _all="All";

   List<CategoryModel> _categsPlus=[];

   List<CategoryModel> get categsPlus =>_categsPlus;

   String get resMessage => _resMessage;




  List<ProductModel> _proda=[];
   List<ProductModel> get proda => _proda;


   Future <void> getAllCats() async{


     try{

       isLoading=true;
       noNet=false;

       notifyListeners();
       final response=await _service.geCat();
       _categs=response!;
       isLoading=false;
       noNet=false;

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





   ///get cat product by category id
   getProda({
     required String id,
   }) async {

     try{


       isLoading = true;
       noNet=false;
       notifyListeners();

       final response = await _service.getCatPro(id);
       _proda=response!;
       notifyListeners();

       isLoading=false;
       noNet=false;
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


}