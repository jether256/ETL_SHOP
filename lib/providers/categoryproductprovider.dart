import 'dart:io';

import 'package:flutter/cupertino.dart';

import '../api/services/ecom.dart';
import '../models/productmodel.dart';

class CategoryProductProvider with ChangeNotifier {

  ApiCall _service = new ApiCall();
  bool isLoading = false;

  bool noNet=false;
  String _resMessage = '';


  List<ProductModel> _catpros = [];
  List<ProductModel> get catpros => _catpros;

  List<ProductModel> _all = [];
  List<ProductModel> get all => _all;

  String get resMessage => _resMessage;



  getAllCategoryProducts( String id) async {

    try{


      isLoading = true;
      noNet=false;
      notifyListeners();

      final response = await _service.getCatPro(id);
      _catpros = response!;
      isLoading = false;
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


  // all products
  getAllProCat() async{

    try{

      isLoading = true;
      noNet=false;
      notifyListeners();
      final response = await _service.getPro();
      _all = response!;
      isLoading = false;
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
